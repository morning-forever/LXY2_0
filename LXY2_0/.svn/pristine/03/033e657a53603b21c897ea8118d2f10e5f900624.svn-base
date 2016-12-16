package com.lx.controller.app;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.lx.controller.base.BaseController;
import com.lx.service.app.OrderFormService;
import com.lx.util.PageData;
import com.lx.util.XConst;
import com.lx.util.config.ConfigLoad;
import com.lx.util.web_alipay.config.AlipayConfig;
import com.lx.util.web_alipay.util.AlipaySubmit;

@Controller(value = "webOrderController")
@RequestMapping(value = "allowAccess/orders")
public class WebOrderController extends BaseController {

	@Autowired
	private OrderFormService orderFormService;

	/**
	 * 开始支付
	 * 
	 * @return
	 */
	@RequestMapping(value = "pay/{orderId}")
	public ModelAndView pay(@PathVariable Long orderId) {
		ModelAndView mav = new ModelAndView("app/pc/order/alipay");
			Map<String, String> map = new HashMap<String, String>();
			String outTradeNo = orderId+"";
			Double price =0.01; //orderFormService.findRealPriceByOrderId(orderId);
			map.put("service", "create_direct_pay_by_user");
			map.put("partner", AlipayConfig.partner);
			map.put("_input_charset", AlipayConfig.input_charset);
			map.put("payment_type", "1");
			map.put("notify_url", ConfigLoad.getStringValue("webapp.site") + "app/center/order/callback?orderId=" + orderId);
			map.put("return_url", ConfigLoad.getStringValue("webapp.site") + "allowAccess/orders/callback?orderId=" + orderId);
			
			String show_url = ConfigLoad.getStringValue("webapp.site") + "lxy/order/orderDetail/"+orderId;
			System.out.println("-------------outTradeNo---------="+outTradeNo);
			map.put("show_url", show_url);
			map.put("seller_email", AlipayConfig.seller_email);
			map.put("out_trade_no", outTradeNo);
			map.put("subject", "欢迎您使用龙行云");
			map.put("total_fee", price+"");
			map.put("body", "您需要支付订单金额：" + price + "元");
			map.put("anti_phishing_key", "");
			map.put("exter_invoke_ip", "");
			String sHtmlText = AlipaySubmit.buildRequest(map, "post", "确认");
			super.getRequest().setAttribute("text", sHtmlText);

		return mav;
	}

	/**
	 * 支付回调
	 * 
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "callback")
	public ModelAndView payResult() {
		ModelAndView mav = new ModelAndView();
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
			String view = "redirect:result";
			PageData params = super.getPageData();
			Long orderId = params.getLong("orderId");

			boolean isVerfy = true; //AlipayNotify.verify(param);
			if (isVerfy) {
				if ("TRADE_SUCCESS".equals(params.getString("trade_status"))) {
					String trade_no = params.getString("trade_no");
					boolean isOk = true; //webOrderService.checkOrderState(orderId, XConst.ORDER_STATE.WAITPAY.toString());
					if (isOk) {
						boolean isPayOk = orderFormService.updateOrderPay(orderId, trade_no, "alipay");
						if (isPayOk) {
							mav.addObject("payState", "success");
						}
					} else {
						mav.addObject("payState", "payed");
					}
				}
			}
			mav.addObject("orderId", orderId);
			mav.setViewName(view);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mav;
	}

	/**
	 * 跳转页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "result")
	public ModelAndView result() {
		ModelAndView mav = new ModelAndView();
		PageData param = super.getApiPageData();
		mav.addObject("orderId", param.getLong("orderId"));
		mav.addObject("orderType", param.getString("orderType"));
		String payState = param.getString("payState");
		if (XConst.SUCCESS.equals(payState)) {
			mav.setViewName("app/pc/order/payment_success");
		} else {
			mav.addObject("payState", payState);
			mav.setViewName("app/pc/order/payment_fail");
		}
		return mav;
	}


}
