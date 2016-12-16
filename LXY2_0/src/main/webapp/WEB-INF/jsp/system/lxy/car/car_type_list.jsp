<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html >
<html lang="en">
	<head>
	<base href="<%=basePath%>">
	<!-- jsp文件头和头部 -->
	<%@ include file="../../admin/top.jsp"%>
	
	
	<link id="skin" rel="stylesheet" href="static/jbox/Pink/jbox.css" />
    <script type="text/javascript" src="static/jbox/js/jquery.jBox.src.js"></script>
	</head>
	<style type="text/css">
		/* 分页按钮 start */
		[class^="icon-"]:before, [class*=" icon-"]:before {
			height: 20px;
		    line-height: 20px;
		    text-decoration: inherit;
		    display: inline-block;
		    speak: none;
		}
		/* 分页按钮  end*/
		.dataTables_filter {
		   display: none;
		}
		.last{
			width:50px;
		}
	</style>
<body>
		
<div class="container-fluid" id="main-container">
	<div id="page-content" class="clearfix">
		<div class="row-fluid">
			<div class="row-fluid">
				<table style="margin-left: 5px;" id="btnmenu">
					<tbody>
						<tr>
							<td>
								车型:
							</td>
							<td>
								<input type="text" class="mysearch" id="name" style="width: 200px;">
							</td>
							<td>
								座位数:
							</td>
							<td>
								<input type="text" class="mysearch" id="seatNum" style="width: 200px;">
							</td>
							<td>
								单价:
							</td>
							<td>
								<input type="text" class="mysearch" id="price" style="width: 200px;">
							</td>
							<td>
								<a title="查询" class="btn btn-mini btn-success" id="searchBtn"><i class="icon-search"></i>查询</a>
							</td>
							<td>
								<a title="清空" class="btn btn-mini btn-success" id="clearBtn"><i class="icon-refresh"></i>清空</a>
							</td>
						</tr>
						<tr>
							<td><a href="admin/lxy/car_type/addUI" class="btn btn-small btn-success">新增</a></td>
						</tr>
					</tbody>
				</table>
				<table id="table_report" class="table table-striped table-bordered table-hover">
					<thead>
						<tr>
							<th >序号</th>
							<th >车型名</th>
							<th >座位数</th>
							<th >总数</th>
							<th >单价</th>
							<th >添加车辆</th>
							<th >操作</th>
						</tr>
					</thead>
					<tbody></tbody>
				</table>
			</div>
 		 </div>
	</div><!--/#page-content-->
</div><!--/.fluid-container#main-container-->
<%@ include file="../../admin/foot.jsp"%>
		
<!-- 返回顶部  -->
<a href="#" id="btn-scroll-up" class="btn btn-small btn-inverse">
	<i class="icon-double-angle-up icon-only"></i>
</a>

<!-- 引入 -->
<script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
<script src="static/js/bootstrap.min.js"></script>
<script src="static/js/ace-elements.min.js"></script>
<script src="static/js/ace.min.js"></script>

<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script><!-- 下拉框 -->
<script type="text/javascript" src="static/js/bootstrap-datepicker.min.js"></script><!-- 日期框 -->
<script type="text/javascript" src="static/js/bootbox.min.js"></script><!-- 确认窗口 -->
<script type="text/javascript" src="static/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="static/app/pc/js/base.js"></script>
<!-- 引入 -->

<script type="text/javascript" src="static/js/jquery.tips.js"></script><!--提示框-->

<script id="tpl" type="text/x-handlebars-template">
	{{#each func}}
	<a class="btn btn-mini btn-{{this.type}}" href="javascript:;" title="{{this.name}}" target="mainFrame" onclick="{{this.fn}}"><i class="icon-{{this.icon}}"></i></a>
	{{/each}}
</script>

<script type="text/javascript">
$(top.hangge());

var tpl = $("#tpl").html();
//预编译模板
var template = Handlebars.compile(tpl);

$(document).ready(function(){
	$('.date-picker').datepicker();
	
	//初始化加载列表
	initMainList();
	
	//查询
	var table = $("#table_report").DataTable();
	$("#searchBtn").click(function() {
		var json = '{';
		$("#btnmenu select,#btnmenu input").each(function() {
			json += '"' + this.id + '":"' + $(this).val() + '",';
		});
		json = json.substr(0, json.length - 1);
		json += '}';
		table.search(json).draw();
	});
	
	//清空
	$("#clearBtn").click(function(){
		$("#btnmenu input,#btnmenu select").val("");
	});
	
});


//初始化加载列表
function initMainList(){
	$('#table_report').DataTable( {
		"sDom": "<<'span6'f>r>t<'row-fluid'<'span6'il><'span6'p>>",
		//"searching":false,
		"serverSide" : true,
		"bDestroy": true,
        "ajax": {
        	url:"admin/lxy/car_type/list",	
        	type: "POST"
        },
		"columns": [
            { "data": null },//0-序号
            { "data": "name"},
            { "data": "seatNum" },
            { "data": "count" },
            { "data": "price" },
            { "data": null}
        ],
        "columnDefs": [
			{
				"targets": 0,
				render: function (a, b, c, d) {
	                return d.row+1;
				}
			},
			{
				"targets": 5,
				render: function (a, b, c, d) {
					return "<button class=\"btn btn-minier btn-primary\" onclick='addCar("+c.id+")'>+&nbsp;添加车辆</button>"
				}
			},
			{
				"targets":6,
				render: function (a, b, c, d) {
					var context = 
	 	                {
	 	                    func: [
	 	                        {"name": "编辑", "fn": "doEdit(\'" + c.id + "\')", "type": "purple", "icon":"edit"},
	 	                        {"name": "删除", "fn": "doDelete(\'" + c.id + "\')", "type": "danger", "icon":"trash"}
	 	                    ]
	 	                };
	            	return template(context);
				}
			}
   		]
    });
}

function doEdit(typeId){
	location.href = "admin/lxy/car_type/editUI/"+typeId;
}

function addCar(typeId){
	location.href = "admin/lxy/car/base_info/addUI/"+typeId;
}

function doDelete(typeId){
	$.post("admin/lxy/car_type/delete/"+typeId,function(res){
		if(res.status="success"){
			bootbox.alert("删除成功！",function(){
				location.href="admin/lxy/car_type/main";
			});
			
		}else{
			bootbox.alert("删除失败");
		}
	});
}



</script>
		
</body>
</html>

