package com.lx.service.app;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Random;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.lx.dao.DaoSupport;
import com.lx.service.system.TaskService;
import com.lx.util.DateUtil;
import com.lx.util.HString;
import com.lx.util.PageData;
import com.lx.util.XConst;
import com.lx.util.config.ConfigLoad;
import com.lx.util.emaysms.SMSHelper;
import com.lx.util.mail.SimpleMailSender;

@Service
@Transactional
@SuppressWarnings("unchecked")
public class OrderFormService {
	
	@Resource
	private DaoSupport dao;
	
	@Resource
	private TaskService taskService;
	
	
	
	private static SimpleDateFormat DATE_H_M_CN_FORMAT = new SimpleDateFormat("yyyy年MM月dd日HH点mm分");
	//private static SimpleDateFormat DATE_SIMPLE_CN_FORMAT = new SimpleDateFormat("yyyy年MM月dd日");
	
	/**
	 * 提交订单前算价格，是否需要审核等(生产订单确认页的数据)
	 * @param param
	 * @param carStateIds
	 * @return
	 * @throws Exception
	 */
	public PageData detailCheck(PageData param,List<Long> carStateIds) throws Exception{
		
		//一、订单是否需要审核，价格是否能够立马得出
		
		boolean isNeedCheck = false;//默认不需要审核
		
		boolean isPrice = true;//订单价格是否可以得出，默认可以得出
		
		//1.如果所填路线不是默认路线，则需要审核
		int dayNum = (int) (DateUtil.getDaySub(param.getString("startTime"),param.getString("endTime"))+1);
		param.put("dayNum", dayNum);
		PageData defaultRoute = (PageData) dao.findForObject("DefaultRouteManagerMapper.getRouteByCD", param);//param里包含路线（route）及路线的天数(day_num)
		
		if(defaultRoute == null){//说明不是默认路线，需要审核
			isNeedCheck = true;
			isPrice = false;//订单价格还不可以算出
		}else{//说明是默认路线，
			param.put("defaultRouteId", defaultRoute.getLong("id"));
			param.put("routeKm", defaultRoute.getInt("km"));
		}
		
		//2.如果填了接团地点，就判断接团地点是否为默认地点，如果不是默认地点，则需要审核
		if(param.getString("jtSite")!=null){
			PageData jtSite = (PageData) dao.findForObject("JstSiteMapper.getSiteByName", param.getString("jtSite"));
			if(jtSite == null){//如果jtSite == null，说明不是默认接团地点，需要审核
				isNeedCheck = true;
				isPrice = false;//订单价格还不可以算出
			}else{
				param.put("jtSiteId", jtSite.getInt("id"));
				param.put("jtSiteKm", jtSite.getInt("km"));
			}
		}else{//没有填接团地点,接团地点的公里数设为0
			param.put("jtSiteKm",0);
		}
		
		//3.如果填了送团地点，就判断送团地点是否为默认地点，如果不是默认地点，则需要审核
		if(param.getString("stSite")!=null){
			PageData stSite  = (PageData) dao.findForObject("JstSiteMapper.getSiteByName", param.getString("stSite"));
			if(stSite == null){
				isNeedCheck = true;
				isPrice = false;//订单价格还不可以算出
			}else{
				param.put("stSiteId", stSite.getInt("id"));
				param.put("stSiteKm", stSite.getInt("km"));
			}
		}else{//没有填送团地点，送团地点的公里数设为0
			param.put("stSiteKm", 0);
		}
		
		//4.如果填了备注，就需要审核
		if( null != param.getString("remark")){
			isNeedCheck = true;
		}
		param.put("isNeedCheck",isNeedCheck);
		
		//5.如果价格能够计算得出
		if(isPrice){
		   int km = param.getInt("routeKm")+param.getInt("jtSiteKm")+param.getInt("stSiteKm");
		   
		   
		   Double  price = (Double) dao.findForObject("CarStateMapper.getPriceByCarStaIds", carStateIds);
		   price = new BigDecimal(price.toString()).multiply(new BigDecimal(km)).doubleValue();
		  
		   param.put("price", price);
		   param.put("km",km);
		   
		}
		param.put("isPrice", isPrice);
		return param;
	}
	
	/**
	 * 保存订单信息
	 * 
	 * @param param
	 * @throws Exception
	 */
	public void saveOrder(PageData param,List<Long> carStateIds) throws Exception {
		//一、订单是否需要审核
		boolean isNeedCheck = param.getBoolean("isNeedCheck");
		
		XConst.ORDER_STATE currentState = isNeedCheck ? XConst.ORDER_STATE.CHECKING:XConst.ORDER_STATE.WAITPAY;
		param.put("currentState", currentState);
		
		//路线、接团地点、送团地点三个字段，如果是常规，则去掉其值，只保留系统提供的id
		 if(param.getLong("defaultRouteId") != null){
			 param.remove("route");
		 }
		 
		 if(param.getInt("jtSiteId")!=null){
			 param.remove("jtSite");
		 }
		 if(param.getInt("stSiteId")!=null){
			 param.remove("stSite");
		 }
		//二、数据库更新
		//1.订单表新增一条记录
		dao.save("OrderFormMapper.saveOrder", param);
		
		//2.接着设置订单号
		Date time = new Date();
		String orderCode = new SimpleDateFormat("yyyyMMddHHmmss")
				.format(time)
				+ param.getString("orderId")
				+ String.format("%03d", new Random().nextInt(1000));
		
		param.put("orderCode", orderCode);
		
		dao.update("OrderFormMapper.setOrderCode", param);
		
		//3.给车辆状态记录设置form_id值
		param.put("carStateIds",carStateIds);
		dao.update("CarStateMapper.setFormIdByCarStaIds", param);
		
		
		//四、下单成功通知
		
		//1.获得需要通知的前台用户
		param.put("USER_ID", param.get("userId"));
		PageData user = (PageData) dao.findForObject("AppuserMapper.findByUiId", param);
		
		
		//2.编辑消息内容
		String	message; 	//通知前台用户的消息
		String adminMessage;//通知后台用户的消息
		
		if(isNeedCheck){
			message = "您已下单成功,您提交的路线是自定义路线或包含自定义内容，我们正在审核中...";
			adminMessage = "有用户提交自定义订单,请登录后台管理系统进行审核！订单号："+orderCode ;
		}else{
			List<PageData> carGroups = (List<PageData>) dao.findForList("CarManagerMapper.getCarGroups", carStateIds);
			StringBuilder carMessage = new StringBuilder();
			for(PageData carGroup : carGroups ){
				carMessage.append(carGroup.getString("carType")+carGroup.getString("carCount")+"辆；");
			}
			message = "您已下单成功,订单号："+orderCode+"车辆信息："+carMessage+"订单金额："+ param.getString("price")+"，请在半小时内完成支付，否则订单将自动关闭！";
			
			adminMessage = "有用户提交订单,请登录后台管理系统查看，订单号：" + orderCode+"车辆信息："+carMessage+"订单金额："+ param.getString("price");
		}
		//3.发送通知
		taskService.orderNotice(adminMessage, message, param.getString("contactNumber"), user.getString("EMAIL"));
	}
	

	/**
	 * 前端获取订单列表
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public PageData getOrderList(PageData param) throws Exception {
		PageData res = new PageData();
		int pageSize = 5;
		Integer total = (Integer) dao.findForObject("OrderFormMapper.getUserOrderListCount", param);
		
		Integer totalPage = total % pageSize == 0 ? total / pageSize : total / pageSize + 1;
		Integer pageNo = (HString.isEmpty(param.getInt("pageNo")) ? 1 : param.getInt("pageNo"));
		
		param.put("startLine", (pageNo - 1) * pageSize);
		param.put("showLine", pageSize);
		List<PageData> list = (List<PageData>) dao.findForList("OrderFormMapper.getUserOrderList", param);
		res.put("list", list);

		res.putStatus(XConst.SUCCESS);
		res.put("totalPage", totalPage);
		res.put("pageNo", param.getLong("pageNo"));
		
		return res;
	}
	
	/**
	 * 根据订单id获取订单信息
	 * @param orderId
	 * @return
	 * @throws Exception
	 */
	public PageData getOrderFormById(Long orderId) throws Exception{
		return (PageData) dao.findForObject("OrderFormMapper.getOrderFormById", orderId);
	}
	
	/**
	 * 查某个用户是否拥有某条订单或者是某条订单是否属于某个用户，防止一个用户操作另一个用户的订单时要用到 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public PageData getOrderByUandId(PageData param) throws Exception{
		return (PageData) dao.findForObject("OrderFormMapper.getOrderByUAndId", param);
	}
	
	/**
	 * 根据订单id获取该订单所订的车辆
	 * @param orderId
	 * @return
	 * @throws Exception
	 */
	public List<PageData> getCarsByOrderId(Long orderId) throws Exception{
		
		return (List<PageData>) dao.findForList("OrderFormMapper.getCarsByOrderId", orderId);
	}
	
	
	public void edit(PageData param, List<Long> carStateIds) throws Exception {
		//一、订单是否需要审核，价格是否能够立马得出
		boolean isNeedCheck = false;//默认不需要审核
		
		boolean isPrice = true;//订单价格是否可以得出，默认可以得出
		
		//1.如果所填路线不是默认路线，则需要审核
		int dayNum = (int) (DateUtil.getDaySub(param.getString("startTime"),param.getString("endTime"))+1);
		param.put("dayNum", dayNum);
		PageData defaultRoute = (PageData) dao.findForObject("DefaultRouteManagerMapper.getRouteByCD", param);//param里包含路线（route）及路线的天数(day_num)
		
		if(defaultRoute == null){//说明不是默认路线，需要审核
			isNeedCheck = true;
			isPrice = false;//订单价格还不可以算出
		}else{//说明是默认路线，
			param.put("defaultRouteId", defaultRoute.getLong("id"));
			param.put("routeKm", defaultRoute.getInt("km"));
		}
		
		//2.如果填了接团地点，就判断接团地点是否为默认地点，如果不是默认地点，则需要审核
		if(param.getString("jtSite")!=null){
			PageData jtSite = (PageData) dao.findForObject("JstSiteMapper.getSiteByName", param.getString("jtSite"));
			if(jtSite == null){//如果jtSite == null，说明不是默认接团地点，需要审核
				isNeedCheck = true;
				isPrice = false;//订单价格还不可以算出
			}else{
				param.put("jtSiteId", jtSite.getInt("id"));
				param.put("jtSiteKm", jtSite.getInt("km"));
			}
		}else{//没有填接团地点,接团地点的公里数设为0
			param.put("jtSiteKm",0);
		}
		
		//3.如果填了送团地点，就判断送团地点是否为默认地点，如果不是默认地点，则需要审核
		if(param.getString("stSite")!=null){
			PageData stSite  = (PageData) dao.findForObject("JstSiteMapper.getSiteByName", param.getString("stSite"));
			if(stSite == null){
				isNeedCheck = true;
				isPrice = false;//订单价格还不可以算出
			}else{
				param.put("stSiteId", stSite.getInt("id"));
				param.put("stSiteKm", stSite.getInt("km"));
			}
		}else{//没有填送团地点，送团地点的公里数设为0
			param.put("stSiteKm", 0);
		}
		
		//4.如果填了备注，就需要审核
		if( null != param.getString("remark")){
			isNeedCheck = true;
		}
		param.put("isNeedCheck",isNeedCheck);
		
		XConst.ORDER_STATE currentState = isNeedCheck ? XConst.ORDER_STATE.CHECKING:XConst.ORDER_STATE.WAITPAY;
		param.put("currentState", currentState);
		
		//5.如果价格能够计算得出
		if(isPrice){
		   int km = param.getInt("routeKm")+param.getInt("jtSiteKm")+param.getInt("stSiteKm");
		   
		   Double  price;
		   if(carStateIds != null){
			   price = (Double) dao.findForObject("CarStateMapper.getPriceByCarStaIds", carStateIds);
		   }else{
			   price = (Double) dao.findForObject("CarStateMapper.getPriceByOrderId", param.getLong("orderId"));
		   }
		   price = new BigDecimal(price.toString()).multiply(new BigDecimal(km)).doubleValue();
		  
		   param.put("price", price);
		   param.put("km",km);
		   
		}
			
		//二、数据操作
		//1.订单表
		dao.update("OrderFormMapper.updateOrderFormById", param);
		
		//2.车辆状态表
		if(carStateIds !=null){ //如果carStateIds为null，说明用户没有改车，不用操作车辆状态表；如果carStateIds不为null，说明用户已经改了车，要操作车辆状态表
			
			param.put("carStateIds",carStateIds);
			//2.1 释放当前订单之前关联的车辆
			dao.update("CarStateMapper.freeCarsByFormId", param.getLong("orderId"));
			//2.2 给当前订单与锁定的车辆状态记录建立关系
			dao.update("CarStateMapper.setFormIdByCarStaIds", param);
		}
			
	}
	
	/**
	 * 
	 * 支付保存
	 * 
	 * @param orderId
	 * @param payOrderId
	 * @param payMethod
	 * @return 
	 * @throws Exception
	 */
	public boolean updateOrderPay(Long orderId,String payOrderId, String payMethod)throws Exception {
		PageData params = new PageData();
		
		params.put("orderId", orderId);
		params.put("payOrderId", payOrderId);
		params.put("payMethod", payMethod);
		
		PageData orderForm=(PageData) dao.findForObject("OrderFormMapper.getOrderFormById", orderId);
		if(XConst.ORDER_STATE.PAY_OK.toString().equals(orderForm.getString("orderState"))){
			return true;
		}
		
		dao.update("OrderFormMapper.updateOrderState", params);
		
		System.out.println("发送短信...............1");
		System.out.println("user不等于null****************");
		PageData param = new PageData();
		param.put("USER_ID", orderForm.getString("userId"));
		System.out.println(orderForm.getString("userId")+"*************************");
		PageData userPd = (PageData)dao.findForObject("AppuserMapper.findByUiId", param);
		//String mobile = userPd.getString("PHONE");
		String email = userPd.getString("EMAIL");
		String name = userPd.getString("NAME");
		StringBuffer sb = new StringBuffer("尊敬的" + name);
		sb.append("，您好!您于" + DATE_H_M_CN_FORMAT.format(orderForm.get("createTime")));
		sb.append("预定的车辆已支付成功，");
		sb.append("总金额：" + orderForm.getString("price") + "元。");
		sb.append("订单号：" + orderForm.get("orderCode") + "(请妥善保管)，");
		sb.append("我们会在您指的的时间内为你提供相应的车辆!");
		sb.append("如有疑问请联系龙行云客服：" + ConfigLoad.getStringValue("SMS.CONTENT_TEL") + "，我们将竭诚为您服务，祝您生活愉快！");
		
		System.out.println("发送短信...............");
		SMSHelper.sendSms(orderForm.getString("personPhone"), sb.toString());
		
		SimpleMailSender.sendEmail(email, "用户订车通知", sb.toString(), "2");
		
		if("on".equals(ConfigLoad.getStringValue("webapp.driver_sms"))){
			//smsDri(orderId);
		}
		return true;
	}
	
	/**
	 * 取消订单
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void cancelOrder(Long orderId) throws Exception {
		//将订单状态置为已取消并释放相应车辆
		dao.update("OrderFormMapper.cancelOrder", orderId);
	}
	
	/**
	 * 删除订单（逻辑删除）
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void lgcDelById(Long orderId) throws Exception {
		dao.update("OrderFormMapper.lgcDelById", orderId);
	}
	
	
	public void paySuccess(Long orderId) throws Exception{
		dao.update("OrderFormMapper.paySuccess", orderId);
	}
	/**
	 * 验证能否申请退款
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public Long checkRefund(PageData pd) throws Exception {
		return (Long) dao.findForObject("OrderFormMapper.checkRefund", pd);
	}

	/**
	 * 申请退款
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void refund(PageData pd) throws Exception {
		//dao.update("OrderFormMapper.updatePerson", pd);
		dao.update("OrderFormMapper.refund", pd);
	}
	
	/**
	 * 验证订单能否删除
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public Long checkDelete(PageData pd) throws Exception {
		return (Long) dao.findForObject("OrderFormMapper.checkDelete", pd);
	}

	
	/**
	 * 新增一条退款信息
	 * 
	 * @param param
	 * @throws Exception
	 */
	public void saveRefund(PageData param) throws Exception {
		//删除已存在的之前申请过的退款信息，只保留最新的
		int count = (Integer)dao.save("OrderFormMapper.deleteRefund", param);
		// 保存退款申请信息
		dao.save("OrderFormMapper.addRefund", param);
		// 修改订单状态为退款中
		PageData orderData = new PageData();
		orderData.put("orderId", param.get("formId"));
		orderData.put("newState", XConst.ORDER_STATE.REFUNDING.toString());// 新状态：退款中
		//如果之前没有申请过退款，则之前状态为支付成功
		if(count == 0){
			orderData.put("oldState", XConst.ORDER_STATE.PAY_OK.toString());// 原状态：支付成功
		}
		//如果之前没有申请过退款，则之前状态为退款失败
		else{
			orderData.put("oldState", XConst.ORDER_STATE.REFUNDING_FAIL.toString());// 原状态：退款失败
		}
		dao.update("OrderFormMapper.updateOrderState", orderData);
	}
	
	

	/**
	 * 验证取消订单 查询对应的未支付订单ID
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public Long checkCannel(PageData pd) throws Exception {
		return (Long) dao.findForObject("OrderFormMapper.checkCannel", pd);
	}
	
	/**
	 * 查询订单详情
	 * 
	 * @param id
	 * @return
	 * @throws Exception
	 */
	public PageData findOrderDetail(Long orderId) throws Exception {
		PageData param = new PageData();
		param.put("orderId", orderId);
		return (PageData) dao.findForObject("OrderFormMapper.findOrderDetail", param);
	}

	/**
	 *获取拒绝退款原因 
	 * @param orderId
	 * @return
	 * @throws Exception
	 */
	public PageData getRefuseReason(Long orderId) throws Exception{
		PageData pd = (PageData) dao.findForObject("OrderFormMapper.getRefuseReason", orderId);
		
		return pd;
	}
	
	/**
	 * 短信通知订单内所有司机
	 * @param formId
	 * @throws Exception 
	 */
	public void smsAllDris(Long  formId) throws Exception{
		
		//1.先查出这个订单的carStateIds字符串
		 PageData data = (PageData) dao.findForObject("OrderFormMapper.getCarStateIdsByFormId",formId);
		 
		 //2.再根据carStateIds查出对应车辆的司机（包括司机姓名和电话号码）
		 List<PageData> driNamsAndTelsLis = (List<PageData>) dao.findForList("OrderFormMapper.getDriNamsAndTelByCarStaIds", data);
		 
		 //3.发送短信通知
		 for(PageData driver : driNamsAndTelsLis){
			 String message = "尊敬的"+driver.getString("name")+",您的车于"+driNamsAndTelsLis.get(0).getString("startTime")+"有出行，请及时做好准备！谢谢配合！";
			 SMSHelper.sendSms(driver.getString("tel"),message);
		 }
		 
		 //4.更新数据库（表示相应车辆锁定状态记录已通知到司机）
		 dao.update("OrderFormMapper.alrSmsDri", formId);
	}
	
	
	/**
	 * 短信通知一位司机
	 * @param driverId
	 * @throws Exception
	 */
	public void smsOneDri(String name,String tel,String startTime,Long carStaId) throws Exception{
		String message = "尊敬的"+name+"师傅,您的车于"+startTime+"有出行，请及时做好准备！谢谢配合！";
		SMSHelper.sendSms(tel, message);
		dao.update("CarStateMapper.notDri",carStaId);
	}

}
