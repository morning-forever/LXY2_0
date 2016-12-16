<%@ page language="java" contentType="text/html; charset=UTF-8" import="com.lx.util.XConst" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<meta content="text/html">
<base href="<%=basePath%>">
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
<!--[if lt IE 9]>
<script type="text/javascript" src="static/h-ui-lib/html5.js"></script>
<script type="text/javascript" src="static/h-ui-lib/respond.min.js"></script>
<script type="text/javascript" src="static/h-ui-lib/PIE_IE678.js"></script>
<![endif]-->
<link rel="stylesheet" type="text/css" href="static/h-ui/css/H-ui.css" />
<link rel="stylesheet" type="text/css" href="static/h-ui-lib/Hui-iconfont/1.0.7/iconfont.css" />
<link rel="stylesheet" type="text/css" href="static/h-ui-lib/icheck/icheck.css" />
<link rel="stylesheet" type="text/css" href="static/app/pc/css/style2.0.css"/>

<!--[if lt IE 9]>
<link href="static/h-ui/css/H-ui.ie.css" rel="stylesheet" type="text/css" />
<![endif]-->
<!--[if IE 6]>
<script type="text/javascript" src="static/h-ui-lib/DD_belatedPNG_0.0.8a-min.js" ></script>
<script>DD_belatedPNG.fix('*');</script>
<![endif]-->
<title>支付成功</title>
<meta name="keywords" content="">
<meta name="description" content="">
</head>
<body>
<header class="navbar-wrapper">
	<jsp:include page="../../common/header.jsp"></jsp:include>
</header>

<section class="container">
	<div class="panel panel-default mt-50">
		<div class="panel-body">
			<div class="cl pd-40">
				<div class="f-l mt-5">
					<img src="static/app/pc/image/s_face.png"/>
				</div>
				<div class="f-l ml-40 mt-20">
					<h1><strong>恭喜您!支付成功</strong></h1>
				</div>
			</div>
			<div class="mt-50" style="border-bottom: 1px dashed #b3ebf0;"></div>
			<div class="cl" id="pay_select" style="padding:180px 200px;">
				<div class="f-l">
					<input id="showOrder" class="btn btn-lxy-solid size-XL radius" type="button" value="查看订单"/>
				</div>
				<div class="f-r">
					<input id="backHome" class="btn btn-lxy-solid size-XL radius" type="button" value="回到首页"/>
				</div>
			</div>
		</div>
	</div>
</section>

<jsp:include page="../../common/footer.jsp"></jsp:include>

<script type="text/javascript" src="static/h-ui-lib/jquery/1.9.1/jquery.min.js"></script> 
<script type="text/javascript" src="static/h-ui-lib/layer/2.1/layer.js"></script> 
<script type="text/javascript" src="static/h-ui-lib/laypage/1.2/laypage.js"></script> 
<script type="text/javascript" src="static/h-ui-lib/icheck/jquery.icheck.min.js"></script> 
<script type="text/javascript" src="static/h-ui-lib/bootstrap-Switch/bootstrapSwitch.js"></script> 
<script type="text/javascript" src="static/h-ui/js/H-ui.js"></script>

<script>
$(function(){
	//选择支付宝
	$("#showOrder").click(function(){
		location.href = "lxy/order/list.html"
	});
	
	//选择微信
	$("#backHome").click(function(){
		location.href = "lxy/car/reservation/index.html"
		return;
	});

});
</script>
</body>
</html>