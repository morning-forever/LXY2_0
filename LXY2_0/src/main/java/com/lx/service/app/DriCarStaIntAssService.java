package com.lx.service.app;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.lx.dao.DaoSupport;
import com.lx.util.PageData;
import com.lx.util.XConst;

@Transactional
@Service
public class DriCarStaIntAssService {
	
	@Resource
	private DaoSupport dao;
	
	/**
	 * getAllDriverNamesAndIds
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> getIdleDris(PageData param) throws Exception{
	
		return (List<PageData>) dao.findForList("DriCarStaIntAssMapper.getIdlDris", param);
	
	}
	
	public void carStaAssDriAdd(PageData param) throws Exception{
		//从lxy_car_state 表查driverId，看看司机是否空闲（加锁）
		Long  driverId = (Long) dao.findForObject("DriCarStaIntAssMapper.getDriId", param);
		if(driverId !=null){
			param.clear();
			param.putStatus(XConst.DRIVER_STATE.BUSY);
		}else{
			dao.update("DriCarStaIntAssMapper.carStaAssDri", param);
			param.clear();
			param.putStatus(XConst.SUCCESS);
		}
		
	}
	
	public PageData getDriverByCarId(Long carId) throws Exception{
		
		return (PageData) dao.findForObject("DriCarIntAssMapper.getDriverByCarId", carId);
	}
	
	

}
