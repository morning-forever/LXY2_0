﻿<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	<%@ include file="../../admin/top.jsp"%>
	
	<link rel="stylesheet" type="text/css" href="static/lxy/css/style.css"/>
	
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
									<input  type="text" id="carTypeName" name="carTypeName" class="mysearch" style="width: 190px;"></input>
							</td>
							<td>
								车牌号:
							</td>
							<td>
								<div class="input-prepend">
									<input class="mysearch" type="text" id="plateNumber" name="plateNumber" data-date-format="yyyy-mm-dd" style="width: 190px;"></input>
								</div> 
							</td>
							
							<td>
								座位数:
							</td>
							<td>
								<input type="text" class="mysearch" id="seatNum" style="width: 200px;">
							</td>
						</tr>
						<tr>
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
					</tbody>
				</table>
				<table id="table_report" class="table table-striped table-bordered table-hover">
					<thead>
						<tr>
							<th >序号</th>
							<th >车型</th>
							<th >车牌号</th>
							<th >座位数</th>
							<th >单价</th>
							<th >司机</th>
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
<script type="text/javascript" src="static/lxy/js/base.js"></script>
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
	//$('.date-picker').datepicker();
	
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
        	url:"admin/lxy/car/base_info/data",	
        	type: "POST"
        },
		"columns": [
            { "data": null },//0-序号
            { "data": "name"},
            { "data": "plate_number" },
            { "data": "seat_num" },
            { "data": "price" },
			{ "data": "driver_id"},
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
				"targets":5,
				render: function (a,b,c,d) {
					if(a==undefined){
						return "<button class=\"btn btn-minier btn-primary\" onclick='assDri("+c.id+")'>关联司机</button>"
					}else{
						return "<button class=\"btn btn-minier btn-inverse\" onclick='assDri("+c.id+")'>换司机</button>&nbsp;&nbsp;<button class=\"btn btn-minier btn-info\" onclick='shoDriInf("+c.id+")'>查看司机信息</button> "
					}
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

function assDri(carId){
	location.href="admin/lxy/dri_car_int_ass/carAssDriAddUI/"+carId;
}
function shoDriInf(carId){
	location.href="admin/lxy/dri_car_int_ass/shoDriInf/"+carId;
}

function changeDriver(carId){
	location.href="admin/lxy/driver/editUI/"+carId;
}

function doEdit(id){
	location.href="admin/lxy/car/base_info/editUI/"+id;
}

function doDelete(id){
	bootbox.confirm("确定要删除吗？",function(result){
		if(result){
			$.post("admin/lxy/car/base_info/delete/"+id,function(res){
				if(res.status == "success"){
					bootbox.alert("删除成功",function(){
						location.href="admin/lxy/car/base_info/list";
					});
					
				}else{
					bootbox.alert("删除失败");
				}
			});
		}
	});
	
}

Date.prototype.format = function(format) {
    var date = {
           "M+": this.getMonth() + 1,
           "d+": this.getDate(),
           "h+": this.getHours(),
           "m+": this.getMinutes(),
           "s+": this.getSeconds(),
           "q+": Math.floor((this.getMonth() + 3) / 3),
           "S+": this.getMilliseconds()
    };
    if (/(y+)/i.test(format)) {
           format = format.replace(RegExp.$1, (this.getFullYear() + '').substr(4 - RegExp.$1.length));
    }
    for (var k in date) {
           if (new RegExp("(" + k + ")").test(format)) {
                  format = format.replace(RegExp.$1, RegExp.$1.length == 1
                         ? date[k] : ("00" + date[k]).substr(("" + date[k]).length));
           }
    }
    return format;
}

</script>
		
</body>
</html>

