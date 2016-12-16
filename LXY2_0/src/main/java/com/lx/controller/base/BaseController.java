package com.lx.controller.base;


import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.lx.entity.UserToken;
import com.lx.entity.common.Page;
import com.lx.service.app.TokenService;
import com.lx.util.HString;
import com.lx.util.Logger;
import com.lx.util.PageData;
import com.lx.util.UuidUtil;
import com.lx.util.XConst;

public class BaseController {
	
	protected Logger logger = Logger.getLogger(this.getClass());

	
	/**
	 * 得到PageData
	 */
	public PageData getPageData(){
		return new PageData(this.getRequest());
	}
	
	/**
	 * 在api中获取pageData
	 * 
	 * bs 只需要一个参数 <br>
	 * 当bs为空或者bs[0]为true的时候表示获取request值
	 * 
	 * @param bs
	 * @return
	 */
	public PageData getApiPageData(boolean... bs) {
		PageData pageData = null;
		if (bs.length == 0 || bs[0]) {
			pageData = new PageData(this.getRequest());
			Long pageNo = pageData.getLong("pageNo");
			Long showLine = pageData.getLong("showLine");
			Long startLine = 0l;

			if (HString.isEmpty(showLine))
				showLine = 10l;
			if (!HString.isEmpty(pageNo)) {
				if (pageNo < 1)
					pageNo = 1l;
				startLine = (pageNo - 1) * showLine;
			}
			pageData.put("startLine", startLine);
			pageData.put("showLine", showLine);
		} else {
			pageData = new PageData();
			pageData.put("Token", get32UUID());
		}
		return pageData;
	}
	
	/**
	 * 得到ModelAndView
	 */
	public ModelAndView getModelAndView(){
		return new ModelAndView();
	}
	
	/**
	 * 得到request对象
	 */
	public HttpServletRequest getRequest() {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		
		return request;
	}

	/**
	 * 得到32位的uuid
	 * @return
	 */
	public String get32UUID(){
		
		return UuidUtil.get32UUID();
	}
	
	/**
	 * 得到分页列表的信息 
	 */
	public Page getPage(){
		
		return new Page();
	}
	
	/**
	 * 在sys中获取pageData
	 * 
	 * bs 只需要一个参数 <br>
	 * 当bs为空或者bs[0]为true的时候表示获取request值
	 * 
	 * @param bs
	 * @return
	 */
	public PageData getSysPageData() {
		PageData pageData = new PageData(this.getRequest());
		String pageNo = pageData.getString("start");
		String showLine = pageData.getString("length");

		int sl = 10;
		if (!HString.isEmpty(showLine))
			sl = Integer.parseInt(showLine);
		if (!HString.isEmpty(pageNo)) {
			pageData.put("startLine", Integer.parseInt(pageNo));
			pageData.put("showLine", sl);
		}

		return pageData;
	}
	
	/**
	 * 检查参数是否完整
	 * 
	 * @param method
	 * @param data
	 * @param params
	 * @param values
	 * @return
	 */
	public static boolean checkParam(String method, PageData data, String[] params, String[] pvals) {
		boolean result = false;
		int falseCount = 0;
		String[] tempArray = new String[20]; // 临时数组
		int size = params.length;
		for (int i = 0; i < size; i++) {
			String param = params[i];
			if (!data.containsKey(param)) {
				tempArray[falseCount] = pvals[i] + "--" + param;
				falseCount += 1;
			}
		}
		if (falseCount > 0) {
			String error = method + "接口，请求协议中缺少 " + falseCount + "个 参数：";
			for (int j = 1; j <= falseCount; j++) {
				String e2 = "   第" + (j) + "个：" + tempArray[j - 1];
				error += e2 + "  ";
			}
			data.clear();
			System.err.println(error);
			data.put(XConst.API_RETURN_MSG_KEY, error);
			data.put(XConst.API_RETURN_STATUS_KEY, XConst.API_STATUS_FIALED);
		} else {
			result = true;
		}
		return result;
	}
	
	
	@Resource(name = "tokenService")
	private TokenService tokenService;
	
	/**
	 * 更新数据库和用户的token
	 * 
	 * @param pageData
	 * @throws Exception
	 */
	protected void updateNewToken(PageData pageData) throws Exception {
		if (pageData.containsKey("oldToken")) {
			pageData.put("Token", get32UUID());
			tokenService.update(pageData);
			pageData.remove("oldToken");
		} else {
			tokenService.delete(pageData);
			tokenService.insert(pageData);
		}
	}

	/**
	 * 检查token是否匹配
	 * 
	 * @param pageData
	 * @return
	 * @throws Exception
	 */
	protected boolean isTokenSuccess(PageData pageData) throws Exception {
		UserToken token = tokenService.getToken(pageData);
		boolean isSuccess = (token != null) ? true : false;
		if (!isSuccess) {
			pageData.clear();
			/*
			 * pageData.put(XConst.API_RETURN_STATUS_KEY, XConst.API_STATUS_TOKEN); pageData.remove(XConst.API_TOKEN_KEY); pageData.remove(XConst.API_TOKEN_OLD_KEY); pageData.put(XConst.API_RETURN_MSG_KEY, XConst.API_MSG_TOKEN_ERR);
			 */
			/*pageData.putFlag(false);*/
			pageData.putMessage(XConst.API_STATUS_TOKEN);
		}
		return isSuccess;
	}
	
	
	public static void logBefore(Logger logger, String interfaceName){
		logger.info("");
		logger.info("start");
		logger.info(interfaceName);
	}
	
	public static void logAfter(Logger logger){
		logger.info("end");
		logger.info("");
	}
	
}
