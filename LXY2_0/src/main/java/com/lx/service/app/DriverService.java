package com.lx.service.app;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.lx.dao.DaoSupport;
import com.lx.util.PageData;

@Service
@Transactional
public class DriverService {

	@Resource
	private DaoSupport dao;
	
	
	public PageData getDriversList(PageData param) throws Exception{
		
		@SuppressWarnings("unchecked")
		List<PageData> driverList = (List<PageData>) dao.findForList("DriverMapper.getDriverList", param);
		Integer total = (Integer) dao.findForObject("DriverMapper.getDriversCount", param);
		param.clear();
		param.put("data", driverList);
		param.put("recordsTotal", total);
		param.put("recordsFiltered", total);
		return param;
	}
	
	public void save(PageData param) throws Exception{
		
		dao.save("DriverMapper.save", param);
	}
	
	public PageData getDriverByCarId(Long carId) throws Exception{
		return (PageData) dao.findForObject("DriverMapper.getDriverByCarId", carId);
	}
	
	public void update(PageData param) throws Exception{
		
		dao.update("DriverMapper.update", param);
	}
	
	
	@SuppressWarnings("unchecked")
	public List<PageData> getDriverList() throws Exception{
		
		return (List<PageData>) dao.findForList("DriverMapper.getAllDriverNamesAndIds", null);
		
	}

	public PageData getDriverById(Long driverId) throws Exception {
		return (PageData) dao.findForObject("DriverMapper.getDriverById", driverId);
	}
	
	public void lgcDelDriverById(Long driverId) throws Exception{
		
		dao.delete("DriverMapper.lgcDeldriverById", driverId);
	}
	
	
}
