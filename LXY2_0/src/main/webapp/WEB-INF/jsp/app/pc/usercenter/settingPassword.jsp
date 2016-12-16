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
<title>修改密码</title>
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
					<div class="pd-5 mt-20"><a href="app/pc/user/center.html">个人信息</a></div>
					<div class="pd-5 mt-20 current"><a href="app/pc/user/password/setting.html">修改密码</a></div>
					<div class="pd-5 mt-20">联系人</div>
				</div>
			</div>
			<div class="f-l ml-50" style="width:80%;">
				<div class="panel panel-default">
					<div class="panel-header">修改密码</div>
					<div style="padding:30px 50px; min-height:500px;">
						<div class="row cl mt-10">
							<label class="form-label col-xs-2">原密码：</label>
							<div class="formControls col-xs-5">
								<input id="oldPassword" type="password" class="input-text" autocomplete="off" placeholder="请输入原密码" name="password" id="password" datatype="*6-18" nullmsg="请输入密码！" >
							</div>
							<div class="col-xs-5"> </div>
						</div>
						<div class="row cl mt-40">
							<label class="form-label col-xs-2">新密码：</label>
							<div class="formControls col-xs-5">
								<input id="newPassword" type="password" class="input-text" autocomplete="off" placeholder="建议6-18位数字、字母、符号的组合密码" name="password" id="password" datatype="*6-18" nullmsg="请输入密码！" >
							</div>
							<div class="col-xs-5"> </div>
						</div>
						<div class="row cl mt-40">
							<label class="form-label col-xs-2">确认密码：</label>
							<div class="formControls col-xs-5">
								<input id="rnewPassword" type="password" class="input-text" autocomplete="off" placeholder="再次输入密码" name="password2" id="password2" recheck="password" datatype="*6-18" nullmsg="请再输入一次密码！" errormsg="您两次输入的密码不一致！" >
							</div>
							<div class="col-xs-5"> </div>
						</div>
						
						<div class="row cl mt-50">
							<div class="formControls col-xs-5 text-c">
								<input class="btn btn-primary size-L radius" type="button" onclick="ok();" value="确定">
							</div>
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
function ok(){
	var password = $("#oldPassword").val();
	var newPassword = $("#newPassword").val();
	var rnewPassword = $("#rnewPassword").val();
	
	if(!checkField(password)){
		modal_alert("请输入原密码", 2000);
		return ;
	}
	
	if(!checkField(newPassword, 6, 16)){
		modal_alert("请输入新密码", 2000);
		return ;
	}
	if(newPassword != rnewPassword){
		modal_alert("新密码和确认密码不一致", 2000);
		return ;
	}
	
	$.post('<%=basePath %>app/pc/user/changePass',{'password':password,'newPassword':newPassword,'rnewPassword':rnewPassword},function(res){
		if('success' == res.status){
			modal_alert("保存成功", 2000);
			window.location.href=window.location.href;
		}else if("re_pass_err" == res.status){
			modal_alert("新密码和确认密码不一致", 2000);
		}else if("login_user_pass_err" == res.status){
			modal_alert("原密码错误", 2000);
		}else if('param_err' == res.status){
			modal_alert("输入有误，请检查输入", 2000);
		}else{
			modal_alert("服务器忙，请稍后重试", 2000);
		}
	},"JSON");
}
</script>
</body>
</html>
