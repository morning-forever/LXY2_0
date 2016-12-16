package com.lx.controller.app.pc;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.lx.bo.LockCar;
import com.lx.controller.base.BaseController;
import com.lx.entity.system.User;
import com.lx.exception.CarNotEnoughException;
import com.lx.service.app.CarManagerService;
import com.lx.service.app.DefaultRouteManagerService;
import com.lx.service.app.JstSiteService;
import com.lx.service.app.OrderFormService;
import com.lx.service.system.TaskService;
import com.lx.util.Const;
import com.lx.util.PageData;
import com.lx.util.XConst;
import com.lx.util.XConst.CAR_STATE;
/** 
 * 类名称：
 * 创建人： 
 * 创建时间：
 */
@Controller
@RequestMapping(value="lxy/car")
public class ReservationCarController extends BaseController {
	
	@Resource
	private CarManagerService carManagerService;
	
	@Resource
	private TaskService taskService;
	
	@Resource
	private JstSiteService JstSiteService;
	
	@Resource
	private DefaultRouteManagerService defRouManService;
	
	@Resource
	private OrderFormService orderFormService;
	
	
	/**
	 * 订车首页（主要用于填单）
	 */
	@RequestMapping(value="/reservation/index")
	public ModelAndView reservationIndex(){
		ModelAndView mv = new ModelAndView("app/pc/reservation_car");
		
		return mv;
	}
	
	/**
	 * 根据关键字（keywords 获得接送团地点列表）
	 * @param kw
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping("getJstSiteListByKw")
	@ResponseBody
	public List<PageData> getJstSiteListByKw() throws Exception{
		PageData param = getPageData();
		String kw = param.getString("q");
		List<PageData> JstSiteList = JstSiteService.getJstSiteListByKw(kw);
		
		return JstSiteList;
	}
	
	/**
	 * 根据关键字获得路线列表
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("getRouteListByKw")
	@ResponseBody
	public List<PageData> getRouteListByKw() throws Exception{
		PageData param = getPageData();
		List<PageData> routeList = defRouManService.getRouteListByKw(param);
		
		return routeList;
			
	}
	
	@RequestMapping("available_cars")
	@ResponseBody
	public PageData getAvailableCarList(LockCar lockCar){
		
		PageData param = getPageData();
		PageData res = new PageData();
		try {
			List<PageData> availableCarList =  carManagerService.getAvailableCars(param);
			res.putStatus(XConst.SUCCESS);
			res.put("carList", availableCarList);
		} catch (Exception e) {
			e.printStackTrace();
			res.putStatus(XConst.EXCEPTION);
		}
		
		return res;
	}
	
	/**
	 * 锁车
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/lockCar",produces="application/json;charset=UTF-8")
	@ResponseBody
	public PageData lockCar(@RequestBody LockCar lockCar) throws Exception{
		PageData res=new PageData();
		try{
			//shiro管理的session
			Subject currentUser = SecurityUtils.getSubject();  
			Session session = currentUser.getSession();
			//用户不为空，则可以锁车
			User user = (User)session.getAttribute(Const.APP_USER);
			if (user != null) {
				//先把之前已经锁住的车给释放掉
				List<Long>  lastCarStateIds = (List<Long>) session.getAttribute("carStateIds");
				if(lastCarStateIds !=null){
					carManagerService.freeCars(lastCarStateIds);
				}
				//锁车
				lockCar.setUserId(user.getUSER_ID());
				PageData lockedCars= carManagerService.lockCar(lockCar);
				
				//将已锁定的车辆保存在session
				session.setAttribute("carStateIds",lockedCars.get("carStateIds") );
				session.setAttribute("lockedCars", lockedCars.get("lockedCars"));
				res = lockedCars;
				res.putStatus(XConst.SUCCESS);
			}else{
				res.putStatus(XConst.UNLOGIN);
			}
		}catch(CarNotEnoughException cne){
			res.putMessage(cne.getMessage());
			cne.printStackTrace();
		}catch (Exception e) {
			res.putStatus(XConst.EXCEPTION);
			e.printStackTrace();
		}
		return res;
	}
	
	
	
	/**
	 * 当订车页面刷新或关闭，释放已锁定的车辆
	 * @throws Exception 
	 */
	/*@RequestMapping("freeCars")
	public void freeCars() throws Exception{
		Subject currentUser = SecurityUtils.getSubject();  
		Session session = currentUser.getSession();
		
		@SuppressWarnings("unchecked")
		List<Long> carStateIds = (List<Long>) session.getAttribute("carStateIds");
		if(carStateIds != null){
			session.removeAttribute("carStateIds");
			session.removeAttribute("lockedCars");
			carManagerService.freeCars(carStateIds);
		}
		
	}*/
	
	/**
	 * 车辆是否已经超时(跳到订单确认页面前，要做此验证)
	 * @return 返回true表示已经超时，返回false表示还未超时
	 * @throws Exception 
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("isCarTimeOut")
	@ResponseBody
	public PageData isCarTimeOut() throws Exception{
		PageData res = new PageData();
		Subject currentUser = SecurityUtils.getSubject();  
		Session session = currentUser.getSession();
		List<Long> carStateIds = (List<Long>) session.getAttribute("carStateIds");
		
		String carState = carManagerService.getCarUseStaById(carStateIds.get(0));
		if(carState.equals(CAR_STATE.UNLOCKED.toString())){
			res.putStatus(true);
		}else{
			res.putStatus(false);
		}
		
		return res;
	}
	
	/**
	 * 收集表单数据，判断该订单是否需要审核，计算价格等，返回 用户CHECK订单的界面
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("detail_check")
	public ModelAndView detailCheck() throws Exception{
		ModelAndView mav = new ModelAndView("app/pc/order/detail_check");
		
		Subject currentUser = SecurityUtils.getSubject();  
		Session session = currentUser.getSession();
		
		PageData pageData = getPageData();
		pageData = orderFormService.detailCheck(pageData,(List<Long>)session.getAttribute("carStateIds"));//里面主要是判断是否需要审核和算价格
		
		//表单数据存在session里面（包含有订单的公里数价格等），提交表单时从session里面取表单数据，而不是从页面提交过来。防止不法分子通过技术手段抓包改包上传(session是存在服务器端的)
		session.setAttribute("formData", pageData);
		
		return mav;
		
	}
	
	
	

	
	
	/* ===============================权限================================== */
	@SuppressWarnings("unchecked")
	public Map<String, String> getHC(){
		Subject currentUser = SecurityUtils.getSubject();  //shiro管理的session
		Session session = currentUser.getSession();
		return (Map<String, String>)session.getAttribute(Const.SESSION_QX);
	}
	/* ===============================权限================================== */
	
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
}
