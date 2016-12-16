<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html >
<html lang="en">
	<head>
	<meta name="viewport" content="width=device-width, initial-scale=1"/>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="keywords" content="" />
	<base href="<%=basePath%>">
	<title>消息中心</title>
	
	<link rel="stylesheet" type="text/css" href="static/css/bootstrap.min.css"/>
	<link rel="stylesheet" type="text/css" href="static/css/jquery.ui.datepicker.css"/>
    <link id="skin" rel="stylesheet" href="static/jbox/Pink/jbox.css" />
    <link rel="stylesheet" type="text/css" href="static/tips/tip-darkgray/tip-darkgray.css"/>
	
	<link href="static/app/pc/css/select2.css" rel="stylesheet"/>
	<link rel="stylesheet" type="text/css" href="static/app/pc/css/common.css"/>
	<link rel="stylesheet" type="text/css" href="static/app/pc/css/stylenew.css"/>
	</head>
<body style="background:#e9f5f4;"> 
<!-- <div class="container-fluid" id="main-container"> -->
<div class="main-container"> 
	<div class="header">
		<jsp:include page="../../common/header.jsp"></jsp:include>
		<div class="header_nav" id="home">
			<div class="container">
				<nav class="navbar navbar-container">
					<div class="navbar-header">
						<a class="navbar-brand logo-st" href="lxy/car/reservation/index.html">龙行云</a>
					</div>
					<div class="navbar-right">
						<ul class="nav">
							<li>
								<a href="lxy/car/reservation/index.html">
								<span class=""></span>
								订车中心
								</a>
							</li>
							
							<li>
								<a href="lxy/pc/user/order/list.html">
								<span class=""></span>
								我的订单
								</a>
							</li>
							
							<li>
								<a href="lxy/app/pc/customerService/0001.html">
								<span class=""></span>
								客户服务
								</a>
							</li>
						</ul>
					</div>
					<div class="clearfix"></div>
				</nav>
			</div>
		</div>
	</div>
				          	
	<div class="row-fluid main-wrap">
		<div class="container">
			<div class="user-center"> 
				<div id="leftMenu">
					<ul>
						<li><a href="app/pc/user/center">账户中心</a></li>
						<li id="menu_active"><a href="app/pc/user/message"> 我的消息</a></li>
					</ul>
				</div>
				<div id="tab-content">
					<div id="c0" class="tab-content">
						功能待开发
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<jsp:include page="../../common/footer.jsp"></jsp:include>
</div>




<script type="text/javascript" src="static/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="static/js/jquery-1.8.3.js"></script>
<script type="text/javascript" src="static/js/jquery.ui.core.js"></script>
<script type="text/javascript" src="static/js/jquery.ui.datepicker.js"></script>
<script type="text/javascript" src="static/jbox/js/jquery.jBox.src.js"></script>

<script type="text/javascript" src="static/app/pc/js/base.js"></script>

<script type="text/javascript" src="static/app/pc/js/area.js"></script>
<script type="text/javascript" src="static/app/pc/js/location.js"></script>
<script type="text/javascript" src="static/app/pc/js/select2.js"></script>
<script type="text/javascript" src="static/app/pc/js/select2_locale_zh-CN.js"></script>

<script type="text/javascript" src="static/tips/jquery.poshytip.js"></script>


<script>
</script>
</body>
</html>

