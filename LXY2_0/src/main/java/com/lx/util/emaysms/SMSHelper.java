package com.lx.util.emaysms;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import com.lx.util.emaysms.httpclient.SDKHttpClient;

public class SMSHelper {
	
	public static String sendSms(String phone,String content) throws UnsupportedEncodingException{
		
		content = SmsConfig.NAME+content;
		String message = URLEncoder.encode(content, "UTF-8");
		long seqId = System.currentTimeMillis();
		String parameters = "cdkey=" + SmsConfig.SN + "&password=" + SmsConfig.PASSWORD + "&phone=" + phone + "&message=" + message + "&addserial=&seqid=" + seqId;
		String url = SmsConfig.BASEURL + "sendsms.action";
		String result = SDKHttpClient.sendSMS(url, parameters);
		
		System.out.println("发送结果:" + result);
		
		
		return result;
	}
}
