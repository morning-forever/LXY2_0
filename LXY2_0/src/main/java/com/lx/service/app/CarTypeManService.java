package com.lx.service.app;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.lx.dao.DaoSupport;
import com.lx.util.PageData;


@Service
@Transactional
public class CarTypeManService {
	
	@Resource(name="daoSupport")
	private DaoSupport dao;
	
	
	/*获取车辆类型
	 * */
	public PageData getCarTypeList(PageData param) throws Exception{
		
		Integer total = (Integer) dao.findForObject("CarTypeMapper.getCarTypeListCount", param);
		
		@SuppressWarnings("unchecked")
		List<PageData> list = (List<PageData>)dao.findForList("CarTypeMapper.getCarTypeList", param);
		param.clear();
		param.put("data", list);
		param.put("recordsTotal", total);
		param.put("recordsFiltered", total);
		return param;
	}
	
	
	public void saveCarType(PageData param) throws Exception{
		dao.save("CarTypeMapper.save", param);
	}
	
	
	public void delete(Long id) throws Exception{
		dao.delete("CarTypeMapper.delete", id);
	}
	
	public PageData getCarTypeById(Long id) throws Exception{
		return (PageData) dao.findForObject("CarTypeMapper.getCarTypeById", id);
	}
	
	public void update(PageData carType) throws Exception{
		dao.update("CarTypeMapper.update", carType);
	}
}
