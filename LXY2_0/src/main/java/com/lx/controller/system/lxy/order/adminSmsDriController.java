package com.lx.controller.system.lxy.order;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lx.controller.base.BaseController;
import com.lx.service.app.OrderFormService;
import com.lx.util.PageData;
import com.lx.util.XConst;

@Controller
public class adminSmsDriController extends BaseController{
	
	@Resource
	private OrderFormService orderFormService;
	
	@RequestMapping("admin/lxy/smsDri/{formId}")
	@ResponseBody
	public PageData smsAllDris(@PathVariable Long formId){
		PageData res = new PageData();
		
		try {
			orderFormService.smsAllDris(formId);
			res.putStatus(XConst.SUCCESS);
		} catch (Exception e) {
			
			res.putStatus(XConst.EXCEPTION);
			e.printStackTrace();
		}
		
		return res;
	}
	
	@RequestMapping("admin/lxy/smsOneDri")
	@ResponseBody
	public PageData smsOneDri(){
		PageData res = new PageData();
		PageData param = super.getPageData();
		
		try {
			orderFormService.smsOneDri(param.getString("name"),param.getString("tel"),param.getString("startTime"),param.getLong("carStaId"));
			res.putStatus(XConst.SUCCESS);
		} catch (Exception e) {
			
			res.putStatus(XConst.EXCEPTION);
			e.printStackTrace();
		}
		
		return res;
	}
	
}
