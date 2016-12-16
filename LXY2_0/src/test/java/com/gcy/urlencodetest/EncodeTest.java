package com.gcy.urlencodetest;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;

public class EncodeTest {
	
	public static void main(String args[]) throws UnsupportedEncodingException{
		String url = "http://www.longxingcloud.com/lxy/order/edit/52.html";
		url = URLEncoder.encode(url, "utf-8");
		System.out.println(url);
		System.out.println(URLDecoder.decode(url, "utf-8"));
	}
}
