package com.lx.controller.app;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lx.controller.base.BaseController;
import com.lx.service.app.OrderFormService;
import com.lx.util.PageData;
import com.lx.util.XConst;
import com.lx.util.alipay.config.AlipayConfig;


/**
 * 个人中心 订单
 * 
 * @author mike <br>
 *         2015年10月19日
 */
@Controller(value = "appCenterOrderController")
@RequestMapping(value = "app/center/order")
public class AppCenterOrderController extends BaseController {

	@Autowired
	private OrderFormService orderFormService;
	
	/**
	 * app端支付回调
	 * 
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "callback")
	@ResponseBody
	public String payResult() {
		try {
			Map requestParams = super.getRequest().getParameterMap();
			Map<String, String> param = new HashMap<String, String>();
			for (Iterator iter = requestParams.keySet().iterator(); iter.hasNext();) {
				String name = (String) iter.next();
				String[] values = (String[]) requestParams.get(name);
				String valueStr = "";
				
				for (int i = 0; i < values.length; i++) {
					valueStr = (i == values.length - 1) ? valueStr + values[i] : valueStr + values[i] + ",";
				}
				
				valueStr = new String(valueStr.getBytes("ISO-8859-1"), AlipayConfig.input_charset);
				param.put(name, valueStr);
			}
			System.out.println("param :" + param);
//			boolean isVerfy = AlipayNotify.verify(param);
			boolean isVerfy = true;
			if (isVerfy) {
				PageData params = super.getPageData();
				Long orderId = params.getLong("orderId");
				if ("TRADE_SUCCESS".equals(params.getString("trade_status"))) {
					String trade_no = params.getString("trade_no");
					orderFormService.updateOrderPay(orderId, trade_no, "alipay");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return XConst.SUCCESS;
	}
	
}