package com.lx.controller.app.pc;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.lx.controller.base.BaseController;
import com.lx.service.app.FeedbackService;
import com.lx.util.PageData;
import com.lx.util.XConst;

@Controller(value = "IndexController")
@RequestMapping(value = "lxy/app/pc")
public class IndexController extends BaseController {
	
	
	@Autowired
	private FeedbackService feedbackService;
	/**
	 * @return
	 */
	@RequestMapping(value = "feedback")
	public ModelAndView feedback() {
		ModelAndView mav = new ModelAndView("app/pc/feedback");
		try {
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mav;
	}
	
	/**
	 * 添加反馈信息
	 * 
	 * @return
	 */
	@RequestMapping(value = "addFeedBack")
	@ResponseBody
	public PageData addFeedBack() {
		PageData res = new PageData();
		try {
			PageData param = getPageData();
			feedbackService.addFeedback(param);
			res.putStatus(XConst.SUCCESS);
		} catch (Exception e) {
			res.putStatus(XConst.EXCEPTION);
			e.printStackTrace();
		}
		return res;
	}
	
	@RequestMapping(value = "customerService/{id}")
	public ModelAndView customerService(@PathVariable String id) {
		String path="app/pc/customerService/"+id;
		ModelAndView mav = new ModelAndView(path);
		try {
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mav;
	}

}
