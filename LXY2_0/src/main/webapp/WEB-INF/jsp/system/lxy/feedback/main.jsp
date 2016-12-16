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
<body>
		
<div class="container-fluid" id="main-container">
	<div id="page-content" class="clearfix">
		<div class="row-fluid">
			<div class="row-fluid">
				<table style="margin-left: 5px;" id="btnmenu" class="select_table">
					<tbody>
						<tr>
							<td>
								反馈时间：
							</td>
							<td>
								<div class="input-prepend">
									<span class="add-on"><i class="icon-calendar"></i></span>
									<input class="span10 date-picker" type="text" id="startTime" name="startTime" readonly="readonly" class="span11 mydate-picker" data-date-format="yyyy-mm-dd" style="width: 190px;">
								</div>
								至
								<div class="input-prepend">
									<span class="add-on"><i class="icon-calendar"></i></span>
									<input class="span10 date-picker" type="text" id="endTime" name="endTime" readonly="readonly" class="span11 mydate-picker" data-date-format="yyyy-mm-dd" style="width: 190px;">
								</div>
							</td>
							<td>
								<a title="查询" class="btn btn-mini btn-success" id="searchBtn"><i class="icon-search"></i>查询</a>
								<a title="清空" class="btn btn-mini btn-success" id="clearBtn"><i class="icon-refresh"></i>清空</a>
							</td>
						</tr>
					</tbody>
				</table>
				
				<table id="table_report" class="table table-striped table-bordered table-hover">
					<thead>
						<tr>
							<th width="2%">序号</th>
							<th width="10%">反馈时间</th>
							<th width="8%">反馈类型</th>
							<th width="8%">反馈人姓名</th>
							<th width="8%">用户邮箱</th>
							<th width="8%">用户手机</th>
							<th >反馈内容</th>
							<th width="8%">操作</th>
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

<div class="modal fade" id="openModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
            </div>
        	<ul class="nav nav-tabs" id="otherInfoTab">
			    <li class="active"><a href="javascript:;" id="modalTitle">反馈详情</a></li>
			</ul>
			<div class="tab-content">
				<form id="modalForm_price">
			    	<div class="modal-body">
	                	<table class="mytable-detail">
	                		<tr> 
	                			<td id="message">
	                				内容
	                			</td>
	                		</tr>
	                	</table>
		            </div>
	            </form>
			</div>
			<div style = "padding:10px 350px;">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
			</div>
        </div>
    </div>
</div>

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
		var json = '{"startTime":"'+$("#startTime").val()+'","endTime":"'+$("#endTime").val()+'"}';
		if($("#startTime").val() > $("#endTime").val()){
			alert("反馈开始时间不能大于反馈结束时间");
			return ;
		}
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
        	url:"admin/lxy/feedback/list",	
        	type: "POST"
        },
		"columns": [
            { "data": null },//0-序号
            { "data": "createTime" },
            { "data": "type" },
            { "data": "username" },
            { "data": "email" },
            { "data": "phone" },
            { "data": "message" },
            { "data": "id" }//10-操作
        ],
        "columnDefs": [
			{
				"targets": 0,
				render: function (a, b, c, d) {
	                return d.row+1;
				}
			},{
				"targets": 2,
				render: function (a, b, c, d) {
					var t="";
					if(c.type == 1){
						t="车辆问题";
					}else if(c.type == 2){
						t="路线问题";
					}else if(c.type == 3){
						t="支付问题";
					}else{
						t="其他";
					}
			        return t;
				}
			},{
 	            "targets": 7,
 	           render: function (a, b, c, d) {
	            	var context =
	                {
	                    func: [
	                        {"name": "查看", "fn": "info(\'" + c.id + "\')", "type": "light", "icon":"eye-open"},
	                        {"name": "删除", "fn": "del(\'" + c.id + "\')", "type": "danger", "icon":"trash"}
	                    ]
	                };
	                var html = template(context);
	            	return html;
          		}
  	        }
   		]
    });
}

var info = function(id){
	var data = {"id":id};
	$.post("admin/lxy/feedback/detail",data,function(res){
		if('success' == res.status){
			$("#openModal").find("#message").html(res.message);
			$("#openModal").modal("show");
		}else{
			bootbox.alert("操作失败！");
		}
	},"JSON");
};

var del =function(id){
	bootbox.confirm("您确定要删除此反馈，删除后不能恢复！",function(b){
		if(b){
			var data = {'id':id};
			$.post("admin/lxy/feedback/dels",data,function(res){
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

