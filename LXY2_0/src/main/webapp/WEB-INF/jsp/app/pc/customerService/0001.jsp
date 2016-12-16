<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
	<meta name="viewport" content="width=device-width, initial-scale=1"/>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="keywords" content="" />
	<head>
	<base href="<%=basePath%>">
	</head>
	
	<link rel="stylesheet" type="text/css" href="static/css/bootstrap.min.css"/>
    <link id="skin" rel="stylesheet" href="static/jbox/Pink/jbox.css" />
    <link rel="stylesheet" type="text/css" href="static/tips/tip-darkgray/tip-darkgray.css"/>
	
	<link rel="stylesheet" type="text/css" href="static/app/pc/css/common.css"/>
	<link rel="stylesheet" type="text/css" href="static/app/pc/css/stylenew.css"/>
	
<body style="background:#e9f5f4;">
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
								
								<li class="navbar-active">
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
		
		<div class="row-fluid select">
			<section>
				<div class="title"><span>客户服务&nbsp;&nbsp;>&nbsp;&nbsp;反馈建议</span></div>
				<div class="fb-content">
					<div class="fb-content-title">
						<h1>您提交的问题我们将在<span style="color:#0acfda;">24</span>小时内处理</h1>
					</div>
					<div class="submit-content">
						<div class="item">
							<span class="text">您反馈的类型:</span>
							<div class="type-select">
								<input checked="checked" class="check" onClick="chooseOne(this);" type="checkbox" name="type1" value="1">车辆问题
								<input class="check" onClick="chooseOne(this);" type="checkbox" name="type2" value="2">路线问题
								<input class="check" onClick="chooseOne(this);" type="checkbox" name="type3" value="3">支付/账户
								<input class="check" onClick="chooseOne(this);" type="checkbox" name="type4" value="4">其他
							</div>
						</div>
						<!-- <div class="item item1">
							<span class="text">标题:</span>
							<input class="" id="title" value="" type="text">
						</div> -->
						<div class="item item2">
							<span class="text">内容:</span>
							<textarea name="message" id="message" class="" rows="10" placeholder="输入内容不能超过200字"></textarea>
						</div>
						<div class="item item1">
							<span class="text">输入电话:</span>
							<input class="" id="phone" value="" type="text" placeholder="请输入联系方式">
						</div>
						
						<div class="item item1">
							<span class="text">输入邮箱:</span>
							<input class="" id="email" value="" type="text" placeholder="请输入邮箱">
						</div>
						
						<div class="item item1">
							<span class="text">输入姓名:</span>
							<input class="" id="name" value="" type="text" placeholder="请输入姓名">
						</div>
					</div>
					
					<input value="提交" type="button" onclick="saveFeedBack();">
				</div>
			</section>
		</div>
	
	<jsp:include page="../../common/footer.jsp"></jsp:include>
	</div>
</body>

<script type="text/javascript" src="static/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="static/js/jquery-1.8.3.js"></script>
<script type="text/javascript" src="static/js/jquery.ui.core.js"></script>
<script type="text/javascript" src="static/js/jquery.ui.datepicker.js"></script>
<script type="text/javascript" src="static/jbox/js/jquery.jBox.src.js"></script>

<script type="text/javascript" src="static/app/pc/js/base.js"></script>
<script type="text/javascript" src="static/tips/jquery.poshytip.js"></script>

<script type="text/javascript">

//保存反馈意见
function saveFeedBack(){
	var type = $("input[class='check']:checked").val();
	if(type == null || type == ""){
		alert("请选择类型")
		return;
	}
	
	var message=$("#message").val();
	if(message == null || message == ""){
		alert("请填写反馈内容");
		return;
	}
	
	if(!checkField($("#email").val(), new RegExp('^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$'))){
		alert("您输入的邮箱有误，请重新输入。");
		return;
	}
	if(!checkField($("#phone").val(),/^[1][34578][0-9]{9}$/)){
		alert("请输入正确的手机号码");
		return;
	}
	
	var name = $("#name").val();
	if(name == null || name == ""){
		alert("请填写联系人姓名");
		return;
	}
	
	var param = {
 			"type" : type,
 			"message":message,
 			"email":$("#email").val(),
 			"phone":$("#phone").val(),
 			"username":name
 		};
	
	 $.post('<%=basePath %>lxy/app/pc/addFeedBack',param,function(res){
		if(res.status == 'success'){
			alert("提交成功");
			window.location.href = window.location.href;
		}else{
			alert("系统忙，请稍后重试");
		}
	});
}

function chooseOne(cb) {   
	$(":checkbox[class=check]").each(function(index, target){
		 if (target!=cb){
			 target.checked = false;
		 }else{
			 //若是 但原先未被勾選 則變成勾選；反之 則變為未勾選
			 target.checked = cb.checked;
		 } 
	});
} 

</script>

</html>