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
	<meta charset="utf-8" />
	<title></title>
	<meta name="description" content="overview & stats" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<link href="static/css/bootstrap.min.css" rel="stylesheet" />
	<link href="static/css/bootstrap-responsive.min.css" rel="stylesheet" />
	<link rel="stylesheet" href="static/css/font-awesome.min.css" />
	<link rel="stylesheet" href="static/css/ace.min.css" />
	<link rel="stylesheet" href="static/css/ace-responsive.min.css" />
	<link rel="stylesheet" href="static/css/ace-skins.min.css" />
	<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
</head>
<body>
<div class="container-fluid" id="main-container">
	
	<div class="row-fluid">
		<div class="table-header">审核订单</div>
		<div id="div_content" class="row-fluid" style="padding-top: 10px;">
			<form id="myForm" class="form-horizontal" method="post" >
				<input  type="hidden" name="orderId" value="${orderForm.id}">
				<div class="control-group">
					<label class="control-label" for="name"><span class="red f12">* </span>接团地点:</label>
					<div class="controls">
						<div class="span12">
							<c:if test="${orderForm.jtSite!=null && orderForm.jtSite!=''}">
								${orderForm.jtSite}
								<c:choose>
									<c:when test="${orderForm.jtSiteKm == null && orderForm.stSite eq orderForm.jtSite}">
										<input type="text" placeholder="请填写接团地点和送团地点公里数" id="jstSiteKm" name="jstSiteKm"  style="width: 300px;" onblur="checkNumAndCalKm(this)" value=""/>
									</c:when>
									<c:when test="${orderForm.jtSiteKm == null && !(orderForm.stSite eq orderForm.jtSite)}">
										<input type="text" placeholder="请填写接团地点公里数" id="jtSiteKm" name="jtSiteKm"  onblur="checkNumAndCalKm(this)" style="width: 300px;" value=""/>
									</c:when>
									<c:when test="${orderForm.jtSiteKm != null }">
										${orderForm.jtSiteKm }
									</c:when>
								</c:choose>
							</c:if>
							<c:if test="${orderForm.jtSite==null || orderForm.jtSite==''}">
								无
							</c:if>
						</div>
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label" for="name"><span class="red f12">* </span>送团地点:</label>
					<div class="controls">
						<div class="span12">
							
							<c:if test="${orderForm.stSite != null && orderForm.stSite != ''}">
								${orderForm.stSite}
								<c:choose>
									<c:when test="${orderForm.stSiteKm == null && !(orderForm.stSite eq orderForm.jtSite)}">
										<input type="text"  placeholder="请填写送团地点公里数" id="stSiteKm" name="stSiteKm"  onblur="checkNumAndCalKm(this)" style="width: 300px;" value=""/>
									</c:when>
									<c:when test="${orderForm.stSiteKm == null && orderForm.stSite eq orderForm.jtSite}">
									</c:when>
									<c:when test="${orderForm.stSiteKm != null }">
										${orderForm.stSiteKm }
									</c:when>
								</c:choose>
							</c:if>
							<c:if test="${orderForm.stSite == null || orderForm.stSite == '' }">
								无
							</c:if>
						</div>
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label" for="name"><span class="red f12">* </span>行程路线:</label>
					<div class="controls">
						<div class="span12">
							<textarea id="form-field-11" readonly="readonly" name="content" class="autosize-transition span12" style="overflow: hidden; word-wrap: break-word; resize: horizontal; height: 98px; margin-left: 0px; margin-right: 0px; width: 503px;">${orderForm.route }</textarea>
							<c:choose>
								<c:when test="${orderForm.routeKm == null }">
									<input type="text" id="dayNum"  readonly="readonly" placeholder="请填写路线公里数" name="dayNum"  style="width: 100px;" value="${orderForm.dayNum }"/>天
									<input type="text" id="routeKm" placeholder="请填写路线公里数" name="routeKm" onblur="checkNumAndCalKm(this)" style="width: 300px;" value=""/>
								</c:when>
								<c:when test="${orderForm.routeKm != null }">
									${orderForm.routeKm }
								</c:when>
							</c:choose>
						</div>
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label" for="name"><span class="red f12">* </span>备注:</label>
					<div class="controls">
						<div class="span12">
							${orderForm.remark}
						</div>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="name"><span class="red f12">* </span>订单总公里数:</label>
					<div class="controls">
						<div class="span12">
							<input type="text" id="km" placeholder="请参考以上数据填写订单总公里数" name="km" readonly="readonly" style="width: 300px;border:0;" value=""/>
						</div>
					</div>
				</div>
				
				
				<div class="hr hr-dotted"></div>
		  	</form>
		</div>
		
		
		<div style="text-align: center;">
			<a title="保存" href="javascript:;" class="btn btn-info" id="back-btn" onclick="checkSuccess()"><i class="icon-save"></i>通过</a>
			<a title="返回" href="javascript:;" class="btn btn-grey" id="back-btn" onclick="checkFail()"><i class="icon-reply"></i>不通过</a>
		</div>
	</div>
</div>
<!-- #main-content -->
</body>
<%@ include file="../../admin/foot.jsp"%>
<script type="text/javascript" src="static/js/jquery.tips.js"></script>
<script type="text/javascript" src="static/app/pc/js/base.js"></script>

<script type="text/javascript">
$(document).ready(function(){	
	var km=0;
	if("${orderForm.jtSiteKm != null && orderForm.jtSiteKm != ''}"== 'true'){
		km+=parseInt("${orderForm.jtSiteKm}");
	}
	if("${orderForm.stSiteKm != null && orderForm.stSiteKm != ''}" == 'true'){
		km+=parseInt("${orderForm.stSiteKm}");
	}
	if("${orderForm.routeKm != null && orderForm.routeKm != ''}" == 'true'){
		km+=parseInt("${orderForm.routeKm}");
	}
	if(km != 0){
		$("#km").val(km);
	}
});

function checkNumAndCalKm(obj){
	var value = $.trim($(obj).val());
	var regExp = new RegExp("^[0-9]+$");
	if(value != ""){
		if(!regExp.test(value)){
			valTips(obj.id,"请检查格式，只能输入数字")
		}else{
			calKm();
		}
	}
	
}
function calKm(){
	var jstKm = $.trim($("#jstSiteKm").val());
	var jtKm = $.trim($("#jtSiteKm").val());
	var stKm = $.trim($("#stSiteKm").val());
	var routeKm = $.trim($("#routeKm").val());;
	
	var km =0;
	
	var regExp = new RegExp("^[0-9]+$");
	if(jstKm != ""){
		if(!regExp.test(jstKm)){
			valTips('jstSiteKm',"只能输入数字");
			return false;
		}else{
			km+=2*parseInt(jstKm);
		}
		
	}
	if(jtKm !=""){//说明接团地点不是系统默认的，且已填入了数据（以下送团地点和路线同理，就不一一写注释了）
		if(!regExp.test(jtKm)){
			valTips('jtSiteKm',"只能输入数字");
			return false;
		}else{
			km+=parseInt(jtKm);
		}
	}else if("${orderForm.jtSiteKm != '' && orderForm.jtSiteKm != null}" == 'true'){//如果是系统默认默认的
		km+=parseInt("${orderForm.jtSiteKm}");
	}
	if(stKm !=""){
		if(!regExp.test(stKm)){
			valTips('stSiteKm',"只能输入数字");
			return false;
		}else{
			km+=parseInt(stKm);
		}
	}else if("${orderForm.stSiteKm != '' && orderForm.stSiteKm != null}" == 'true'){
		km+=parseInt("${orderForm.stSiteKm}");
	}
	if(routeKm != ""){
		
		if(!regExp.test(routeKm)){
			valTips('routeKm',"只能输入数字");
			return false;
		}else{
			km+=parseInt(routeKm);
		}
		
	}else if("${orderForm.routeKm != '' && orderForm.routeKm != null}" == 'true'){
		km+=parseInt("${orderForm.routeKm}");
	}
	
	if(km != 0){
		$("#km").val(km);	
	}
}
//审核通过前校验数据的填写
function beforeCheckSuccess(){
	
	var regExp = new RegExp("^[0-9]+$")
	
	if($("#jstSiteKm").get(0) != undefined){//说明这个输入框存在，且接送团地点一样，且接送团地点不是系统默认的（以下下接送团地点和路线同理，就不一一注释了）
		
		var jstKm = $.trim($("#jstSiteKm").val());
		
		if(jstKm == ""){
			valTips("jstSiteKm","请输入接团和送团地点公里数");
			return false;
		}else if(!regExp.test(jstKm)){
			valTips("jstSiteKm","请检查格式，只能输入数字")
			return false;
		}
	}
	
	if($("#jtSiteKm").get(0) != undefined){
		var jtKm = $.trim($("#jtSiteKm").val());
		
		if(jtKm == ""){
			valTips("jtSiteKm","请输入接团地点公里数");
			return false;
		}else if(!regExp.test(jtKm)){
			valTips("jtSiteKm","请检查格式，只能输入数字")
			return false;
		}
	}
	
	if($("#stSiteKm").get(0) != undefined){
		var stKm = $.trim($("#stSiteKm").val());
		if(stKm == ""){
			valTips("stSiteKm","请输入送团地点公里数");
			return false;
		}else if(!regExp.test(stKm)){
			valTips("stSiteKm","请检查格式，只能输入数字")
			return false;
		}
	}
	
	if($("#routeKm").get(0) != undefined){
		var routeKm = $.trim($("#routeKm").val());
		if(routeKm == ""){
			valTips("routeKm","请输入路线公里数");
			return false;
		}else if(!regExp.test(routeKm)){
			valTips("routeKm","请检查格式，只能输入数字")
			return false;
		}
	}

	return true;
}
//保存
function checkSuccess(){
	
	if(beforeCheckSuccess()){
		var formObj = serializeObject($("#myForm"));
		var dialog = bootbox.dialog({
			    message: '<p class="text-center">正在处理,请稍后...</p>',
			    closeButton: false
			});
		 $.post('admin/order/checkSuccess', formObj , function(res) {
			if (res.status == 'success') {
				dialog.find('.bootbox-body').html('审核已通过！');
				
				
			} else {
				dialog.find('.bootbox-body').html('服务器内部异常！请稍后重试！');
			}
			setTimeout(function(){
				dialog.modal('hide');
				back();
		    }, 1500);
		}, "JSON");
	}
	
	
}


function checkFail(){
	
	bootbox.prompt({
	    title: "请填写不通过的原因",
	    inputType: 'textarea',
	    callback: function (result) {
	        if(result){
		        	var formObj = serializeObject($("#myForm"));
		        	formObj.failReason = result;
		        	 var dialog = bootbox.dialog({
		 			    message: '<p class="text-center">正在处理,请稍后...</p>',
		 			    closeButton: false
		 				});
		    	   $.post('admin/order/checkFail', formObj , function(res) {
			    		if (res.status == 'success') {
			    			dialog.find('.bootbox-body').html('处理完成！');
		    				
			    		} else {
			    			dialog.find('.bootbox-body').html('系统异常，请联系维护人员');
			    		}
			    	}, "JSON");
		    	   setTimeout(function(){
						dialog.modal('hide');
						back();
				    }, 1500);
	        }else if(result != null){
	        	bootbox.alert("请务必填写不通过的原因");
	        }
	        
	    }
	});
	
	
	
	
}


//返回
function back(){
	location.href = location.href = document.referrer;
}

function scroll(id){
	$("html,body").animate({scrollTop:$("#"+id).offset().top},200)
}
	
</script>
</html>
