package com.lx.service.system.lxy;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

//import com.bm.webs.controller.util.SMSHelper;
import com.lx.dao.DaoSupport;
import com.lx.service.app.DefaultRouteManagerService;
import com.lx.service.app.JstSiteService;
import com.lx.util.PageData;
import com.lx.util.emaysms.SMSHelper;
import com.lx.util.mail.SimpleMailSender;

/**
 * 
 * 
 * 
 * @author Daisy
 *
 */
@Service
@Transactional
@SuppressWarnings("unchecked")
public class AdminOrderService {
	
	@Resource(name="daoSupport")
	private DaoSupport dao;
	
	@Resource
	private JstSiteService jstSiteService;
	
	@Resource
	private DefaultRouteManagerService defaultRouteManagerService;
	
	/**
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public PageData findOrderList(PageData param) throws Exception {
		Integer total = (Integer) dao.findForObject("AdminOrderMapper.findOrderListCount", param);
		List<PageData> list = (List<PageData>)dao.findForList("AdminOrderMapper.findOrderList", param);
		param.clear();
		param.put("data", list);
		param.put("recordsTotal", total);
		param.put("recordsFiltered", total);
		return param;
	}
	
	/**
	 * 旅行社老大查看自己的订单
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public PageData findOrderAppList(PageData param) throws Exception{
		Integer total = (Integer) dao.findForObject("AdminOrderMapper.findOrderAppListCount", param);
		List<PageData> list = (List<PageData>)dao.findForList("AdminOrderMapper.findOrderAppList", param);
		param.clear();
		param.put("data", list);
		param.put("recordsTotal", total);
		param.put("recordsFiltered", total);
		return param;
	}
	
	
	public PageData getOrderById(Long id) throws Exception{
	
		return (PageData) dao.findForObject("OrderFormMapper.getOrderFormById", id);
		
	}
	/**
	 * 获取深度游退款列表
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public PageData findRefundList(PageData param) throws Exception {
		Integer total = (Integer) dao.findForObject("AdminOrderMapper.findRefundListCount", param);
		List<PageData> list = (List<PageData>)dao.findForList("AdminOrderMapper.findRefundList", param);
		param.clear();
		param.put("data", list);
		param.put("recordsTotal", total);
		param.put("recordsFiltered", total);
		return param;
	}
	
	/**
	 * 审核
	 * @throws Exception
	 */
	public void saveCheck(PageData param) throws Exception {
		//修改审核状态为已审核
		dao.update("AdminOrderMapper.updateCheck", param);
	}
	
	/**
	 * 退款成功和退款失败
	 * @param param
	 * @throws Exception
	 */
	public void saveRefund(PageData param) throws Exception {
		//新增一条审核记录
		dao.save("AdminOrderMapper.addExamine", param);
		
		//修改订单状态
		PageData orderData = new PageData();
		orderData.put("orderId", param.get("orderId"));
		orderData.put("oldState", "REFUNDING");
		orderData.put("newState", param.get("state"));
		dao.update("OrderFormMapper.updateOrderState", orderData);
		
		//若退款成功，则修改退款完成时间
		if(param.getLong("result") == 0){
			dao.update("AdminOrderMapper.updateCheck", param);
			//更新车辆使用状态
			dao.update("OrderFormMapper.refundfreeCars", orderData);
			
		}
		
		//退库成功和退款失败都发送短信
		//PageData mesInfo = findRefundInfo(param.getLong("orderId"));
		/*String mobile = mesInfo.getString("person_phone");
		String refundResult = (param.getLong("result") == 0)?"退款成功":"退款失败";
		String mes = "尊敬的"+mesInfo.getString("person_name")+"，您的订单号："+mesInfo.getString("order_code")+refundResult
				+"，如有疑问请联系黔易游客服：" + ConfigLoad.getStringValue("SMS.CONTENT_TEL") + "，我们将竭诚为您服务，祝您旅途愉快！";
		//SMSHelper.sendSMS(mobile, mes);*/
	}
	
	/**
	 * 检验订单是否可以审核 只有退款中的订单才可以审核
	 * @param orderId
	 * @return
	 * @throws Exception
	 */
	public boolean checkExamine(Long orderId) throws Exception {
		PageData param = new PageData();
		param.put("orderId", orderId);
		Integer total = (Integer) dao.findForObject("AdminOrderMapper.checkExamine", param);
		if(total == 0){
			return false;
		}
		return true;
	}
	
	/**
	 * 获取审核记录列表
	 * @param orderId
	 * @return
	 * @throws Exception
	 */
	public List<PageData> findExamineList(Long orderId) throws Exception {
		PageData param = new PageData();
		param.put("orderId", orderId);
		return (List<PageData>)dao.findForList("AdminOrderMapper.findExamineList", param);
	}
	
	/**
	 * 获取审核记录信息
	 * @param orderId
	 * @return
	 * @throws Exception
	 */
	public PageData findRefundInfo(Long orderId) throws Exception {
		PageData param = new PageData();
		param.put("orderId", orderId);
		return (PageData)dao.findForObject("AdminOrderMapper.findRefundInfo", param);
	}
	
	
	
	/**
	 * 订单审核-通过
	 * @param param
	 * @throws Exception
	 */
	public void checkSuccess(PageData param) throws Exception{
		PageData orderForm = getOrderById(param.getLong("orderId"));
	
		if(param.getInt("jstSiteKm")!=null){//接团和送团地点一样
			//新增默认接、送团地点
			PageData jstSiteParam = new PageData();
			jstSiteParam.put("name", orderForm.getString("jtSite"));
			jstSiteParam.put("km", param.getInt("jstSiteKm"));
			Long jstSiteId =  jstSiteService.addOneJstSite(jstSiteParam);
			
			//设置订单的接送团地点为默认地点
			param.put("jstSiteId", jstSiteId);
			dao.update("AdminOrderMapper.setJstSiteId", param);
		}else{
			//添加默认路线，接、送团地点
			if(param.getInt("jtSiteKm")!=null){
				//新增默认接、送团地点
				PageData jtSiteParam = new PageData();
				jtSiteParam.put("name", orderForm.getString("jtSite"));
				jtSiteParam.put("km", param.getInt("jtSiteKm"));
				Long jtSiteId =  jstSiteService.addOneJstSite(jtSiteParam);
				
				//设置订单的接团地点为默认地点
				param.put("jtSiteId", jtSiteId);
				dao.update("AdminOrderMapper.setJtSiteId", param);
				
			}
			if(param.getInt("stSiteKm")!=null){
				//新增默认接、送团地点
				PageData stSiteParam = new PageData();
				stSiteParam.put("name", orderForm.getString("stSite"));
				stSiteParam.put("km", param.getInt("stSiteKm"));
				Long stSiteId = jstSiteService.addOneJstSite(stSiteParam);
				//设置订单的送团地点为默认地点
				param.put("stSiteId", stSiteId);
				dao.update("AdminOrderMapper.setStSiteId", param);
			}
		}
		
		if(param.getInt("routeKm") !=null){
			//1.新增默认路线
			PageData routeParam = new PageData();
			routeParam.put("content", orderForm.getString("route"));
			routeParam.put("km",param.getInt("routeKm"));
			routeParam.put("day_num", param.getInt("dayNum"));
			Long defaultRouteId = defaultRouteManagerService.addDefaultRoute(routeParam);
			//2.设置订单的路线为默认路线
			param.put("defRouId", defaultRouteId);
			dao.update("AdminOrderMapper.setDefRouId", param);
		}
		
		//更新订单状态，公里数和价格
		if(orderForm.getDouble("price")!=null){
			dao.update("AdminOrderMapper.checkRemarkSuccess", param);
		}else{
			dao.update("AdminOrderMapper.checkSuccess", param);
		}
		
		
		//审核通过后通知前台用户去支付
		orderForm = getOrderById(param.getLong("orderId"));
		
		StringBuffer sb = new StringBuffer("您的订单审核成功，总公里数:");
		sb.append(orderForm.getString("km")).append(",总价格:").append(orderForm.getString("price")).append(",订单号:").append(orderForm.getString("orderCode"));
		sb.append(orderForm.getString("price")+",订单号");
		String message = sb.toString();
		//4.短信通知
		SMSHelper.sendSms(orderForm.getString("contactNumber"),message );
		//5.邮件通知
		SimpleMailSender.sendEmail(orderForm.getString("userEmail"), "【龙行云】订单审核通过", message, "2");
	}
	
	/**
	 * 订单审核-不通过
	 * @param param
	 * @throws Exception
	 */
	public void checkFail(PageData param) throws Exception{
		
		dao.update("AdminOrderMapper.checkFail", param);
		
		PageData orderForm = getOrderById(param.getLong("orderId"));
		
		//三、审核失败后通知前台用户
		
		
		String message = "对不起！您的订单没有通过审核！订单号："+orderForm.getString("orderCode");
		
		//3.短信通知
		SMSHelper.sendSms(orderForm.getString("contactNumber"),message );
		//4.邮件通知
		SimpleMailSender.sendEmail(orderForm.getString("userEmail"), "【龙行云】订单审核未通过", message, "2");
		
		
	}
	
	/**
	 * 删除订单
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void lgcDelById(Long orderId) throws Exception {
		dao.update("AdminOrderMapper.lgcDelById", orderId);
	}
}
