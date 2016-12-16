package com.lx.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.lx.entity.system.User;
import com.lx.util.Const;
import com.lx.util.Jurisdiction;
/**
 * 
* 类名称：LoginHandlerInterceptor.java
* 类描述： 
* @author FH
* 作者单位： 
* 联系方式：
* 创建时间：2015年1月1日
* @version 1.6
 */
public class LoginHandlerInterceptor extends HandlerInterceptorAdapter{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		// TODO Auto-generated method stub
		String path = request.getServletPath();
		if(path.matches(Const.NO_INTERCEPTOR_PATH)){
			return true;
		}else{
			/**
			 * 以下是前台用户和后台用户的检查。
			 * 如果只有shiro的那段配置而不改成如下代码，会有如下问题：
			 * 		前台用户登录后，访问带有Admin的路径时，shiro验证通过，但其实应不让其通过，应让其跳到后台的Login_url
			 *
			 * 所以在这里要特别地指明：当访问路径带有"admin"时，要检验"后台用户"的登录情况（虽然shiro已经配置了"/admin/**=authc",但此时shiro是验证通过的，因为前台用户已经登录过）
			 * 
			 * ....
			 * 哎，其实有了这个之后shiro的拦截已经是多余的了，只不过用了shiro的session，就不得不在spring的配置文件配置shiro，配置了shiro之后，就不得不配置loginUrl，
			 * 因为如果不配置，shiro的loginUrl默认为web应用根路径下的login.xxx，可我们又没有login.xxx这个文件。
			 * 
			 * 
			 * 综上，现在只好做成“这个拦截器和shiro”兼容。可能gcy之后会去看一下shiro到底怎么用好，到时这个拦截器完全可以不要了，shiro可以帮我们做好所有关于“安全的”事情
			 */
			//shiro管理的session，判断前后台用户是否登录
			Subject currentUser = SecurityUtils.getSubject();  
			Session session = currentUser.getSession();
			
			if(path!=null && path.contains("admin")){//当路路径包含admin时，判断后台用户是否登录，并判断是否有此权限
				
				User user = (User)session.getAttribute(Const.SESSION_USER);
				
				if(user!=null){//后台用户已经登录，要判断后台用户是否有此菜单访问权限
					
					path = path.substring(1, path.length());
					
					boolean b = Jurisdiction.hasJurisdiction(path);//判断权限
					
					if(!b){//如果没有权限，则重定向到登录页面
						response.sendRedirect(request.getContextPath() + Const.ADMIN_LOGIN);
					}
					return b; //b为TRUE代表有权限，让其通过；b为false无此权限，让其不通过。如果b为false,早已在上面代码进行重定向，不用担心重定向问题
				}
				//后台用户没有登录，直接重定向到后台登录界面
				response.sendRedirect(request.getContextPath() + Const.ADMIN_LOGIN);
				
				return false;
			}else{
				User user = (User)session.getAttribute(Const.APP_USER);
				if(user!=null){//前端用户已登录，直接通过
					return true;
				}else{//前端用户没登录-》先登录
					if(request.getHeader("x-requested-with")!=null && request.getHeader("x-requested-with").equalsIgnoreCase("XMLHttpRequest")){//如果是ajax请求
						response.setHeader("session_status", "timeout");
						return false;
					}
					response.sendRedirect(request.getContextPath() + Const.APP_LOGIN);
					return false;		
				}
			}
		}
	}
	
}
