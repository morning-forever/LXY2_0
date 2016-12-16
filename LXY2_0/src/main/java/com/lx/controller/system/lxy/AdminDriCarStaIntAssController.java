package com.lx.controller.system.lxy;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.lx.controller.base.BaseController;
import com.lx.service.app.DriCarStaIntAssService;
import com.lx.util.PageData;
import com.lx.util.XConst;

/**
 * 类名全称：AdministratorDriverCarStateInterAssociateController管理员司机车辆状态相互关联控制类
 * @author Administrator
 *
 */
@Controller
@RequestMapping("admin/lxy/dri_car_sta_int_ass")
public class AdminDriCarStaIntAssController extends BaseController{
	
	@Resource
	private DriCarStaIntAssService driCarStaIntAssService;
	
	@RequestMapping("carStaAssDriAddUI")
	public ModelAndView  carStaAssDriAddUI() throws Exception{
		
		ModelAndView mav = new ModelAndView("system/lxy/dri_car_sta_int_ass/carStaAssDriAddUI");
		PageData param = getPageData();
		
		List<PageData> driNamsAndIdsLis =driCarStaIntAssService.getIdleDris(param);
		mav.addObject("driNamsAndIdsLis", driNamsAndIdsLis);
		mav.addObject("param", param);//将参数传到下一个页面，在分配司机前要查找该司机是否空闲时，需要用到这些参数（startTime,endTime,）,分配司机时要用到（carStaId）
		return mav;
	}
	
	@RequestMapping("carStaAssDriAdd")
	@ResponseBody
	public PageData carStaAssDri(){
		PageData param = super.getPageData();
		try {
			driCarStaIntAssService.carStaAssDriAdd(param);
		} catch (Exception e) {
			param.clear();
			param.putStatus(XConst.EXCEPTION);
			e.printStackTrace();
		}
		
		return param;
	}
	
}
