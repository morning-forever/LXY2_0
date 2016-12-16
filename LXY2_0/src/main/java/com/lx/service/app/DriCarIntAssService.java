package com.lx.service.app;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.lx.dao.DaoSupport;
import com.lx.util.PageData;

@Transactional
@Service
public class DriCarIntAssService {
	
	@Resource
	private DaoSupport dao;
	
	/**
	 * getAllDriverNamesAndIds
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> getAllDriNamsAndIds() throws Exception{
	
		return (List<PageData>) dao.findForList("DriCarIntAssMapper.getAllDriNamsAndIds", null);
	
	}
	
	public void carAssDriAdd(PageData param) throws Exception{
		
		dao.update("DriCarIntAssMapper.carAssDri", param);
	}
	
	public PageData getDriverByCarId(Long carId) throws Exception{
		
		return (PageData) dao.findForObject("DriCarIntAssMapper.getDriverByCarId", carId);
	}
	
	

}
