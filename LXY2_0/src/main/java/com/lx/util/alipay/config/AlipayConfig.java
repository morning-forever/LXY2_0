package com.lx.util.alipay.config;

/* *
 *类名：AlipayConfig
 *功能：基础配置类
 *详细：设置帐户有关信息及返回路径
 *版本：3.3
 *日期：2012-08-10
 *说明：
 *以下代码只是为了方便商户测试而提供的样例代码，商户可以根据自己网站的需要，按照技术文档编写,并非一定要使用该代码。
 *该代码仅供学习和研究支付宝接口使用，只是提供一个参考。
	
 *提示：如何获取安全校验码和合作身份者ID
 *1.用您的签约支付宝账号登录支付宝网站(www.alipay.com)
 *2.点击“商家服务”(https://b.alipay.com/order/myOrder.htm)
 *3.点击“查询合作者身份(PID)”、“查询安全校验码(Key)”

 *安全校验码查看时，输入支付密码后，页面呈灰色的现象，怎么办？
 *解决方法：
 *1、检查浏览器配置，不让浏览器做弹框屏蔽设置
 *2、更换浏览器或电脑，重新登录查询。
 */

public class AlipayConfig {
	
	//↓↓↓↓↓↓↓↓↓↓请在这里配置您的基本信息↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓
	// 合作身份者ID，以2088开头由16位纯数字组成的字符串
	public static String partner = "2088021723223192";
	// 商户的私钥
	public static String private_key =  "MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAKh+fIZH8AUH0TLvfYto48GTHsW59AP1dDBmpiVjN4Izb4DSZQHboLTwECsiZOLp7lKXcuoXTa/gw/WtjZbUC9ACXHxLuey7DFkMvzI0h8X+QTr2XFjAAsW1ARlIAc99WvXQnmRWjCd7vFwnfUxezVNHVLvewEP6xsDm08j7u5TnAgMBAAECgYAzLYghOUR8Iq22LOwTJh7XsxoLsLmfYjSSZvtcK9C2aW0a0c0ATXd4vdoLX/0It0k+KOYsmDtuinS68KYrA+k6HNS71hjmlzlAfvCszP4QjPMGeU58uggMpGqOHMZqKvJPjWlElpzJ7P0V46jYlZ9hQQPYbXX38JEVjHxw4d2ycQJBANjUTNXvCxTQv6JUI9zIWQjJkF086GdTqiCReOOFg6LITtQYgHxmZmdJ35LpBYPweOEd/eRwfpw1dyZw9cgziH0CQQDG7tQxFSD4+pswHp3ryTstB69gwYgN7duoTYogeQSDJDNMJPKx0zwUfFOSW5W1isrOrY3WUq9lmhVJUv0zFjQzAkEAvOs0yw1MvWUoIvpmiL4y/PoKA4LHBwgZaej1yF8TE2itbhSvFjRuMr5lwu2utYd2+sWT6k6tsdLPrrmrHDTyTQJAUgX7e9loZQB/qFGXb7bjLWfzygNCI+wlG7oM7+K2F5R/ii/Z2bRtG00/8CLPEbGOebVZvDsPkub7S+Zp+/x1vQJAFv53dQQMO11khMnbhnmbF4GKPedZbM37f/8b9EzrFzVjN4P8pWNYdaUUI/k+Qxw38B+g2yigKmwf3YFktycrOA==";
	// 支付宝的公钥，无需修改该值
	public static String ali_public_key  =	"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDDI6d306Q8fIfCOaTXyiUeJHkrIvYISRcc73s3vF1ZT7XN8RNPwJxo8pWaJMmvyTn9N4HQ632qJBVHf8sxHi/fEsraprwCtzvzQETrNRwVxLO5jVmRGi60j8Ue1efIlzPXV9je9mkjzOmdssymZkh2QhUrCmZYI/FCEa3/cNMW0QIDAQAB";
	//↑↑↑↑↑↑↑↑↑↑请在这里配置您的基本信息↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑
	
	// 调试用，创建TXT日志文件夹路径
	public static String log_path = "D:\\";

	// 字符编码格式 目前支持 gbk 或 utf-8
	public static String input_charset = "utf-8";
	
	// 签名方式 不需修改
	public static String sign_type = "RSA";
}
