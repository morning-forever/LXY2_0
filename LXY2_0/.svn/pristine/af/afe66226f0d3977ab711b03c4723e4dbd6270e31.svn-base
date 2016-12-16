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
<link rel="stylesheet" type="text/css" href="static/css/jquery.datetimepicker.css"/>
<link rel="stylesheet" type="text/css" href="static/app/pc/css/style2.0.css"/>

<!--[if lt IE 9]>
<link href="static/h-ui/css/H-ui.ie.css" rel="stylesheet" type="text/css" />
<![endif]-->
<!--[if IE 6]>
<script type="text/javascript" src="static/h-ui-lib/DD_belatedPNG_0.0.8a-min.js" ></script>
<script>DD_belatedPNG.fix('*');</script>
<![endif]-->
<title>提交审核</title>
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
					<div class="verify-arrow"></div>
				</div>
				<div class="f-l ml-40">
					<span class="f-24"><strong>订单提交成功，工作人员将在24小时内完成审核</strong></span>
					<p class="f-18 mt-10">订单编号：${orderForm.orderCode }</p>
					<p class="f-18">提交审核通过后才能明确支付额度！</p>
				</div>
			</div>
			
			<div class="mt-50" style="border-bottom: 1px dashed #b3ebf0;"></div>
			
			<div class="cl" style="padding:50px 50px;">
				<p>友情提示：</p>
				<p>a)：工作人员上班时间：早上（09:00——12:00）下午（14:00——18:00）</p>
				<p>b)：如果订单很急，可拨打客服热线我们将为您尽快审核</p>
				<p>c)：如果订单审核未通过时，工作人员会把问题反馈到您，按照要求修改重新提交审核</p>
				
				<p class="mt-20">订单修改或取消：</p>
				<p>上团时间距当前时间>=4个工作小时，可自行修改订单或致电客服热线；上团时间距当前时间<=4个工作小时，不能修改</p>
			</div>
			
			<div class="cl mt-20 mb-20">
				<span class="f-r" style="margin-right:10%;"><a href="lxy/car/reservation/index.html">回到主页</a></span>
				<span class="f-r mr-50"><a href="lxy/order/${appUser.USERNAME}/detail/${orderForm.id }">查看订单</a></span>
			</div>
		</div>
	</div>
</section>

<jsp:include page="../../common/footer.jsp"></jsp:include>

<script type="text/javascript" src="static/h-ui-lib/jquery/1.9.1/jquery.min.js"></script> 
<script type="text/javascript" src="static/h-ui-lib/layer/2.1/layer.js"></script> 
<script type="text/javascript" src="static/h-ui-lib/laypage/1.2/laypage.js"></script> 
<script type="text/javascript" src="static/h-ui-lib/My97DatePicker/WdatePicker.js"></script> 
<script type="text/javascript" src="static/h-ui-lib/icheck/jquery.icheck.min.js"></script> 
<script type="text/javascript" src="static/h-ui-lib/bootstrap-Switch/bootstrapSwitch.js"></script> 
<script type="text/javascript" src="static/h-ui-lib/Validform/5.3.2/Validform.min.js"></script> 
<script type="text/javascript" src="static/js/jquery.datetimepicker.js"></script>
<script type="text/javascript" src="static/h-ui/js/H-ui.js"></script>
<script type="text/javascript" src="static/app/pc/js/base.js"></script>

<script>
$(function(){

});
</script>
</body>
</html>
