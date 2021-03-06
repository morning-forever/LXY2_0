package com.lx.service.app;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.lx.dao.DaoSupport;
import com.lx.util.PageData;

@Service
@Transactional
@SuppressWarnings("unchecked")
public class DefaultRouteManagerService {
	
	@Resource
	private DaoSupport dao;
	

	public Long addDefaultRoute(PageData pd) throws Exception {
		dao.save("DefaultRouteManagerMapper.addDefaultRoute",pd);
		return pd.getLong("id");
	}
	
	
	public void updateDefaultRoute(PageData pd) throws Exception {
		dao.update("DefaultRouteManagerMapper.updateDefaultRoute",pd);
	}
	
	public PageData getDefaultRouteById(Long id) throws Exception {
		return (PageData)dao.findForObject("DefaultRouteManagerMapper.getDefRouById", id);
	}
	
	public void logicDelDefRouById(Long id) throws Exception{
		
		dao.update("DefaultRouteManagerMapper.logicDelById", id);
	}
	
	public PageData findAdminDefaultRouteList(PageData param) throws Exception {
		Integer total = (Integer) dao.findForObject("DefaultRouteManagerMapper.getDefaultRouteCount", param);
		List<PageData> list = (List<PageData>)dao.findForList("DefaultRouteManagerMapper.getDefaultRoute", param);
		param.clear();
		param.put("data", list);
		param.put("recordsTotal", total);
		param.put("recordsFiltered", total);
		return param;
	}
	
	
	public List<PageData> getRouteListByKw(PageData kw) throws Exception{
		
		return (List<PageData>) dao.findForList("DefaultRouteManagerMapper.getRouteListByKw", kw);
	}
}
