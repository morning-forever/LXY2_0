package com.lx.controller.system.lxy;

import javax.annotation.Resource;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.lx.controller.base.BaseController;
import com.lx.entity.system.User;
import com.lx.service.app.CarManagerService;
import com.lx.service.app.CarTypeManService;
import com.lx.service.app.DriverService;
import com.lx.util.Const;
import com.lx.util.HString;
import com.lx.util.PageData;
import com.lx.util.XConst;

@Controller
@RequestMapping(value="admin/lxy/driver")
public class AdminDriverController extends BaseController{
	
	@Resource
	private DriverService driverService;
	
	@Resource
	private CarManagerService carManagerService;
	
	@Resource 
	private CarTypeManService carTypeManService;

	@RequestMapping("main")
	public ModelAndView main() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("system/lxy/driver/list");
		
		return mav;
	}
	

   @RequestMapping("listdata")
   @ResponseBody
   public PageData data(){
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
					param.put("tel", json.get("tel"));
				}
				res = driverService.getDriversList(param);
			}
			
		} catch (Exception e) {
			res.putStatus(XConst.EXCEPTION);
			e.printStackTrace();
		}
		return res;
   }
   
   @RequestMapping("addUI")
   public ModelAndView addUI() throws Exception{
		
		return new ModelAndView("system/lxy/driver/addUI");
   }
   
   
   @RequestMapping("add")
   @ResponseBody
   public PageData add(){
	   PageData param = getPageData();
	   PageData res = new PageData();
	   try {
		   driverService.save(param);
		   res.putStatus(XConst.SUCCESS);
	   } catch (Exception e) {
			e.printStackTrace();
			res.putStatus(XConst.FAIL);
		}
	   
	   return res;
   }
   
   
   @RequestMapping("delete/{driverId}")
   @ResponseBody
   public PageData delete(@PathVariable Long driverId){
		PageData res = new PageData();
		try {
			driverService.lgcDelDriverById(driverId);
			res.putStatus(XConst.SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			res.putStatus(XConst.FAIL);
		}

		return res;
   }
   
   @RequestMapping("editUI/{driverId}")
   public ModelAndView editUI(@PathVariable Long driverId) throws Exception{
		
		ModelAndView mav = new ModelAndView("system/lxy/driver/editUI");
		
		PageData driver = driverService.getDriverById(driverId);
		
		mav.addObject("driver", driver);
		
		return mav;
	   
   }
   
   @RequestMapping("edit")
   @ResponseBody
   public PageData edit(){
	   PageData param = getPageData();
	   PageData res = new PageData();
	   try {
		   driverService.update(param);
		res.putStatus(XConst.SUCCESS);
	} catch (Exception e) {
		e.printStackTrace();
		res.putStatus(XConst.FAIL);
	}
	   
	   return res;
	   
	   
   }
	
}
