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
import com.lx.util.Const;
import com.lx.util.HString;
import com.lx.util.PageData;
import com.lx.util.XConst;

@Controller
@RequestMapping(value="admin/lxy/car/base_info")
public class AdminCarInfoManController extends BaseController{
	
	
	@Resource
	private CarManagerService carManagerService;
	
	@Resource 
	private CarTypeManService carTypeManService;

	@RequestMapping("list")
	public ModelAndView list() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("system/lxy/car/base_info_list");
		
		return mav;
	}
	

   @RequestMapping("data")
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
					param.put("carTypeName", json.get("carTypeName"));
					param.put("plateNumber", json.get("plateNumber"));
					param.put("seatNum", json.get("seatNum"));
					param.put("price", json.get("price"));
				}
				res = carManagerService.getCarInfoList(param);
			}
			
		} catch (Exception e) {
			res.putStatus(XConst.EXCEPTION);
			e.printStackTrace();
		}
		return res;
   }
   
   @RequestMapping("addUI/{typeId}")
   public ModelAndView addUI(@PathVariable Long typeId) throws Exception{
		ModelAndView mav = new ModelAndView("system/lxy/car/car_addUI");

		PageData carType = carTypeManService.getCarTypeById(typeId);

		mav.addObject("carType", carType);

		return mav;
   }
   
   
   @RequestMapping("add")
   @ResponseBody
   public PageData add(){
	   PageData param = getPageData();
	   PageData res = new PageData();
	   
		try {
			carManagerService.addCarInfo(param);
			res.putStatus(XConst.SUCCESS);
		} catch (Exception e) {

			e.printStackTrace();
			if (e instanceof org.springframework.dao.DuplicateKeyException) {
				res.putStatus(XConst.EXISTS);
			} else {
				res.putStatus(XConst.FAIL);
			}
		}
	   
	   return res;
   }
   
   
   @RequestMapping("delete/{id}")
   @ResponseBody
   public PageData delete(@PathVariable Long id){
		PageData res = new PageData();
		try {
			carManagerService.deleteOneCar(id);
			res.putStatus(XConst.SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			res.putStatus(XConst.FAIL);
		}

		return res;
   }
   
   @RequestMapping("editUI/{id}")
   public ModelAndView editUI(@PathVariable Long id) throws Exception{
		
		ModelAndView mav = new ModelAndView("system/lxy/car/car_editUI");

		PageData car = carManagerService.getCarInfoById(id);
		mav.addObject("car", car);
		return mav;
	   
   }
   
   @RequestMapping("edit")
   @ResponseBody
   public PageData edit(){
	   PageData param = getPageData();
	   PageData res = new PageData();
	   try {
		carManagerService.updateOneCar(param);
		res.putStatus(XConst.SUCCESS);
	} catch (Exception e) {
		e.printStackTrace();
		res.putStatus(XConst.FAIL);
	}
	   
	   return res;
	   
	   
   }
	
}
