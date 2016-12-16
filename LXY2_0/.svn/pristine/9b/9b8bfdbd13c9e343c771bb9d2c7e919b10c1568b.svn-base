package com.lx.service.system;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.lx.dao.DaoSupport;
import com.lx.service.app.CarManagerService;
import com.lx.util.PageData;
import com.lx.util.config.ConfigLoad;
import com.lx.util.emaysms.SMSHelper;
import com.lx.util.mail.SimpleMailSender;

/**
 * 定时任务服务
 * 
 * @author gcy <br>
 *         2015年4月2日
 */
@Service
public class TaskService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	@Resource
	private CarManagerService carManagerService;
	
	/**
	 * 订单关闭：下订单超过半个小时未支付 或审核通过后24小时内未支付，订单将关闭 
	 * 
	 * @throws Exception
	 */
	@Scheduled(cron = "0 0-59 0-23 * * ?")
	@Transactional
	public void orderCloseTask() throws Exception {
		dao.update("AdminOrderMapper.closePayTimeOutOrder", null);
	}
	
	/**
	 * 锁车超过10分钟，将车辆释放掉
	 * @throws Exception 
	 */
	@Scheduled(cron = "0 0-59 0-23 * * ?")
	@Transactional
	public void freeCarsTimeout10() throws Exception{
		dao.update("AdminOrderMapper.freeCarsTimeout10", null);
	}
	
	/**
	 * 订单已出车，将订单状态更新为FINISH，不让用户退款
	 * @throws Exception 
	 */
	@Scheduled(cron = "0 0-59 0-23 * * ?")
	public void updateOrderToFinish() throws Exception{
		System.out.println("************************订单已出车，将订单状态更新为FINISH，不让用户退款*****************************");
		dao.update("AdminOrderMapper.updateToFinish", null);
	}
	
	

	//@SuppressWarnings("unchecked")
	//@Scheduled(cron="0 0 16 * * ?")
	public void remindUser() throws Exception{
		
		//1.找出第三天要发车的订单
		@SuppressWarnings("unchecked")
		List<PageData> willStartOrders = (List<PageData>) dao.findForList("OrderFormMapper.getWillStartOrder", null);
		
		for(PageData willStartOrder : willStartOrders){
			
			//2.发通知
			//a.编辑通知消息
			String message = "您的订单出发时间为后天（"+willStartOrder.getString("startTime")+"），特此通知，请准备好";
			
			//b.短信通知
			SMSHelper.sendSms(willStartOrder.getString("personPhone"), message);
					
			//c.邮件通知
			SimpleMailSender.sendEmail(willStartOrder.getString("personEmail"), "出发通知", message, "2");
		}
		
	}
	
	@Async
	public void orderNotice(String adminMessage,String message,String contactNumber,String EMAIL) throws Exception{
		//3.1. 通知前台用户
		//3.1.1.短信通知
		SMSHelper.sendSms(contactNumber, message);
		
		//3.1.2.邮件通知
		SimpleMailSender.sendEmail(EMAIL, "用户订车通知", message, "2");
		
		//3.2通知后台用户
		
		//3.2.1.短信通知
		SMSHelper.sendSms(ConfigLoad.getStringValue("webapp.send_phone"), adminMessage);
		
		//3.2.1.邮件通知
		SimpleMailSender.sendEmail(ConfigLoad.getStringValue("webapp.send_notice_email"), "用户订车通知",adminMessage, "2");
	}
	
	
	
	
	
	

}
