package com.lx.controller.system.lxy;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.lx.controller.base.BaseController;
import com.lx.service.app.DriCarIntAssService;
import com.lx.util.PageData;
import com.lx.util.XConst;

@Controller
@RequestMapping("admin/lxy/dri_car_int_ass")
public class AdminDriCarIntAssController extends BaseController{
	
	@Resource
	private DriCarIntAssService driCarIntAssService;
	
	@RequestMapping("carAssDriAddUI/{carId}")
	public ModelAndView  carAssDriAddUI(@PathVariable Long carId) throws Exception{
		
		ModelAndView mav = new ModelAndView("system/lxy/dri_car_int_ass/carAssDriAddUI");
		
		List<PageData> driNamsAndIdsLis =driCarIntAssService.getAllDriNamsAndIds();
		mav.addObject("driNamsAndIdsLis", driNamsAndIdsLis);
		mav.addObject("carId", carId);
		
		return mav;
	}
	
	@RequestMapping("carAssDriAdd")
	@ResponseBody
	public PageData carAssDri(){
		
		PageData param = super.getPageData();
		
		
		try {
			driCarIntAssService.carAssDriAdd(param);
			param.clear();
			param.putStatus(XConst.SUCCESS);
		} catch (Exception e) {
			param.putStatus(XConst.EXCEPTION);
			e.printStackTrace();
		}
		
		return param;
	}
	
	@RequestMapping("shoDriInf/{carId}")
	public ModelAndView shoDriInf(@PathVariable Long carId) throws Exception{
		
		ModelAndView mav = new ModelAndView("system/lxy/dri_car_int_ass/info");
		PageData driver = driCarIntAssService.getDriverByCarId(carId);
		
		mav.addObject("driver", driver);
		return mav;
	}
}
