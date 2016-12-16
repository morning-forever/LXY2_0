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
	<%@ include file="../../admin/top.jsp"%>
	
	<link rel="stylesheet" type="text/css" href="static/system/css/style.css"/>

	<link id="skin" rel="stylesheet" href="static/jbox/Pink/jbox.css" />
    <script type="text/javascript" src="static/jbox/js/jquery.jBox.src.js"></script>

</head>
<style type="text/css">
.small-input{
	width: 180px;
}
table.dataTable thead th{
	padding: 10px 0px;
	text-align: center;
}

table.dataTable td{
	vertical-align: middle;
}
.dialogBottom{
	margin: 0 auto 5px;
	width: 250px
}
.examineDetial td{
	padding: 5px 10px;
}
.examineListDetial{
	height: 300px;
	overflow: auto;
}
.bottomTr{
	border-bottom: 1px solid #999999;
}

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
		
</style>
<table id="examineListModel" style="display: none;">
<tr>
	<td class="createTime"></td>
</tr>
<tr class="bottomTr">
	<td class="state"></td>
	<td class="reason"></td>
</tr>
</table>
<body>
	<div class="container-fluid" id="main-container">
		<div id="page-content" class="clearfix">
			<div class="row-fluid">
				<div class="row-fluid">
					<table style="margin-left: 5px;" id="btnmenu">
						<tbody>
							<tr>
								<td>
									线路名称:
								</td>
								<td>
									<input type="text" class="mysearch" id="routeName" placeholder="请输入线路名称(可以部分输入)" style="width: 200px;"> 
								</td>
								<td>
									行程天数:
								</td>
								<td>
									<input type="number" class="mysearch" id="dayNum" style="width: 60px;"> 
								</td>
								<td>
									<a title="查询" class="btn btn-mini btn-success" id="searchBtn"><i class="icon-search"></i>查询</a>
									<a title="清空" class="btn btn-mini btn-success" id="clearBtn"><i class="icon-refresh"></i>清空</a>
								</td>
							</tr>
						</tbody>
					</table>
					
					<div>
						<a type="button" class="btn btn-primary" href = "admin/lxy/default_route/addUI">新增线路</a>
					</div>
					
					<table id="table_report" class="table table-striped table-bordered table-hover">
						<thead>
							<tr>
								<th>序号</th>
								<th width="50%">线路名称</th>
								<th >公里数/km</th>
								<th>行程天数/天</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody></tbody>
					</table>
					
				</div>
	 		 </div>
		</div><!--/#page-content-->
		<!--#breadcrumbs-->
	</div>
	
	<%@ include file="../../admin/foot.jsp"%>
</body>

<script type="text/javascript" src="static/js/jquery.form.js"></script>
<script type="text/javascript" src="static/js/daterangepicker.min.js"></script>
<script type="text/javascript" src="static/js/bootstrap-timepicker.min.js"></script>
<script type="text/javascript" src="static/js/fuelux.spinner.js"></script>
<script type="text/javascript" src="static/app/pc/js/base.js"></script>
<script type="text/javascript" src="static/js/fullcalendar.min.js"></script>
<!--定义操作列按钮模板-->
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
		//初始化加载列表
		initMainList();
		
		//设置table的宽度
		$("#table_report").on('draw.dt',function() {
	    	$(".dataTables_wrapper").css("width","1700px");
	    });
		
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
			"serverSide" : true,
	        "autoWidth": true,
			"bDestroy": true,
			"order": [[ 3, "asc" ]],
	        "ajax": {
	        	url:"admin/lxy/default_route/listdata",	
	        	type: "POST"
	        },
			"columns": [
	            { "data": null },//0-序号
	            { "data": "content" },//1-商品标题
	            { "data": "km" },//2-公里数
	            { "data": "day_num" },//3-公里数
	            { "data": null }
	        ],
	        "columnDefs": [
				{
					"targets": 0,
					render: function (a, b, c, d) {
		                return d.row+1;
					}
				},
				{
					"targets" : 2,
					render : function(a, b, c, d) {
						var name = "<a href='javascript:editKM("+c.id+")'>"+a+"</a>";
						return name;
					}
				},
				{
	 	            "targets": 4,
	 	            render: function (a, b, c, d) {
	 	            	var context ;
	 	            	context = 
 	 	                {
 	 	                    func: [
	 	 	                    {"name": "编辑", "fn": "doEdit(\'" + c.id + "\')", "type": "purple", "icon":"edit"},
 	 	                        {"name": "删除", "fn": "doDelete(\'" + c.id + "\')", "type": "danger", "icon":"trash"}
 	 	                    ]
 	 	                };
	 	            	//退款中
	 	            	return template(context);
	           		}
	  	        }
	   		]
	    });
	}
	
	function doEdit(id){
		location.href = "admin/lxy/default_route/editUI/"+id;
	}
	
	//删除
	function doDelete(id){
		bootbox.confirm("确定要删除吗?", function(result) {
			if (result) {
				$.ajax({
					url : "admin/lxy/default_route/delete/"+id,
					post : "post",
					success : function(data) {
						if (data.status == "success") {
							bootbox.alert("删除成功！");
							$('#table_report').DataTable().clear();
							$('#table_report').DataTable().draw();
						} else {
							bootbox.alert("服务器异常！");
						}
					}
				});
			}
		});
	}
	
	
	function editKM(id){
		var submit = function (v, h, f) {
		    if (v == true){
		    	h.find('.errorBlock').hide('fast', function () { $(this).remove(); });
	            if (f.km == '') {
	                $('<div class="errorBlock" style="display: none;">请输入价格！</div>').prependTo(h).show('slow');
	                return false;
	            }
	            if(isNaN(f.km)){
	            	$('<div class="errorBlock" style="display: none;">请输入数字！</div>').prependTo(h).show('slow');
	   				return false;	
	            }
	   			/* if(!/^[1-9]\d*$/.test(f.price)){
	   				$('<div class="errorBlock" style="display: none;">请输入正整数！</div>').prependTo(h).show('slow');
	   				return false;	
	   			} */
	 			var param = {
	     				"km":f.km,
	     				"id":id
	     			};
	   			$.post('<%=basePath %>admin/lxy/default_route/editKM',param,function(res){
	   				if(res.status == "success"){
	   					$('#table_report').DataTable().clear();
						$('#table_report').DataTable().draw();
	   				}
	   			});
	           
		    return true;
		    }
		};
		var html = '<div class="row-fluid order_wrap">'+
	    '<div class="field"><p>输入距离：</p><input type="text" placeholder="请输入距离" id="km" name="km"></div>' +
	    '<div class="errorBlock" style="display: none;"></div>' +
	    '</div>';
		jBox.confirm1(html, "距离修改", submit, { id:'editprice', showIcon: false, width:290, height:180, showScrolling: false, buttons: { '确定': true, '取消': false } });

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
</html>
