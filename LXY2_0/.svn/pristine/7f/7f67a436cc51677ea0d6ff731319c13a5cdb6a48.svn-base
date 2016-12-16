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
	<script type="text/javascript" src="static/app/pc/js/base.js"></script>
</head>
<body>
<div class="container-fluid" id="main-container">
	
	<div class="row-fluid">
		<div class="table-header">新增车辆信息</div>
		<div id="div_content" class="row-fluid" style="padding-top: 10px;">
			<form id="myForm" class="form-horizontal" method="post" >
				<input type="hidden" id="carTypeId" name="carTypeId" value="${carType.id }">
				<div class="control-group">
					<label class="control-label" for="name"><span class="red f12">* </span>车型:</label>
					<div class="controls">
						<div class="span12">
							${carType.name }${carType.seatNum }
						</div>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="name"><span class="red f12">* </span>车牌号:</label>
					<div class="controls">
						<div class="span12">
							<input type="text" id="plateNumber" name="plateNumber"  style="width: 300px;"/>
						</div>
					</div>
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
<script type="text/javascript">
//保存
function save(){
	var formObj = serializeObject($("#myForm"));
	$.post('admin/lxy/car/base_info/add', formObj , function(res) {
		if (res.status == 'success') {
			bootbox.alert("提交成功！",function(){
				back();
			});
			
		} else if(res.status=='exists') {
			bootbox.alert("系统已存有该车牌号，车牌号不能重复！");
		}else{
			bootbox.alert("系统内部异常，请联系维护人员解决！");
		}
	}, "JSON");
}



//返回
function back(){
	location.href = "admin/lxy/car_type/main";
}

function scroll(id){
	$("html,body").animate({scrollTop:$("#"+id).offset().top},200)
}
	
</script>
</html>
