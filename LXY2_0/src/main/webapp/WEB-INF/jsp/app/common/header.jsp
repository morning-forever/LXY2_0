<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String basePath1 = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ request.getContextPath()+"/";
%>

<div class="navbar navbar-black">
	<div class="container cl">
		<a class="logo f-l f-26" href="lxy/car/reservation/index.html">龙行云</a>
		<nav class="nav navbar-nav nav-collapse f-l lxy-nav" role="navigation" id="Hui-navbar">
			<ul class="cl">
				<li id="orderCar" style="margin-left:200px;"><a href="lxy/car/reservation/index.html"><span class="f-20">我要订车</span></a></li>
				<li id="myOrder"><a href="lxy/order/list.html"><span class="f-20">我的订单</span></a></li>
			</ul>
		</nav>
		<span class="f-r"><a class="logo f-20" href="javascript:void(0);"><i class="Hui-iconfont">&#xe6c7;</i>4007 970 766</a></span>
		<span class="f-r mr-20"><a class="logo  f-14" href="javascript:message();">消息</a></span>
		<div class="f-r mr-20">
			<div class="logo dropDown dropDown_hover">
				<a href="app/pc/user/center.html" class="dropDown_A" style="color:#fff;">${appUser.NAME}<i class="Hui-iconfont">&#xe6d5;</i></a>
				<ul class="dropDown-menu menu radius box-shadow">
					<li><a href="app/pc/user/center">我的账户</a></li>
					<li><a href="javascript:void(0);">我的资产</a></li>
					<li><a href="javascript:void(0);">会员制度</a></li>
					<li><a href="appLogin/logout">退出</a></li>
				</ul>
			</div>
		</div>
	</div>
</div>

<!--引入属于此页面的js -->
<script type="text/javascript" src="static/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="static/app/pc/js/head.js"></script>