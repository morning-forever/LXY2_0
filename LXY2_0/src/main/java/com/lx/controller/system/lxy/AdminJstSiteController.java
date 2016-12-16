package com.lx.controller.system.lxy;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.lx.controller.base.BaseController;
import com.lx.entity.system.User;
import com.lx.service.app.JstSiteService;
import com.lx.util.Const;
import com.lx.util.HString;
import com.lx.util.Jurisdiction;
import com.lx.util.PageData;
import com.lx.util.XConst;


@Controller
@RequestMapping(value="admin/lxy/add_svc")
public class AdminJstSiteController extends BaseController{
	String menuUrl = "admin/lxy/add_svc/list.do"; //菜单地址(权限用)
	
	@Autowired
	private JstSiteService jstSiteService;
	 
	
	@RequestMapping("list")
	public ModelAndView list() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("system/lxy/add_svc/list");
		try {
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return mav;
	}
	
	
	@RequestMapping(value = "list/data")
	@ResponseBody
	public PageData listData() {
		PageData res = new PageData();
		try {
			PageData param = getSysPageData();
			//shiro管理的session
			Subject currentUser = SecurityUtils.getSubject();  
			Session session = currentUser.getSession();
			User user = (User)session.getAttribute(Const.SESSION_USER);
			if (user != null) {
				String search = param.getString("search[value]");
				if (!HString.isEmpty(search)) {
					JSONObject json = JSON.parseObject(search);
					param.put("name", json.get("name"));
					
					System.out.println("---------listdata----------orderCode"+json.get("orderCode"));
				}
				res = jstSiteService.getJstSiteList(param);
			}
			
		} catch (Exception e) {
			res.putStatus(XConst.EXCEPTION);
			e.printStackTrace();
		}
		return res;
	}
	
	
	/**
	 * 删除
	 */
	@RequestMapping(value="/delete/{id}")
	@ResponseBody
	public PageData delete(@PathVariable Long id){
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData res = new PageData();
		try{
			jstSiteService.lgcDelJstSite(id);
			res.putStatus(XConst.SUCCESS);
			
		} catch(Exception e){
			logger.error(e.toString(), e);
			res.putStatus(XConst.EXCEPTION);
		}
		return res;
	}
	
	/**
	 * 保存
	 */
	@RequestMapping(value="/add")
	@ResponseBody
	public PageData add(){
		PageData res = new PageData();
		try{
			PageData pd = this.getPageData();
			jstSiteService.addOneJstSite(pd);
			
			res.putStatus(XConst.SUCCESS);
		} catch(Exception e){
			logger.error(e.toString(), e);
			
			res.putStatus(XConst.FAIL);
		}
		
		return res;
	}
	
	
	
	/**
	 * 修改页面
	 */
	@RequestMapping(value="/editUI/{id}")
	public ModelAndView editUI(@PathVariable Long id) throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData jstSite = jstSiteService.getJstSiteById(id);
		
		mv.addObject("jstSite",jstSite);
		mv.setViewName("system/lxy/add_svc/editUI");
		return mv;
	}
	
	/**
	 * 修改
	 * @return
	 */
	@RequestMapping(value="/edit")
	@ResponseBody
	public PageData update(){
		PageData res = new PageData();
		try{
			PageData pd = this.getPageData();
			jstSiteService.updateJstSite(pd);
			
			res.putStatus(XConst.SUCCESS);
		} catch(Exception e){
			logger.error(e.toString(), e);
			
			res.putStatus(XConst.FAIL);
		}
	
		return res;
	}
	
	/**
	 * 新增页面
	 */
	@RequestMapping(value="addUI")
	public ModelAndView goAdd(){
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		try {
			mv.setViewName("system/lxy/add_svc/addUI");
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}						
		return mv;
	}	
	
	/* ===============================权限================================== */
	@SuppressWarnings("unchecked")
	public Map<String, String> getHC(){
		Subject currentUser = SecurityUtils.getSubject();  //shiro管理的session
		Session session = currentUser.getSession();
		return (Map<String, String>)session.getAttribute(Const.SESSION_QX);
	}
	/* ===============================权限================================== */
	
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
	
}
