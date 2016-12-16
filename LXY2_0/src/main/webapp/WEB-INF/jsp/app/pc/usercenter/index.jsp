<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
<title>个人信息</title>
<meta name="keywords" content="">
<meta name="description" content="">
</head>
<body>
<header class="navbar-wrapper">
	<jsp:include page="../../common/header.jsp"></jsp:include>
</header>

<section class="container">
	<div class="mt-40">
		<div class="cl">
			<div class="f-l person-center" style="width:15%;">
				<div class="panel panel-default" style="min-height:500px;">
					<div class="panel-header">我的账户</div>
					<div class="pd-5 mt-20 current"><a href="app/pc/user/center.html">个人信息</a></div>
					<div class="pd-5 mt-20"><a href="app/pc/user/password/setting.html">修改密码</a></div>
					<div class="pd-5 mt-20">联系人</div>
				</div>
			</div>
			<div class="f-l ml-50" style="width:80%;">
				<div class="panel panel-default">
					<div class="panel-header">个人信息</div>
					<div style="padding:30px 50px; min-height:500px;">
						<div class="row cl mt-10">
							<label class="form-label col-xs-2">公司名称：</label>
							<div class="formControls col-xs-5">
								<input type="text" class="input-text" placeholder="" name="username" id="username" value="${appUser.NAME}">
							</div>
							<div class="col-xs-5"> </div>
						</div>
						<div class="row cl mt-40">
							<label class="form-label col-xs-2">邮箱地址：</label>
							<div class="formControls col-xs-5">
								<input type="text" class="input-text" placeholder="" name="username" id="username" value="${userInfo.EMAIL }">
							</div>
							<div class="col-xs-5"> </div>
						</div>
						<div class="row cl mt-40">
							<label class="form-label col-xs-2">联系方式：</label>
							<div class="formControls col-xs-5">
								<input type="text" class="input-text" placeholder="" name="username" id="username" value="${userInfo.PHONE }">
							</div>
							<div class="col-xs-5"> </div>
						</div>
						<div class="row cl mt-40">
							<label class="form-label col-xs-2">公司地址：</label>
							<div class="formControls col-xs-5">
								<input type="text" class="input-text" placeholder="" name="username" id="username" value="xxxxx">
							</div>
							<div class="col-xs-5"> </div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="../../common/footer.jsp"></jsp:include>
</section>
	
	
<script type="text/javascript" src="static/h-ui-lib/jquery/1.9.1/jquery.min.js"></script> 
<script type="text/javascript" src="static/h-ui-lib/layer/2.1/layer.js"></script> 
<script type="text/javascript" src="static/h-ui-lib/laypage/1.2/laypage.js"></script> 
<script type="text/javascript" src="static/h-ui-lib/My97DatePicker/WdatePicker.js"></script> 
<script type="text/javascript" src="static/h-ui-lib/icheck/jquery.icheck.min.js"></script> 
<script type="text/javascript" src="static/h-ui-lib/bootstrap-Switch/bootstrapSwitch.js"></script> 
<script type="text/javascript" src="static/h-ui-lib/Validform/5.3.2/Validform.min.js"></script> 
<script type="text/javascript" src="static/h-ui-lib/Validform/5.3.2/passwordStrength-min.js"></script>
<script type="text/javascript" src="static/js/jquery.datetimepicker.js"></script>
<!-- 收索 -->
<script language="javascript" type="text/javascript" src="static/h-ui-lib/jQuery.autocomplete/1.1/jquery.autocomplete.js"></script>
<script type="text/javascript" src="static/h-ui/js/H-ui.js"></script>
<script type="text/javascript" src="static/app/pc/js/base.js"></script>

<script>
</script>

</body>
</html>
