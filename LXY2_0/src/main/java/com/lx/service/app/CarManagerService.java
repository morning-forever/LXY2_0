package com.lx.service.app;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.lx.bo.LockCar;
import com.lx.bo.NeedCar;
import com.lx.dao.DaoSupport;
import com.lx.exception.CarNotEnoughException;
import com.lx.util.HString;
import com.lx.util.PageData;


@Service
@Transactional
@SuppressWarnings("unchecked")
public class CarManagerService {
	
	@Resource
	private DaoSupport dao;
	
	@Resource
	private DriverService driverService;
	/****************gcy  ***********************/
	/*获取车辆信息列表
	 * */
	public PageData getCarInfoList(PageData param) throws Exception{
		Integer total = (Integer) dao.findForObject("CarManagerMapper.getCarInfoListCount", param);
		List<PageData> list = (List<PageData>)dao.findForList("CarManagerMapper.getCarInfoList", param);
		param.clear();
		param.put("data", list);
		param.put("recordsTotal", total);
		param.put("recordsFiltered", total);
		return param;
	}
	
	public void addCarInfo(PageData pd) throws Exception {
		dao.save("CarManagerMapper.insertOneCar", pd);
	}
	
	public void deleteOneCar(Long id) throws Exception{
		dao.delete("CarManagerMapper.deleteOneCar", id);
	}
	
	public void logicDelOneCar(Long id) throws Exception{
		dao.update("CarManagerMapper.logicDelOneCar", id);
	}
	
	public PageData getCarInfoById(Long id) throws Exception{
		return (PageData) dao.findForObject("CarManagerMapper.getOneCarById", id);
	}
	
	public void updateOneCar(PageData param) throws Exception{
		dao.update("CarManagerMapper.updateOneCar", param);
	}
	
	public void associateDriver(PageData param) throws Exception{
		driverService.save(param);
		dao.update("CarManagerMapper.bindDriver", param);
	}
	
	
	/*获取车辆使用信息
	 * */
	public PageData getUseCarList(PageData param) throws Exception{
		Integer total = (Integer) dao.findForObject("CarStateMapper.getCarStateCount", param);
		List<PageData> list = (List<PageData>)dao.findForList("CarStateMapper.getCarStateList", param);
		param.clear();
		param.put("data", list);
		param.put("recordsTotal", total);
		param.put("recordsFiltered", total);
		return param;
	}
	
	/**
	 * 获得所有可使用车辆
	 * @param pd
	 * @return 所有可使用车辆
	 * @throws Exception
	 */
	public List<PageData> getAvailableCars(PageData pd) throws Exception{
			
		List<PageData> carTypeList = (List<PageData>) dao.findForList("CarManagerMapper.getAvailableCars",pd);
			
		return carTypeList;
	}
	

	/**
	 * @param lockCar
	 * @return 返回已锁定车辆
	 * @throws Exception
	 */
	public PageData lockCar(LockCar lockCar) throws Exception{
		
		PageData res = new PageData();
		
		//1.查出具体要分配的车（也就是将要被锁定的车）
		List<PageData> willBeLockedCars = (List<PageData>) dao.findForList("CarManagerMapper.getWillBeLockedCars", lockCar);
		
		//2.判断车是否足够
		List<NeedCar> needCars = lockCar.getNeedCars();
		
		StringBuffer sb = new StringBuffer();
		for(NeedCar needCar : needCars ){
			
			Long typeId = needCar.getTypeId();
			
			int actualCount=0;
			
			for(PageData pageData : willBeLockedCars){
				
				if(typeId == pageData.getLong("typeId")){
					
					 actualCount++;
				}
			}
			
			if(actualCount<needCar.getCount()){//如果当前类型车辆不够，则整理出当前车辆类型“不足”的信息，以备后面传到前端去展示
				
				for(PageData pageData : willBeLockedCars){
					
					if(typeId == pageData.getLong("typeId")){
						
						sb.append(pageData.getString("name")+"已不够"+needCar.getCount()+"辆,只有"+actualCount+"辆了;");
						
						break ;
					}
					
				}
			}
		}
		
		if(!HString.isEmpty(sb.toString())){//如果sb不为空，则说明车辆不够
			
			throw new CarNotEnoughException(sb.toString());
			
		}
		
		//3.批量 锁定车辆
		lockCar.setWillBeLockedCars(willBeLockedCars);
		
		dao.save("CarManagerMapper.lockCars", lockCar);
		
		res.put("lockedCars", willBeLockedCars);
		
		//4.查出锁车信息的id列表（car_state_ids）,ids查出来的是数组，将其转化为字符串，以逗号分隔（也就是去除[]）
		List<Long> carStateIds = (List<Long>) dao.findForList("CarManagerMapper.getCarStateIds", lockCar);
		
		res.put("carStateIds", carStateIds);
		
		//5.批量更新车的出行率（其实是出行次数trip_times+1）
		dao.update("CarManagerMapper.batchUpdateCarTripTimes", willBeLockedCars);
		
		return  res;
	}
	
	/**
	 * 释放车辆
	 * @param carStateIds
	 * @throws Exception
	 */
	public void freeCars(List<Long> carStateIds) throws Exception{
		dao.update("CarStateMapper.freeCars", carStateIds);
	}
	
	public String getCarUseStaById(Long  carStaId) throws Exception{
		
		return (String) dao.findForObject("CarStateMapper.getUseStateById",carStaId );
	}
}
