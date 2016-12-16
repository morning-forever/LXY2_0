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
	<link rel="stylesheet" href="static/css/chosen.css" />
	<link href="static/css/bootstrap.min.css" rel="stylesheet" />
	<link href="static/css/bootstrap-responsive.min.css" rel="stylesheet" />
	<link rel="stylesheet" href="static/css/font-awesome.min.css" />
	<link rel="stylesheet" href="static/css/ace.min.css" />
	<link rel="stylesheet" href="static/css/ace-responsive.min.css" />
	<link rel="stylesheet" href="static/css/ace-skins.min.css" />
	
	<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
	
	<script type="text/javascript" src="static/app/pc/js/base.js"></script>
</head>
<body>
<div class="container-fluid" id="main-container">
	
	<div class="row-fluid">
		<div class="table-header">分配司机</div>
		<div id="div_content" class="row-fluid" style="padding-top: 10px;">
			<form id="myForm" class="form-horizontal" method="post" >
				<input type="hidden" id="carStaId" name="carStaId" value="${param.carStaId}">
				<input type="hidden" id="startTime" name="startTime" value="${param.startTime}">
				<input type="hidden" id="endTime" name="endTime" value="${param.endTime}">
				<select  id="driverId" data-placeholder="选择司机" name="driverId">
					 <option value="-1"></option>
					<c:forEach items="${driNamsAndIdsLis}" var="driver">
						<option value="${driver.id}">${driver.name}</option>
					</c:forEach>
				</select>
				
				<div class="hr hr-dotted"></div>
		  	</form>
		</div>
		
		
		<div style="text-align: center;">
			<a title="确定" href="javascript:;" class="btn btn-info" id="back-btn" onclick="save()"><i class="icon-save"></i> 确定</a>
			<a title="返回" href="javascript:;" class="btn btn-grey" id="back-btn" onclick="back()"><i class="icon-reply"></i> 返回</a>
		</div>
	</div>
</div>
<!-- #main-content -->
</body>
<%@ include file="../../admin/foot.jsp"%>
<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script>
<script type="text/javascript">

$(document).ready(function(){
	//下拉框
	$("#driverId").chosen(); 
	
});
//保存
function save(){
	var formObj = serializeObject($("#myForm"));
	$.post('admin/lxy/dri_car_sta_int_ass/carStaAssDriAdd', formObj , function(res) {
		if (res.status == 'success') {
			bootbox.alert("分配成功",function(){
				back();
			});
		} else if(res.status == 'BUSY') {
			bootbox.alert("该司机已分配给其他此段时间内有出行的车辆,请重新选择司机");
		} else if(res.status == 'exception'){
			bootbox.alert("系统异常");
		}
	}, "JSON");
}



//返回
function back(){
	location.href = document.referrer;
}

function scroll(id){
	$("html,body").animate({scrollTop:$("#"+id).offset().top},200)
}
	
</script>
</html>
