package com.lx.util;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;

/**
 * 常量设置
 * 
 * @author
 *
 */
public interface XConst {
	/**
	 * 订单状态（ <br>
	 * WAITPAY:等待付款<br>
	 * PAYING:支付中<br>
	 * PAY_OK:交易成功 <br>
	 * CLOSED:交易关闭 <br>
	 * REFUNDING:退款中 <br>
	 * REFUNDING_UNPOOL: 退款中-拼单失败(拼车才有)<br>
	 * REFUNDING_FAIL: 退款失败<br>
	 * REFUNDED:退款完成 <br>
	 * CONSUME:已消费 <br>
	 * UNCONSUME:未消费<br>
	 * FINISH:订单完成（相当于已消费，龙行云订车平台）<br>
	 * CHECKSUCCESS:审核成功（龙行云订车平台自定义路线，自定义附加体验的审核）<br>
	 * 
	 */
	enum ORDER_STATE {
		CHECKING,CHECKSUCCESS,CHECKFAIL,WAITPAY,PAYING, PAY_OK, FINISH,CLOSED,CANCELED, REFUNDING, REFUNDING_UNPOOL, REFUNDING_FAIL, REFUNDED, CONSUME, UNCONSUME
	};
	
	enum PAY_METHOD{
		NO,ALLPAY,PARTPAY,PARTPAYED,ALLPAYED
	};
	
	enum ORDER_TYPE{
		VOUCHER,GENERAL_GOODS
	};
	
	
	/**
	 * 1条车辆状态是锁定的还是释放的？（10分钟内没有提交订单就将车释放掉）
	 * @author gcy
	 *
	 */
	enum CAR_STATE{
		LOCKED,
		UNLOCKED
	};
	/**
	 * 司机是否空闲
	 */
	enum DRIVER_STATE{
		IDLE,BUSY
	}
	
	
	
	/**
	 * 路线类型
	 * @author Administrator
	 * DEFAULT 常规路线
	 * USER_DEFINED 用户定义的（自定义）
	 */
	enum ROUTE_TYPE{
		DEFAULT,USER_DEFINED;
	}
	
	/**
	 *1. WAIT_USE:订单支付成功后生成代金券的初始状态为“待使用”
	 *2. WAIT_CONFIRM:用户点击使用后，代金券的状态变更为“待管理员确认”（点击后，后台会发送验证码给用户手机，用户凭此验证码让商户管理员确认）
	 *3. USED:商户管理员使用用户提供的手机号和验证码查到对应代金券后点击确认，这时状态变更为“已使用”
	 *
	 */
	
	String OT = "orderType";
	
	/**
	 * 
	 * @author guochaoyong
	 * 具体代金券的状态
	 *WAIT_PAY:待支付（用户下单完成时的状态）
	 *PAYING:支付中（用户正在使用微信或支付宝支付时的状态）
	 *WAIT_USE:待使用（用户支付完成时的状态）
	 *WAIT_CONFIRM:待确认（用户点击使用后的状态）
	 *USED:已使用（商户管理元点击确认后的状态）
	 */
	enum USER_VOUCHER_STATE{
		WAIT_USE,WAIT_CONFIRM,USED,OVERDUE
	}
	
	Integer MOBILE_PAGE_SIZE = 5;
	Integer PC_PAGE_SIZE = 10;

	
	/**
	 * 车类型 <br>
	 * RENT 租车<br>
	 * BUS 班车<br>
	 * CARPOOL 拼车<br>
	 * WRAP 包车<br>
	 */
	enum CART_TYPE {
		carRent, BUS, CARPOOL, carWrap
	};

	enum ORDER {
		DESC, ASC
	};

	enum MODEL_STATE {
		NORMAL, DELETE
	};

	enum AUDIT_STATE {
		OK, NO, WAIT
	};

	enum DATA_STATE {
		ADD, MOD, DEL
	};

	Long PAGE_SIZE = 10l;

	String STATUS_KEY = "status";

	String DEFAULT_PWD = "888888";

	/**
	 * 缓冲的字节大小
	 */
	Integer BUFFER = 1024;

	String DATE_TIME_24H = "yyyy-MM-dd HH:mm:ss";

	String SESSION_MENU = "session_menu";
	String SESSION_USER = "session_user";
	String SESSION_RIGHT = "session_right";
	String SESSION_SYSSET = "system";
	String RIGHT_SYSTEM = "SYSTEM";

	String REQUEST = "request";
	String PARAM_ERR = "param_err";

	String API_DATA = "api_data";

	String DATA_SUCCESS = "data_success";
	String DATA_FAIL = "data_fail";
	String DATA_EMPTY = "data_empty";

	String FAIL = "fail";
	String SUCCESS = "success";
	String ERROR = "error";
	String UNLOGIN = "unlogin";
	String EXCEPTION = "exception";
	String EXISTS = "exists";
	String NO_EXISTS = "no_exists";
	String USED = "used";//使用中
	String ALREADY_SUBMIT="already_submit";//表单已提交标识
	
	
	String ACQUIRED_WAIT_60 ="acquired_wait_60";   

	String DATE_SEC = "sec";
	String DATE_MIN = "min";
	String DATE_HOUR = "hour";
	String DATE_DAY = "day";
	String DATE_MOU = "mou"; // 按照每月30天算
	String DATE_YEAR = "year"; // 按照每年365天算

	String DB_EXISTS = "db_exists";// 数据库存在
	String TB_EXISTS = "TB_exists";// 表存在

	String FORMAT_FAIL = "format_fail";
	String CHECKED_SUCCESS = "checked_success";
	String CHECKED_FAIL = "checked_fail";

	String V_CODE_ERROR = "v_code_error";

	String CHECKED_EMAIL_SUCCESS = "checked_email_success";
	String CHECKED_EMAIL_FAIL = "checked_email_fail";

	String CHECKED_PHONE_SUCCESS = "checked_phone_success";
	String CHECKED_PHONE_FAIL = "checked_phone_fail";

	String FORMAT_ERROR = "format_error";
	String EMPTY = "empty";

	String LOGIN_USER_PASS_ERR = "login_user_pass_err";// 用户名或密码错误
	String USER_IS_NOT_FONUD = "user_is_not_found";// 用户不存在
	String NO_PERMISSION = "no_permission"; // 权限不足
	String USER_IS_CONTAIN = "user_is_contain";// 登录被禁止
	String LOGIN_IS_BAN = "login_is_ban";// 登录被禁止
	String ASK_IS_BAN = "ask_is_ban";// 发言被禁止
	String LOGIN_TIME_OUT = "login_time_out";

	String USER_NAME_ERR = "user_name_err";
	String USER_LOGIN_ID_ERR = "user_login_id_err";
	String USER_PWD_ERR = "user_pwd_err";
	String USER_RE_PWD_ERR = "user_re_pwd_err";

	String CHECK_TYPE_ERROR = "check_type_error";
	String CHECK_SIZE_ERROR = "check_size_error";

	String PARAM_EMPTY = "param_empty";// 参数为空
	String PARAM_ERROR = "param_error";// 参数错误

	int HOT_REPLY_COUNT = 10;// 热帖回复数值标准

	Integer API_STATUS_SUCCESS = 1; // 成功
	Integer API_STATUS_FIALED = 0; // 失败

	String API_STATUS_TOKEN = "token_err"; // token匹配失败

	String API_TOKEN_KEY = "Token";
	String API_TOKEN_OLD_KEY = "oldToken";
	String API_RETURN_STATUS_KEY = "status";
	String API_RETURN_MSG_KEY = "msg";
	String API_DATA_KEY = "data";

	String API_MSG_TOKEN_ERR = "请求的token不能通过检验";

	String WEB_ROOT_PATH = XConst.class.getResource("/").getPath().replaceAll("%20", " ")
			.substring(0, XConst.class.getResource("/").getPath().replaceAll("%20", " ").indexOf("WEB-INF"));

	String API_TIMEOUT = "api_timeout";// 超时

	String API_ILLEGAL_CHAR = "api_illegal_char";// 非法字符

	String SQL_REG = "(?:')|(?:--)|(/\\*(?:.|[\\n\\r])*?\\*/)|(\\b(select|update|and|or|delete|insert|trancate|char|into|substr|ascii|declare|exec|count|master|into|drop|execute)\\b)";
	Pattern SQLPATTREN = Pattern.compile(SQL_REG, Pattern.CASE_INSENSITIVE);

	List<String> CHARLIST = new ArrayList<String>();

	//二级回复最大条数
	Integer MAX_SECONDARY_NUMBER = 9999;
	
	
	

	// Hham update
	public static final String JSON_PRODUCES = "application/json;charset=utf-8";
	
	public static final String FlAG = "flag";
	
	public static final String MESSAGE = "message";
	
	public static final String DATA = "data";
	
	public static final String NO_PRICE="no_price";
	
	public static final String ANDROID="android";
	public static final String IOS="ios";
	
	
	
	//黔易宝商户端角色键
	String MERCH_ROLE_KEY = "MERCH";
}
