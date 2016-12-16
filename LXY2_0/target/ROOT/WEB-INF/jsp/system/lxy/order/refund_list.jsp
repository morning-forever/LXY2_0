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
	
	<link rel="stylesheet" type="text/css" href="static/system/css/sys_style.css"/>
	
	<link id="skin" rel="stylesheet" href="static/jbox/Pink/jbox.css" />
    <script type="text/javascript" src="static/jbox/js/jquery.jBox.src.js"></script>

</head>
<style type="text/css">

table.dataTable thead th{
	padding: 10px 0px;
	text-align: center;
}

.small-input{
	width: 180px;
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
					<table style="margin-left: 5px;" id="btnmenu" class="select_table">
						<tbody>
							<tr>
								<td>
									商品标题：
								</td>
								<td>
									<input type="text" class="mysearch" id="name" style="width: 160px;"> 
								</td>
								<td>
									商品订单号：
								</td>
								<td>
									<input type="text" class="mysearch" id="orderCode" style="width: 160px;"> 
								</td>
								<td>
									支付订单号：
								</td>
								<td>
									<input type="text" class="mysearch" id="payOrderId" style="width: 160px;"> 
								</td>
							</tr>
							<tr>
								<td>
									退款人真实姓名：
								</td>
								<td>
									<input type="text" class="mysearch" id="personName" style="width: 160px;"> 
								</td>
								<td>
									退款银行：
								</td>
								<td>
									<input type="text" class="mysearch" id="bankName" style="width: 160px;"> 
								</td>
								<td>
									订单状态：
								</td>
								<td>
									<select id="orderState" style="width: 174px;">
										<option value="">全部</option>
										<option value="'REFUNDING'">退款中</option>
										<option value="'REFUNDING_FAIL'">退款失败</option>
										<option value="'REFUNDED'">退款完成</option>
									</select>
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
								<th width="2%" class="sorting_disabled">序号</th>
								<th width="10%" class="sorting_disabled">线路名称</th>
								<th width="10%" class="sorting_disabled">商品订单号</th>
								<th width="10%" class="sorting_disabled">支付订单号</th>
								<th width="5%" class="sorting_disabled">用户账号</th>
								<th width="10%" class="sorting_disabled">联系人电话</th>
								<th width="5%" class="sorting_disabled">订单金额</th>
								<th width="8%" class="sorting_disabled">申请退款时间</th>
								<th width="5%" class="sorting_disabled">支付方式</th>
								<th width="7%" class="sorting_disabled">真实姓名</th>
								<th width="2%" class="sorting_disabled">退款银行</th>
								<th width="2%" class="sorting_disabled">退款银行账号</th>
								<th width="8%" class="sorting_disabled">退款完成时间</th>
								<th width="6%" class="sorting_disabled">退款状态</th>
								<th width="20%" class="sorting_disabled">操作</th>
							</tr>
						</thead>
						<tbody></tbody>
					</table>
					
				</div>
	 		 </div>
		</div><!--/#page-content-->
		<!--#breadcrumbs-->
	</div>
	
		<!-- Modal 审核弹出框-->
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="addBrandModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times; </span>
					</button>
				</div>
				<input type="hidden" id="refundId" value="">
				<input type="hidden" id="orderId" value="">
				<div class="modal-body">
					<div class="form-group">
						<table style="margin-left: 5px;margin: 0 auto;" id="btnmenu">
							<tr>
								<th>审核是否通过？</th>
							</tr>
							<tr>
								<th>审核通过后不可修改</th>
							</tr>
							<tr>
								<td>
									<textarea rows="3" cols="3" placeholder="请填写未通过原因（30字以内）" maxlength="30" id="reason"></textarea>
								</td>
							</tr>
						</table>
					</div>
				</div>
				<div class="dialogBottom">
				<a title="通过" onclick="doCheck(0);" href="javascript:;" class="btn btn-mini btn-success"><i class="icon-ok"></i> 通过</a>
				<a title="未通过" onclick="doCheck(1);" href="javascript:;" class="btn btn-mini btn-danger"><i class="icon-remove"></i> 未通过</a>
				</div>
			</div>
		</div>
	</div>
		
		<!-- Modal 退款失败弹出框-->
		<div class="modal fade" id="failModal" tabindex="-1" role="dialog" 
		aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
					<div class="form-group">
						<table style="margin-left: 5px;margin: 0 auto;" id="btnmenu">
							<tr>
								<td>
									退款备注：<textarea id="failReason" style="width: 400px;height: 80px" placeholder="请填写未通过原因（30字以内）"></textarea>
								</td>
							</tr>
						</table>
					</div>
				</div>
				</div>
				<div style="padding: 10px 350px;">
					<button type="button" class="btn btn-primary" id="save-btn" onclick="doRefundFail();">提交</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				</div>
			</div>
		</div>
		
		<!-- Modal 审核记录弹出框-->
		<div class="modal fade" id="recordModal" tabindex="-1" role="dialog" aria-labelledby="addBrandModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times; </span>
					</button>
				</div>
				<div class="modal-body">
					<div class="form-group examineListDetial">
						<table id="examineListDetial" class="examineDetial">
							<tr>
								<td>
									<span>昵称：</span><span class="nickName"></span>
								</td><td>
									<span>姓名：</span><span class="name"></span>
								</td><td>
									<span>联系电话：</span><span class="phone"></span>
								</td>
							</tr>
							<tr>
								<td>
									<span>退款银行：</span><span class="bankName"></span>
								</td><td colspan="2">
									<span>退款银行帐号：</span><span class="bankCard"></span>
								</td>
							</tr>
							<tr>
								<td>
									<span>退款原因：</span><span class="tkReason"></span>
								</td>
							</tr>
						</table>
						<hr>
						<table style="margin-left: 5px;" id="examineListTable">
						</table>
					</div>
				</div>
				<div class="dialogBottom">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				</div>
			</div>
		</div>
	</div>
		
	<%@ include file="../../admin/foot.jsp"%>
</body>

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
		
		/* //设置table的宽度
		$("#table_report").on('draw.dt',function() {
	    	$(".dataTables_wrapper").css("width","1700px");
	    }); */
		
		//初始化时间插件
		$('.mydate-picker').datepicker();
		
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
			//"bFilter": false, //去掉自带收索框
			"serverSide" : true,
			"bDestroy": true,
	        "ajax": {
	        	url:"admin/lxy/refund/listdata",	
	        	type: "POST"
	        },
			"columns": [
	            { "data": null },//0-序号
	            { "data": "name" },//1-商品标题
	            { "data": "order_code" },//2-商品订单号
	            { "data": "pay_order_id" },//3-支付订单号
	            { "data": "username" },//4-用户账号
	            { "data": "phone" },//5-联系人电话
	            { "data": "price" },//6-订单金额
	            { "data": "create_time" },//7-申请退款时间
	            { "data": "pay_type" },//8-支付方式
	            { "data": "realname" },//9-真实姓名
	            { "data": "bankName" },//10-退款银行
	            { "data": "bank_no" },//11-退款银行账号
	            { "data": "finish_time" },//12-退款完成时间
	            { "data": "order_state" },//13-退款状态
	            { "data": null }//14-操作
	        ],
	        "columnDefs": [
				{
					"targets": 0,
					render: function (a, b, c, d) {
		                return d.row+1;
					}
				},
				{
					"targets" : 4 ,
					render : function(a, b, c, d) {
						var name = "<a href='admin/webusermngr/infoUser?id="+c.userId+"'>"+c.username+"</a>";
						return name;
					}
				}, 
				{
					"targets" : 7,
					render : function(a, b, c, d) {
						var date = new Date(a).format("yyyy-MM-dd");
						return date;
					}
				},
				{
					"targets" : 8,
					render : function(a, b, c, d) {
						var type = "";
						if(a == 'alipay'){
							type = "支付宝";
						}else if(a == 'unionpay'){
							type = "银联";
						}
						return type;
					}
				},
				{
					"targets" : 11,
					render : function(a, b, c, d) {
						var num = a.replace(/\s/g,'').replace(/(\d{4})(?=\d)/g,"$1 ");//先去掉所有的空格,再每隔4个数字加空格
						return num;
					}
				},
				{
					"targets" : 12,
					render : function(a, b, c, d) {
						if(a != null){
							var date = new Date(a).format("yyyy-MM-dd hh:mm:ss");
							return date;
						}else{
							return "";
						}
						
					}
				},
				{
					"targets" : 13,
					render : function(a, b, c, d) {
						return getStateDesc(a);
					}
				},
				{
	 	            "targets": 14,
	 	            render: function (a, b, c, d) {
	 	            	var context ;
	 	            	//退款中
	 	            	if(c.order_state == 'REFUNDING'){
	 	            		//未审核（审核记录，审核，删除）
	 	            		if(c.is_check == 1){
	 	            			context = 
		 	 	                {
		 	 	                    func: [
			 	 	                    {"name": "审核记录", "fn": "openExamineModel(\'" + c.orderId + "\')", "type": "purple", "icon":"list"},
		 	 	                        {"name": "审核", "fn": "openModel(\'" + c.refundId + "\',\'" + c.orderId + "\')", "type": "light", "icon":"search"},
		 	 	                        {"name": "删除", "fn": "doDelete(\'" + c.orderId + "\')", "type": "danger", "icon":"trash"}
		 	 	                    ]
		 	 	                };
	 	            		}
	 	            		//已审核（审核记录，退款完成，退款失败，删除）
	 	            		if(c.is_check == 0){
	 	            			context = 
		 	 	                {
		 	 	                    func: [
		 	 	                        {"name": "审核记录", "fn": "openExamineModel(\'" + c.orderId + "\')", "type": "purple", "icon":"list"},
		 	 	                        {"name": "退款完成", "fn": "doRefundSuccess(\'" + c.refundId + "\',\'" + c.orderId + "\',\'REFUNDED\')", "type": "purple", "icon":"ok-sign"},
		 	 	                        {"name": "退款失败", "fn": "openFailModel(\'" + c.orderId + "\')", "type": "purple", "icon":"remove-sign"},
		 	 	                        {"name": "删除", "fn": "doDelete(\'" + c.orderId + "\')", "type": "danger", "icon":"trash"}
		 	 	                    ]
		 	 	                };
	 	            		}
	 	            	}
	 	            	//退款完成和退款失败
	 	            	else{
	 	            		context = 
	 	 	                {
	 	 	                    func: [
	 	 	                        {"name": "审核记录", "fn": "openExamineModel(\'" + c.orderId + "\')", "type": "purple", "icon":"list"},
	 	 	                        {"name": "删除", "fn": "doDelete(\'" + c.orderId + "\')", "type": "danger", "icon":"trash"}
	 	 	                    ]
	 	 	                };
	 	            	}
	 	            	return template(context);
	           		}
	  	        }
	   		]
	    });
	}
	
	//打开审核弹出框
	function openModel(refundId, orderId){
		$("#refundId").val(refundId);
		$("#orderId").val(orderId);
		$("#myModal").modal("show");
	}
	
	//审核
	function doCheck(result){
		//审核通过，则只修改审核状态，不添加审核记录
		if(result == 0){
			var json = {
					'refundId' : $("#refundId").val(),
					'orderId' : $("#orderId").val()
				};
				$.post('admin/lxy/refund/saveCheck', json ,function(res){
					if(res.status == 'success'){
						bootbox.alert("审核成功！");
						$('#table_report').DataTable().clear();
						$('#table_report').DataTable().draw();
					}else if(res.status == 'error'){
						bootbox.alert("审核失败！");
					} else {
						bootbox.alert("服务器异常！");
					}
					$("#myModal").modal("hide");
				});
		}
		//审核未通过，则相当于退款失败，添加审核记录
		else if(result == 1){
			var json = {
				'refundId' : $("#refundId").val(),
				'orderId' : $("#orderId").val(),
				'reason' : $("#reason").val(),
				'result' : 1,
				'state' : 'REFUNDING_FAIL' //修改的订单状态
			};
			$.post('admin/lxy/refund/saveRefund', json ,function(res){
				if(res.status == 'success'){
					bootbox.alert("提交成功！");
					$('#table_report').DataTable().clear();
					$('#table_report').DataTable().draw();
				}else if(res.status == 'error'){
					bootbox.alert("提交失败！");
				} else {
					bootbox.alert("服务器异常！");
				}
				$("#myModal").modal("hide");
			});
		}
	}
	
	//退款完成
	function doRefundSuccess(refundId, orderId){
		bootbox.confirm("确认退款完成吗?", function(result) {
			if (result) {
				$.ajax({
					url : "admin/lxy/refund/saveRefund",
					post : "post",
					data : {
						'refundId' : refundId,
						'orderId' : orderId,
						'result' : 0,
						'state' : 'REFUNDED' //修改的订单状态
					},
					success : function(res) {
						if(res.status == 'success'){
							bootbox.alert("提交成功！");
							$('#table_report').DataTable().clear();
							$('#table_report').DataTable().draw();
						}else if(res.status == 'error'){
							bootbox.alert("审核失败！");
						} else {
							bootbox.alert("服务器异常！");
						}
					}
				});
			}
		});
	}
	
	//打开退款失败弹出框
	function openFailModel(orderId){
		$("#orderId").val(orderId);
		$("#failModal").modal("show");
	}
	
	//提交退款失败
	function doRefundFail(){
		var json = {
			'orderId' : $("#orderId").val(),
			'reason' : $("#failReason").val(),
			'result' : 1,
			'state' : 'REFUNDING_FAIL' //修改的订单状态
		};
		$.post('admin/lxy/refund/saveRefund', json ,function(res){
			if(res.status == 'success'){
				bootbox.alert("提交成功！");
				$('#table_report').DataTable().clear();
				$('#table_report').DataTable().draw();
			}else if(res.status == 'error'){
				bootbox.alert("提交失败！");
			} else {
				bootbox.alert("服务器异常！");
			}
			$("#failModal").modal("hide");
		});
	}
	
	//查看审核记录
	function openExamineModel(orderId){
		$.post('admin/lxy/refund/examineList', {'orderId': orderId} ,function(res){
			if(res.status == 'success'){
				var table = $("#examineListTable").empty();
				var user = res.refundInfo;
				var list = res.examineList;
				$("#examineListDetial .nickName").html(user.username);
				$("#examineListDetial .name").html(user.realname);
				$("#examineListDetial .phone").html(user.phone);
				$("#examineListDetial .bankName").html(user.bank_name);
				$("#examineListDetial .bankCard").html(user.bank_no);
				$("#examineListDetial .tkReason").html(user.tkReason);
				for(var i=0; i<list.length; i++){
					var item = $("#examineListModel").children().clone();
					item.find(".createTime").html(new Date(list[i].create_time).format("yyyy-MM-dd hh:mm:ss"));
					item.find(".reason").html(list[i].reason);
					var state = "";
					if(list[i].result == 1){
						state = "退款失败";	
					}else{
						state = "退款成功"
					}
					item.find(".state").html(state);
					table.append(item);
				}
				
			}else {
				bootbox.alert("服务器异常！");
			}
		});
		$("#recordModal").modal("show");
	}
	
	//删除
	function doDelete(id){
		var submit = function (v, h, f) {
		    if (v == true){
		    	$.ajax({
					url : "admin/lxy/refund/deleteOrder",
					post : "post",
					data : {
						"id" : id
					},
					success : function(data) {
						if (data.status == "success") {
							jBox.tip("删除成功!",'success');
							$('#table_report').DataTable().clear();
							$('#table_report').DataTable().draw();
						} else {
							jBox.tip("服务器异常！");
						}
					}
				});
		    }
		    return true;
		};
		
		jBox.confirm("确定要删除吗?", null, submit, { id:'delete', showScrolling: false, buttons: { '确定': true, '取消': false } });
	}
	
	//获取订单状态描述
	function getStateDesc(orderState){
		var desc = "";
		if(orderState == 'WAITPAY'){
			desc = '待付款';
		}else if(orderState == 'PAY_OK'){
			desc = '交易成功';
		}else if(orderState == 'CLOSED'){
			desc = '交易关闭';
		}else if(orderState == 'REFUNDING'){
			desc = '退款中';
		}else if(orderState == 'REFUNDING_FAIL'){
			desc = '退款失败';
		}else if(orderState == 'REFUNDED'){
			desc = '退款完成';
		}
		return desc;
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
