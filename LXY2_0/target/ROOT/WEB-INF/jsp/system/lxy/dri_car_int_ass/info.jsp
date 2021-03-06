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
	<script type="text/javascript" src="static/js/jquery-1.11.1.min.js"></script>
</head>
<body>
<div class="container-fluid" id="main-container">
	
	<div class="row-fluid">
		<div class="table-header">司机信息</div>
		<div id="div_content" class="row-fluid" style="padding-top: 10px;">
			<form id="myForm" class="form-horizontal" method="post" >
				<input type="hidden" name="id" value="${driver.id }">
				<div class="control-group">
					<label class="control-label" for="name"><span class="red f12">* </span>姓名:</label>
					<label class="control-label" for="name">${driver.name }</label>
				</div>
				<div class="control-group">
					<label class="control-label" for="name"><span class="red f12">* </span>电话号码:</label>
					<label class="control-label" for="name">${driver.tel }</label>
				</div>
				<div class="hr hr-dotted"></div>
		  	</form>
		</div>
		
		<div style="text-align: center;">
			<a title="保存" href="javascript:;" class="btn btn-info" id="back-btn" onclick="save()"><i class="icon-save"></i> 保存</a>
			<a title="返回" href="javascript:;" class="btn btn-grey" id="back-btn" onclick="back()"><i class="icon-reply"></i> 返回</a>
		</div>
	</div>
</div>
<!-- #main-content -->
</body>
<%@ include file="../../admin/foot.jsp"%>
<script type="text/javascript" src="static/app/pc/js/base.js"></script>
<script type="text/javascript">
//保存
function save(){
	var formObj = serializeObject($("#myForm"));
		
	$.post('admin/lxy/driver/edit', formObj , function(res) {
		if (res.status == 'success') {
			bootbox.alert("提交成功！",function(){
				back();
			});
			
		}else {
			bootbox.alert("提交失败");
		}
	}, "JSON");
}



	//返回
	function back(){
		location.href = "admin/lxy/driver/main";
	}

	
</script>
</html>
