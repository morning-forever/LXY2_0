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
		<div class="table-header">关联司机</div>
		<div id="div_content" class="row-fluid" style="padding-top: 10px;">
			<form id="myForm" class="form-horizontal" method="post" >
				<input type="hidden" id="carId" name="carId" value="${carId}">
				
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
	$.post('admin/lxy/dri_car_int_ass/carAssDriAdd', formObj , function(res) {
		if (res.status == 'success') {
			bootbox.alert("关联成功",function(){
				back();
			});
			
		} else {
			bootbox.alert("提交失败！");
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
