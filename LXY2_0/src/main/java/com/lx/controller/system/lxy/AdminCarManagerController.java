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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.lx.controller.base.BaseController;
import com.lx.entity.system.User;
import com.lx.service.app.CarManagerService;
import com.lx.util.Const;
import com.lx.util.HString;
import com.lx.util.PageData;
import com.lx.util.XConst;
/** 
 * 类名称：
 * 创建人： 
 * 创建时间：
 */
@Controller
@RequestMapping(value="admin/lxy/car")
public class AdminCarManagerController extends BaseController {
	
	String menuUrl = "use_list.do"; //菜单地址(权限用)
	String menuUrl1 = "list.do"; //菜单地址(权限用)
	
	@Autowired
	private CarManagerService carManagerService;
	
	@RequestMapping("use_list")
	public ModelAndView list() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("system/lxy/car/use_list");
		try {
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return mav;
	}
	
	
	@RequestMapping(value = "use_list/data")
	@ResponseBody
	public PageData listData() {
		PageData res = new PageData();
		try {
			System.out.println("----------use_list_data----------");
			PageData param = getSysPageData();
			//shiro管理的session
			Subject currentUser = SecurityUtils.getSubject();  
			Session session = currentUser.getSession();
			User user = (User)session.getAttribute(Const.SESSION_USER);
			if (user != null) {
				String search = param.getString("search[value]");
				if (!HString.isEmpty(search)) {
					JSONObject json = JSON.parseObject(search);
					param.put("startTime", json.get("startTime"));
					param.put("endTime", json.get("endTime"));
					param.put("userName", json.get("userName"));
					param.put("carName", json.get("carName"));
					param.put("plateNum", json.get("plateNum"));
					
					System.out.println("---------listdata----------orderCode"+json.get("orderCode"));
				}
				res = carManagerService.getUseCarList(param);
			}
			
		} catch (Exception e) {
			res.putStatus(XConst.EXCEPTION);
			e.printStackTrace();
		}
		return res;
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

