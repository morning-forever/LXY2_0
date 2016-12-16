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
	
	<link rel="stylesheet" type="text/css" href="static/system/css/sys_style.css"/>
	
	<link rel="stylesheet" href="static/css/jquery.dataTables.css" />
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
				<table style="margin-left: 5px;" id="btnmenu" class="select_table">
					<tbody>
						<tr>
							<td>
								附加项目名：
							</td>
							<td>
								<input type="text" class="name" id="name" placeholder="请输入名称(可以部分输入)" style="width: 200px;">
							</td>
							<td>
								<a title="查询" class="btn btn-mini btn-success" id="searchBtn"><i class="icon-search"></i>查询</a>
								<a title="清空" class="btn btn-mini btn-success" id="clearBtn"><i class="icon-refresh"></i>清空</a>
							</td>
						</tr>
					</tbody>
				</table>
				
				<div>
					<a type="button" class="btn btn-primary" href="admin/lxy/add_svc/addUI">新增项目</a>
				</div>
					
				<table id="table_report" class="table table-striped table-bordered table-hover">
					<thead>
						<tr>
							<th width="2%" class="sorting_disabled">序号</th>
							<th width="10%" class="sorting_disabled">附加项</th>
							<th width="10%" class="sorting_disabled">公里数</th>
							<th width="10%" class="sorting_disabled">操作</th>
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
	$("#searchBtn").click(function(){
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
		//"bFilter": false, //去掉自带收索框
		"serverSide" : true,
		"bDestroy": true,
        "ajax": {
        	url:"admin/lxy/add_svc/list/data",	
        	type: "POST"
        },
		"columns": [
            { "data": null },//0-序号
            { "data": "name" },
            { "data": "km" },
            { "data": "id" }//10-操作
        ],
        "columnDefs": [
			{
				"targets": 0,
				render: function (a, b, c, d) {
	                return d.row+1;
				}
			},
			{
 	            "targets": 3,
 	           	 render: function (a, b, c, d) {
	            	var context ;
	            	context = 
 	                {
 	                    func: [
 	                        {"name": "编辑", "fn": "edit(\'" + c.id + "\')", "type": "purple", "icon":"edit"},
 	                        {"name": "删除", "fn": "doDelete(\'" + c.id + "\')", "type": "danger", "icon":"trash"}
 	                    ]
 	                };
	            	return template(context);
          		}
  	        }
   		]
    });
}

var edit = function(id){
	location.href="admin/lxy/add_svc/editUI/"+id;
};

var doDelete =function(id){
	bootbox.confirm("您确定要删除此反馈，删除后不能恢复！",function(b){
		if(b){
			$.post("admin/lxy/add_svc/delete/"+id,function(res){
				if('success' == res.status){
					bootbox.alert("操作成功！");
				}else{
					bootbox.alert("操作失败！");
				}
				$("#searchBtn").click();
			},"JSON");
		}
	});
};

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

