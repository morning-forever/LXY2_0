<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!doctype html>
<html>
	<head>
		<meta charset="utf-8">
		<meta content="text/html">
		<base href="<%=basePath%>">
		<link rel="Shortcut Icon" href="favicon.ico"> 
		<link rel="stylesheet" type="text/css" href="static/tips/tip-darkgray/tip-darkgray.css"/>
		<link rel="stylesheet" href="static/app/pc/css/index.css">
		<link rel="stylesheet" href="static/app/pc/css/normalize.css">
	</head>
	<body>
		<!-- <a href="admin/login_toLogin">管理员登录</a>	
		<a href="appLogin/toLogin">高级用户登录</a> -->
		<div id="header">
			<div class="content">
				<div class="fl">
					<span class="logo"></span><span class="com-name">龙行云</span>
				</div>
				<div class="fr">
					<span class="cust-svs">客户服务</span>
					<span class="">app下载</span>
				</div>
			</div>
		</div>
		<div id="content">
			<div class="container">
				<div id="login_module">
					<div class="title cw"><img alt="" src="static/app/pc/image/lxy_font.png"></div>
					
					<input onclick="onClick();" id="username" type="text"  name="username" placeholder="用户名" class="cg tx"/>
					
					<input onclick="onClick();" id="password" type="password" placeholder="密码" class="cg tx"/>
					
					<div style="height:44px;">
						<input onclick="onClick();" id="authCode" type="text" name="authCode"  placeHolder="请输入验证码"/>
						<img  id="codeImg" alt="点击更换"
									title="点击更换" src="" onclick="changeCode()"/>
					</div>
					
					<span style="clear:both;display:block;"></span>
					
					<div class="help cw">
						<span class="rmb-pwd"><input id="rmbPwd" type="checkbox" name="rmbPwd"  class="vam" onclick="handleRmbOrNot()"/><span class="vam" >记住密码</span></span>
						<a href="javascript:void(0)" class="cw" id="fgt_pwd">忘记密码</a>
					</div>
					<div class="loginBtn cw" onclick="login()">
						<a href="javascript:void(0)"  style="color:#ffffff;">登录</a>
					</div>
					<div id="acnt_apl_div">
						<hr id="left_line">
						<a href="javascript:void(0)" class="cw" id="acnt_apl">账号申请</a>
						<hr id="right-line">
					</div>
				</div>
			</div>
		</div>
	</body>
	<script type="text/javascript" src="static/js/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" src="static/js/jquery-1.8.3.js"></script>
	<script type="text/javascript" src="static/js/jquery.ui.core.js"></script>
	<script type="text/javascript" src="static/js/jquery.ui.datepicker.js"></script>
	<script type="text/javascript" src="static/jbox/js/jquery.jBox.src.js"></script>
	<script type="text/javascript" src="static/js/jquery.cookie.js"></script>
	<script type="text/javascript" src="static/tips/jquery.poshytip.js"></script>
	<script type="text/javascript">
		document.onkeydown=keyDownSearch;  
	    
	    function keyDownSearch(e) {    
	        // 兼容FF和IE和Opera    
	        var theEvent = e || window.event;    
	        var code = theEvent.keyCode || theEvent.which || theEvent.charCode;    
	        if (code == 13) {    
	           login();
	            return false;    
	        }    
	        return true;    
	    }  	
	
		function onClick(){
			$( "#username" ).poshytip('destroy');
		}
		
		function login(){
			$( "#username" ).poshytip('destroy');
			
			var username = $("#username").val();
			var password = $("#password").val();
			var authCode = $("#authCode").val();
			var code = "qq313596790fh"+username+",fh,"+password+"QQ978336446fh"+",fh,"+authCode;
			
			$.post("appLogin/login", {KEYDATA:code,tm:new Date().getTime()},function(data){
				if("success" == data.result){
					window.location.href="/lxy/car/reservation/index.html";
					rmbPwd();//记住密码处理
				}else if("usererror" == data.result){
					
					$("#username").poshytip({
						content:"用户名或密码错误",
						className: 'tip-darkgray',
						showOn: 'none',
						alignTo: 'target',
						alignX: 'inner-left',
						offsetX: 0,
						offsetY: 5
					});
					$("#username").poshytip('show');
					/* var tip = $("<span>用户名或密码错误</span>")
					tip.insertBefore("#username");
					tip.css({"color":"red","position":"absolute","top":"108px","left":"72px"}); */
				}else if("codeerror" == data.result){
					$("#username").poshytip({
						content:"验证码有误",
						className: 'tip-darkgray',
						showOn: 'none',
						alignTo: 'target',
						alignX: 'inner-left',
						offsetX: 0,
						offsetY: 5
					});
					$("#username").poshytip('show');
				}else if("nullcode" == data.result){
					$("#username").poshytip({
						content:"验证码不能为空",
						className: 'tip-darkgray',
						showOn: 'none',
						alignTo: 'target',
						alignX: 'inner-left',
						offsetX: 0,
						offsetY: 5
					});
					$("#username").poshytip('show');
				}else{
					$("#username").poshytip({
						content:"验证码不能为空",
						className: 'tip-darkgray',
						showOn: 'none',
						alignTo: 'target',
						alignX: 'inner-left',
						offsetX: 0,
						offsetY: 5
					});
					$("#username").poshytip('show');
				}
			});
			
			
		}
		
		$(document).ready(function(){
			
			//设置背景图片填满剩余
			var headerHeight = $("#header").height();
			var windowHeight = $(window).height();
			var contentHeight = windowHeight - headerHeight;
			$("#content").css("background-size","100% "+contentHeight+"px");
			$("#content").height(contentHeight+"px");
			
			
			//把登录块放在页面正中间
			var cHeight = $("#content").height();
			var cWidth = $("#content").width();

			var lmHeight = $("#login_module").height();
			var lmWidth = $("#login_module").width();
			
			var left = cWidth/2.0-lmWidth/2.0;
			var top = cHeight/2.0-lmHeight/2.0;
			
			//$("#login_module").css("left",left).css("top",top);
			
			//初始化验证码
			changeCode();
			
			//获取cookie中的用户名密码
			var username = $.cookie('username');
			var password = $.cookie('password');
			if (typeof(username) != "undefined"
					&& typeof(password) != "undefined") {
				$("#username").val(username);
				$("#password").val(password);
				$("#rmbPwd").attr("checked", true);
				$("#code").focus();
			}
		});
		
		
		//生成当前时间的时间戳
		function genTimestamp() {
			var time = new Date();
			return time.getTime();
		}
		
		//点击图片更换验证码
		function changeCode() {
			$( "#username" ).poshytip('destroy');
			$("#codeImg").attr("src", "code.do?width=124&height=44&t=" + genTimestamp());
		}
		
		//通过浏览器的cookie记住 用户名/密码
		function rmbPwd() {
			if ($("#rmbPwd").is(":checked")) {
				$.cookie('username', $("#username").val(), {
					expires : 7
				});
				
				$.cookie('password', $("#password").val(), {
					expires : 7
				});
			}
		}
		
		//当记住密码的checkbox被点击时，处理"是否记住密码"
		function handleRmbOrNot() {
			if (!$("#rmbPwd").is(":checked")) {
				$.cookie('username', '', {
					expires : -1
				});
				
				$.cookie('password', '', {
					expires : -1
				});
			}
			
		}
	
	</script>
</html>
