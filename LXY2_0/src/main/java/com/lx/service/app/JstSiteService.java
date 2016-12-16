package com.lx.service.app;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.lx.dao.DaoSupport;
import com.lx.util.PageData;

/**
 * 接送团地点服务类
 * @author Administrator
 *
 */
@Service
@Transactional
@SuppressWarnings("unchecked")
public class JstSiteService {
	
	@Resource
	private DaoSupport dao;
	
	/**
	 * 通过关键字(key words)获取接送团地点列表
	 * @param kw
	 * @return
	 * @throws Exception 
	 */
	public List<PageData> getJstSiteListByKw(String kw) throws Exception{
		return (List<PageData>) dao.findForList("JstSiteMapper.getJstSiteListByKw", kw);
	}
	
	
	public Long addOneJstSite(PageData pd) throws Exception {
		dao.save("JstSiteMapper.addOneJstSite", pd);
		return pd.getLong("id");
		
	}
	
	public void lgcDelJstSite(Long id) throws Exception {
		dao.update("JstSiteMapper.lgcDelJstSite", id);
	}
	
	public void updateJstSite(PageData pd) throws Exception {
		dao.save("JstSiteMapper.updateOneJstSite", pd);
	}
	
	
	/*后台获取附加信息列表
	 * */
	
	public PageData getJstSiteById(Long id) throws Exception {
		return (PageData)dao.findForObject("JstSiteMapper.getJstSiteById", id);
	}
	
	public PageData getJstSiteList(PageData param) throws Exception{
		Integer total = (Integer) dao.findForObject("JstSiteMapper.getJstSiteCount", param);
		List<PageData> list = (List<PageData>)dao.findForList("JstSiteMapper.getJstSiteList", param);
		param.clear();
		param.put("data", list);
		param.put("recordsTotal", total);
		param.put("recordsFiltered", total);
		return param;
	}
}
