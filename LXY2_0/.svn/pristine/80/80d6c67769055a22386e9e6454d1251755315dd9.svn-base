package com.lx.service.app;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.lx.util.PageData;
import com.lx.dao.DaoSupport;


/**
 * 反馈信息操作类
 * @author 
 * <br>
 * 
 */
@Service
@Transactional
public class FeedbackService {
	
	@Resource(name="daoSupport")
	private DaoSupport dao;

	/**
	 * 添加一个反馈信息
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public boolean addFeedback(PageData param) throws Exception{
		int count = (int) dao.save("LxyFeedbackMapper.addFeedback", param);
		return  count > 0;
	}
	
	/**
	 * 后台获取反馈列表
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public PageData feedbackList(PageData param) throws Exception {
		Integer total = (Integer) dao.findForObject("LxyFeedbackMapper.findFeedbackListCount", param);
		param.put("data", dao.findForList("LxyFeedbackMapper.findFeedbackList", param));
		param.put("recordsTotal", total);
		param.put("recordsFiltered", total);
		return param;
	}
	
	
	public PageData feedbackDetail(Long id) throws Exception{
		PageData param = new PageData();
		param.put("id", id);
		return (PageData) dao.findForObject("LxyFeedbackMapper.feedbackDetail", param);
	}
	
	public boolean dels(Long id) throws Exception{
		PageData param = new PageData();
		param.put("id", id);
		return (Integer)dao.delete("LxyFeedbackMapper.dels", param) > 0;
	}
	
}
