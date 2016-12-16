<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
	<head>
	<base href="<%=basePath%>">
	<!-- jsp文件头和头部 -->
	<%-- <%@ include file="../../system/admin/top.jsp"%> --%>
	
	<link rel="stylesheet" type="text/css" href="static/lxy/css/style.css"/>
	
	<link id="skin" rel="stylesheet" href="static/jbox/Pink/jbox.css" />
    <script type="text/javascript" src="static/jbox/js/jquery.jBox.src.js"></script>
	</head> 
<body>

<div class="container-fluid">
	<!-- page content -->
	<div class="refund_wrapper">
		<div class="whitebg pb20" style="box-shadow: 0 1px 2px #ddd;">
			<div class="title pd20">申请退款</div>
			<div class="refund-cont">
				<h4 class="orangeh4">退款信息</h4>
				<form id="form">
				<input type="hidden" name="formId" value="${orderId }">
				<div class="info pd20">
					<p class="mb20"><label><span class="red f12">* </span>真实姓名</label><input type="text" id="personName" name="personName" notNull="请输入真实姓名"/></p>
<!-- 						<p class="mb20"><label><span class="red f12">* </span>退款银行名称</label><input type="text" id="bankName" name="bankName" notNull="请输入退款银行名称"/></p>
 -->						<div class="fitemwrap">
							<label><span class="item-title"><span class="red f12">* </span>退款银行名称</span></label>
							<div class="form-item select-item mr10" style="width: 200px;margin-left: -86px;">
								<span class="select-text">中国建设银行</span>
								<i class="iicon i-select"></i>
								<select name="bankName" id="bankName">
									<option value="中国建设银行">中国建设银行</option>
									<option value="中国银行">中国银行</option>
									<option value="中国交通银行">中国交通银行</option>
									<option value="中国工商银行">中国工商银行</option>
									<option value="中国邮政储蓄银行">中国邮政储蓄银行</option>
									<option value="中国招商银行">中国招商银行</option>
									<option value="民生银行">民生银行</option>
									<option value="兴业银行">兴业银行</option>
									<option value="中国农业银行">中国农业银行</option>
									<option value="中信银行">中信银行</option>
									<option value="中国光大银行">中国光大银行</option>
								</select>
							</div>	
						</div>
					<p class="mb10"><label><span class="red f12">* </span>退款银行帐号</label><input type="text" id="bankNo" name="bankNo" notNull="请输入退款银行账号"/></p>
					<p class="red f12 mb10">注意：为避免影响您的退款，请务必保证以上信息正确。审核成功后退款将在7个工作日内退到您的银行卡账户</p>
				</div>
				<h4 class="orangeh4">退款原因</h4>
				<div class="pd20">
					<p class="mb10"><span class="iicon checkbox mr10 checked"></span><span class="f16 grey">不想去了</span>
					<input type="hidden" name="reason" value="不想去了">
					</p>
					<p class="mb10"><span class="iicon checkbox mr10"></span><span class="f16 grey">家中有事</span>
					<input type="hidden" value="家中有事">
					</p>
					<p class="other rel">
						<span class="iicon checkbox mr10" style="vertical-align:top;"></span><span class="f16 grey" style="vertical-align:top;">其他</span>
						<textarea maxlength="20"></textarea>
						<span class="limit abs">20字</span>
					</p>
				</div>
				</form>
				<div class="tc mt20">
					<button class="btn lorgbtn" onclick="save()">提交</button>
				</div>
			</div>
		</div>
	
	</div>
</div>
<script type="text/javascript" src="static/web/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="static/js/jquery.tips.js"></script>
<script type="text/javascript" src="static/web/js/base.js"></script>
<script type="text/javascript">
$(function(){
	selfDefineFormBtn();
	HorizontalList();
	
	//复选框单选事件
	$("div.pd20 .checkbox").click(function(){
		$("div.pd20 .checkbox").removeClass("checked");
		$("div.pd20 .checkbox").removeAttr("name");
		$(this).addClass("checked");
		$(this).attr("name","reason");
	});
	
	//银行卡键盘按下事件
	$('#bankNo').keyup(function(){  
        var value = $(this).val().replace(/\s/g,'').replace(/(\d{4})(?=\d)/g,"$1 ");
        value=value.replace(/\D/g,'');
        $(this).val(value);  
    });  
	
	$("#bankName").change();
});

//保存
function save(){
	var flag = true;
	//验证不为空
	$("#form [notNull]").each(function(){
		if(!checkField(this.value)){
			valTips(this.id, $(this).attr("notNull"));
			flag = false;
		}
	});
	//验证银行卡号格式
	var bankNo = $("#bankNo").val().replace(/\s+/g,"");
	if(!checkBankNo($("#bankName").val(), bankNo)){
		valTips('bankNo', '请填写正确的银行卡号.');
		flag = false;
	}
	/* if(!checkField(bankNo, new RegExp('^(\\d{16}|\\d{19})$'))){
		valTips('bankNo', '请填写正确的银行卡号.');
		flag = false;
	} */
	//提交订单
	if(flag){
		$.post('<%=basePath %>pc/user/order/saveRefund',$("#form").serialize(),function(res){
			if(res.status == 'success'){
				popMesTip("申请退款成功",function(){
					location.href = "pc/user/order/depthList";
				});
			}else if(res.status == 'error'){
				popMesTip("申请退款失败");
			}else{
				popMesTip("系统忙，请稍后重试");
			}
		});
	}
}
</script>
</body>
</html>
