package com.lx.controller.app.pc;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.lx.controller.base.BaseController;
import com.lx.entity.system.User;
import com.lx.service.system.appuser.AppuserService;
import com.lx.util.Const;
import com.lx.util.HString;
import com.lx.util.MD5;
import com.lx.util.PageData;
import com.lx.util.XConst;


@Controller(value = "UserCenterController")
@RequestMapping(value = "app/pc/user")
public class UserCenterController extends BaseController {
	
	
	@Autowired
	private AppuserService appuserService;

	/**
	 * @return
	 */
	@RequestMapping(value = "center")
	public ModelAndView userCenter() {
		ModelAndView mav = new ModelAndView("app/pc/usercenter/index");
		try {
			Subject currentUser = SecurityUtils.getSubject();  
			Session session = currentUser.getSession();
			User user = (User)session.getAttribute(Const.APP_USER);
			if(user != null){
				PageData pd = new PageData();
				pd.put("USER_ID", user.getUSER_ID());
				PageData res = appuserService.findByUiId(pd);
				mav.addObject("userInfo", res);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mav;
	}
	
	@RequestMapping(value = "password/setting")
	public ModelAndView settingPassword() {
		ModelAndView mav = new ModelAndView("app/pc/usercenter/settingPassword");
		try {
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mav;
	}
	
	/**
	 * 修改密码
	 * 
	 * @return
	 */
	@RequestMapping(value = "changePass")
	@ResponseBody
	public PageData changePass() {
		PageData res = new PageData();
		res.putFlag(false);
		try {
			PageData param = super.getPageData();

			String password = param.getString("password");
			String newPassword = param.getString("newPassword");
			String rnewPassword = param.getString("rnewPassword");

			if (HString.isEmpty(password) || HString.isEmpty(newPassword) || HString.isEmpty(rnewPassword)) {
				res.putStatus(XConst.PARAM_ERR);
				return res;
			}
			
			Subject currentUser = SecurityUtils.getSubject();
			Session session = currentUser.getSession();
			User user = (User)session.getAttribute(Const.APP_USER);
			String userId = user.getUSER_ID();
			if (!HString.isEmpty(userId)) {
				
				PageData pd = new PageData();
				pd.put("USER_ID", user.getUSER_ID());
				PageData userPd = appuserService.findByUiId(pd);
				
				String ecPass = MD5.md5(password);
				System.out.println("******changePass******* ecPass="+ecPass);
				System.out.println("******changePass******* oldPass="+userPd.getString("PASSWORD"));
				
				if (ecPass.equals(userPd.getString("PASSWORD"))) {
					if (newPassword.equals(rnewPassword)) {
						param.put("USER_ID", userId);
						param.put("PASSWORD", MD5.md5(newPassword));
						System.out.println("******changePass******* newPassword="+MD5.md5(newPassword));
						appuserService.changePassword(param);
					
						res.putStatus(XConst.SUCCESS);
					} else {
						res.putStatus("re_pass_err");
					}
				} else {
					res.putStatus(XConst.LOGIN_USER_PASS_ERR);
				}
			}
		} catch (Exception e) {
			res.putStatus(XConst.EXCEPTION);
			e.printStackTrace();
		}
		return res;
	}
	
	@RequestMapping(value = "message")
	public ModelAndView message() {
		ModelAndView mav = new ModelAndView("app/pc/usercenter/message");
		try {
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mav;
	}

}
