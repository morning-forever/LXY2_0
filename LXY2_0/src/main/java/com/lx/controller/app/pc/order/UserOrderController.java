package com.lx.controller.app.pc.order;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

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

import com.alibaba.fastjson.JSONArray;
import com.lx.controller.base.BaseController;
import com.lx.entity.system.User;
import com.lx.service.app.OrderFormService;
import com.lx.util.Const;
import com.lx.util.PageData;
import com.lx.util.XConst;


/**
 * 
 * 用户订单Controller
 * 
 * @author Hham
 *
 */
@Controller
@RequestMapping("lxy/order")
public class UserOrderController extends BaseController {
	
	@Autowired
	private OrderFormService orderFormService;
	
	//可删除订单类型
	//private final static String[] ALLOWED_ORDER_TYPE_ARR=new String[]{"REFUNDED","PAY_OK","CLOSED","REFUNDING_FAIL"};
	//可退款订单类型
	private final static String[] REFUND_ORDER_TYPE_ARR=new String[]{"PAY_OK","REFUNDING_FAIL"};
	
	/**
	 * 提交订单
	 * @return
	 */
	@RequestMapping(value = "submit")
	@ResponseBody
	@SuppressWarnings("unchecked")
	public PageData submitOrder(){
		PageData res = new PageData();
		try{
			Subject currentUser = SecurityUtils.getSubject();  
			Session session = currentUser.getSession();
			PageData pd = (PageData) session.getAttribute("formData");//从session里面取的表单数据
			if(pd == null){//订单已提交忽略掉
				res.putStatus(XConst.ALREADY_SUBMIT);
				return res;
			}
			
			User user = (User)session.getAttribute(Const.APP_USER);
			if (user != null) {
				pd.put("userId", user.getUSER_ID());
				List<Long> carStateIds = (List<Long>) session.getAttribute("carStateIds");
				orderFormService.saveOrder(pd,carStateIds);//提交表单，更新数据库
				
				res = pd;//pd 经过上一步保存订单之后，里面已经存有订单号和id
				
				res.putStatus(XConst.SUCCESS);
				
				//提交表单之后移除session中表单相关数据，避免内存占用
				session.removeAttribute("formData");
				session.removeAttribute("carStateIds");
			}
	        
		}catch (Exception e) {
			res.put("status", XConst.EXCEPTION);
			e.printStackTrace();
		}
		return res;
	}
	
	/**
	 * 支付页面
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping("{userName}/payment/{orderId}")
	public ModelAndView payment(@PathVariable String userName ,@PathVariable Long orderId) throws Exception{
		
		
		ModelAndView mav = new ModelAndView("app/pc/order/payment");
		PageData param = new PageData();
		param.put("userName", userName);
		param.put("orderId", orderId);
		if(null == orderFormService.getOrderByUandId(param)){
			mav.setViewName("error");
			return mav;
		}
		PageData orderForm = orderFormService.getOrderFormById(orderId);
		mav.addObject("orderForm", orderForm);
		
		return mav;
	}
	
	/**
	 * 支付成功页面
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping("{userName}/pay_success/{orderId}")
	public ModelAndView paySuccess(@PathVariable String userName ,@PathVariable Long orderId) throws Exception{
		ModelAndView  mav = new ModelAndView("app/pc/order/payment_success");
		
		PageData param = new PageData();
		param.put("userName", userName);
		param.put("orderId", orderId);
		if(null == orderFormService.getOrderByUandId(param)){
			mav.setViewName("error");
			return mav;
		}
		orderFormService.paySuccess(orderId);
		
		mav.addObject("orderId", orderId);
		return mav;
	}
	
	/**
	 * 审核提示页面
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping("verify_prompt/{orderId}")
	public ModelAndView verifyPrompt(@PathVariable Long orderId) throws Exception{
		
		ModelAndView mav = new ModelAndView("app/pc/order/verify_prompt");
		
		PageData orderForm = orderFormService.getOrderFormById(orderId);
		
		mav.addObject("orderForm", orderForm);
		
		return mav;
	}
	/**
	 * 
	 * 跳转到订单列表
	 * 
	 * @return
	 */
	@RequestMapping("list")
	public ModelAndView orderList() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("app/pc/order/list");
		return mav;
	}
	
	@RequestMapping(value = "listdata")
	@ResponseBody
	public PageData listData() {
		PageData res = new PageData();
		try {
			
			System.out.println("----------listdata----------");
			PageData param = getSysPageData();
			
			//shiro管理的session
			Subject currentUser = SecurityUtils.getSubject();  
			Session session = currentUser.getSession();
			
			User user = (User)session.getAttribute(Const.APP_USER);
			if (user != null) {
				String userId = user.getUSER_ID();
				param.put("userId", userId);
				res = orderFormService.getOrderList(param);
			}
			
		} catch (Exception e) {
			res.putStatus(XConst.EXCEPTION);
			e.printStackTrace();
		}
		return res;
	}
	
	/**
	 * 查看订单详情
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="{userName}/detail/{orderId}")
	public ModelAndView detail(@PathVariable String userName ,@PathVariable Long orderId) throws Exception{
		ModelAndView mav = new ModelAndView("app/pc/order/detail");
		
		PageData param = new PageData();
		param.put("userName", userName);
		param.put("orderId", orderId);
		if(null == orderFormService.getOrderByUandId(param)){
			mav.setViewName("error");
			return mav;
		}
		
		//找到该订单所订的车
		List<PageData>  cars = orderFormService.getCarsByOrderId(orderId);
		mav.addObject("cars", cars);
		
		PageData orderForm = orderFormService.getOrderFormById(orderId);
		mav.addObject("orderForm",orderForm);	
		
		return mav;
	}
	
	/**
	 * 修改订单页面
	 * @param orderId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("{userName}/editUI/{orderId}")
	public ModelAndView eidtUI(@PathVariable String userName,@PathVariable Long orderId) throws Exception{
		ModelAndView mav = new ModelAndView("app/pc/order/editUI");
		
		PageData param = new PageData();
		param.put("userName", userName);
		param.put("orderId", orderId);
		if(null == orderFormService.getOrderByUandId(param)){
			mav.setViewName("error");
			return mav;
		}
		
		//找到该订单所订的车
		List<PageData>  cars = orderFormService.getCarsByOrderId(orderId);
		mav.addObject("cars", cars);
		mav.addObject("jsonCars",JSONArray.toJSONString(cars));//如果最后没有修改车辆，在判断座位数是否足够时，需要用到
		
		PageData orderForm = orderFormService.getOrderFormById(orderId);
		mav.addObject("orderForm",orderForm);
		
		
		return mav;
		
		
	}
	
	/**
	 * 修改订单
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping("edit")
	public ModelAndView edit() throws Exception{
		ModelAndView mav = new ModelAndView();
		PageData pageData = getPageData();
		Subject currentUser = SecurityUtils.getSubject();  
		Session session = currentUser.getSession();
		User user = (User) session.getAttribute(Const.APP_USER);
		mav.setViewName("redirect:/lxy/order/"+user.getUSERNAME()+"/detail/"+pageData.getLong("orderId"));
		
		
		
		
		@SuppressWarnings("unchecked")
		List<Long> carStateIds = (List<Long>) session.getAttribute("carStateIds");
		orderFormService.edit(pageData,carStateIds);
		
		
		return mav;
	}
	
	/**
	 * 取消订单
	 * @param id
	 * @return
	 */
	@RequestMapping(value="cancelOrder/{orderId}",produces=XConst.JSON_PRODUCES)
	@ResponseBody
	public PageData canelOrder(@PathVariable Long orderId){
		
		PageData res = new PageData();
		try {
			orderFormService.cancelOrder(orderId);
			res.putStatus(XConst.SUCCESS);
		} catch (Exception e) {
			res.putStatus(XConst.EXCEPTION);
			e.printStackTrace();
		}
		return res;
	}
	
	/**
	 * 删除订单
	 * @param id
	 * @return
	 */
	@RequestMapping(value="delOrder/{orderId}",produces=XConst.JSON_PRODUCES)
	@ResponseBody
	public PageData deleteOrder(@PathVariable Long orderId){
		PageData res = new PageData();
		try {
			orderFormService.lgcDelById(orderId);
			res.putStatus(XConst.SUCCESS);
		} catch (Exception e) {
			res.putStatus(XConst.EXCEPTION);
			e.printStackTrace();
		}
		return res;
	}
	
	/**
	 * 申请退款
	 * @param id
	 * @return
	 */
	@RequestMapping(value="refund",produces=XConst.JSON_PRODUCES)
	@ResponseBody
	public PageData refund(Long id){
		PageData pd=getApiPageData();
		try {
			pd.put("id", id);
			
			String orderType = getOrderTypes(REFUND_ORDER_TYPE_ARR);
			
			pd.put("orderTypes", orderType);
			Long checkId=orderFormService.checkRefund(pd);
			if(checkId!=null){
				orderFormService.refund(pd);
				pd.putStatus(XConst.SUCCESS);
			}else{
				pd.putStatus(XConst.ERROR);
			}
		} catch (Exception e) {
			pd.putStatus(XConst.EXCEPTION);
			e.printStackTrace();
		}
		return pd;
	}


	
	

	/**
	 * 跳转至退款页面
	 * 
	 * @return
	 */
	@RequestMapping("/refund/{orderId}")
	public ModelAndView toRefund(@PathVariable Long orderId) {
		ModelAndView mav = new ModelAndView();
		try {
			mav.addObject("orderId", orderId);
			mav.setViewName("lxy/order/user_refund");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mav;
	}

	/**
	 * 保存申请退款信息
	 * 
	 * @return
	 */
	@RequestMapping(value = "/saveRefund")
	@ResponseBody
	public PageData saveRefund() {
		PageData res = new PageData();
		try {
			PageData param = getPageData();
			orderFormService.saveRefund(param);
			res.putStatus(XConst.SUCCESS);
		} catch (Exception e) {
			res.putStatus(XConst.EXCEPTION);
			e.printStackTrace();
		}
		return res;
	}
	
	
	//返回指定类型订单字符串拼接
	private String getOrderTypes(String[] orderArr) {
		StringBuffer OrderTypeBuffer=new StringBuffer();
		for (int i = 0; i < orderArr.length; i++) {
			OrderTypeBuffer.append("'");
			OrderTypeBuffer.append(orderArr[i]);
			OrderTypeBuffer.append("'");
			OrderTypeBuffer.append(",");
		}
		
		return OrderTypeBuffer.substring(0, OrderTypeBuffer.lastIndexOf(","));
	}
	
	
	
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
	

	
}
