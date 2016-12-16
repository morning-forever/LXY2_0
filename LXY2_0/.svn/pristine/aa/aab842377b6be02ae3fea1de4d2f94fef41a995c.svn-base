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
import com.lx.service.app.DefaultRouteManagerService;
import com.lx.util.Const;
import com.lx.util.HString;
import com.lx.util.Jurisdiction;
import com.lx.util.PageData;
import com.lx.util.XConst;

/** 
 * 类名称：
 * 创建人 
 * 创建时间：
 */
@Controller
@RequestMapping(value="admin/lxy/default_route")
public class AdminDefaultRouteManagerController extends BaseController {
	
	String menuUrl = "admin/lxy/default_route/list.do"; //菜单地址(权限用)
	
	@Autowired
	private DefaultRouteManagerService routeService;
	
	
	
	
	/**
	 * 删除
	 */
	@RequestMapping(value="/delete/{id}")
	@ResponseBody
	public PageData delete(@PathVariable Long id){
		logBefore(logger, "删除默认路线");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData res = new PageData();
		try{
			routeService.logicDelDefRouById(id);
			res.putStatus(XConst.SUCCESS);
		} catch(Exception e){
			res.putStatus(XConst.EXCEPTION);
			logger.error(e.toString(), e);
		}
		
		return res;
	}
	
	
	
	
	@RequestMapping(value = "/listdata")
	@ResponseBody
	public PageData listdata() {
		PageData res = new PageData();
		try {
			PageData param = getSysPageData();
			String search = param.getString("search[value]");
			Integer orderColumn = param.getInt("order[0][column]");
			String sortOrder = param.getString("order[0][dir]");
			
			if(!HString.isEmpty(sortOrder)){
				param.put("sortOrder",sortOrder );
			}
			
			if(orderColumn != null){
				String orderColumnName = param.getString("columns["+orderColumn+"][data]");
				param.put("orderColumnName", orderColumnName);
			}
			
			if (!HString.isEmpty(search)) {
				JSONObject json = JSON.parseObject(search);
				param.put("routeName", json.get("routeName"));
				param.put("dayNum", json.get("dayNum"));
			}
			res = routeService.findAdminDefaultRouteList(param);
		} catch (Exception e) {
			res.putStatus(XConst.EXCEPTION);
			e.printStackTrace();
		}
		return res;
	}
	/**
	 * 列表
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(){
		logBefore(logger, "列表默认路线");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			String KEYWORD = pd.getString("KEYWORD");
			if(null != KEYWORD && !"".equals(KEYWORD)){
				pd.put("KEYWORD", KEYWORD.trim());
			}
			
			mv.setViewName("system/lxy/route/default_route_list");
			mv.addObject("pd", pd);
			mv.addObject(Const.SESSION_QX,this.getHC());	//按钮权限
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	@RequestMapping("addUI")
	public ModelAndView addUI() throws Exception{
		
		ModelAndView mav = new ModelAndView("system/lxy/route/addUI");
		
		return mav;
	}
	

	/**
	 * 新增
	 */
	@RequestMapping(value="/add")
	@ResponseBody
	public PageData save(){
		
		logBefore(logger, "新增默认路线");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		
		PageData res = new PageData();
		PageData pd = this.getPageData();
		
		try {
			routeService.addDefaultRoute(pd);
		} catch (Exception e) {
			res.putStatus(XConst.EXCEPTION);
			e.printStackTrace();
		}
		res.putStatus(XConst.SUCCESS);
		
		return res;
	}

	
	@RequestMapping("editUI/{id}")
	public ModelAndView detailPage(@PathVariable Long id) throws Exception{
		
		ModelAndView mav = new ModelAndView("system/lxy/route/editUI");
		PageData defaultRoute = routeService.getDefaultRouteById(id);
		mav.addObject("defaultRoute", defaultRoute);
		return mav;
	}
	
	/**
	 * 修改
	 */
	@RequestMapping(value="/edit")
	@ResponseBody
	public PageData edit(){
		logBefore(logger, "修改默认路线");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		PageData pd = this.getPageData();
		try {
			routeService.updateDefaultRoute(pd);
			pd.clear();
			pd.putStatus(XConst.SUCCESS);
		} catch (Exception e) {
			pd.putStatus(XConst.EXCEPTION);
			e.printStackTrace();
		}
		
		return pd;
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
