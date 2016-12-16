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
	<!-- jsp文件头和头部 -->
	<%-- <%@ include file="../../system/admin/top.jsp"%>   --%> 
	</head>
	<link id="skin" rel="stylesheet" href="static/jbox/Pink/jbox.css" />
    <script type="text/javascript" src="static/jbox/js/jquery.jBox.src.js"></script>
    <link rel="stylesheet" type="text/css" href="static/lxy/css/payment.css"/>
    
<body>
<div class="wrapper inner">
	<!-- page content -->
	<div class=" content_wrap pb90">
		<div class="content">
		   	<img src="static/lxy/images/l_face.png"/>
		   	<div class="right">
			   	<p>
			 		对不起!支付失败<c:if test="${payState eq 'payed' }">,您已经支付过此订单，请不要重复支付。</c:if>   
			   	</p>
			   	<table style="margin-left: 5px;" class="down-part">
					<tbody>
						<tr>
							<td>
								<input value="回到首页" type="button" onclick="back(this)" >
							</td>
						</tr>
					</tbody>
				</table>	
				<%-- <div class="buttn pt20">
					<c:if test="${orderType eq 'depth' }">
						<c:if test="${payState eq 'payed' }"><a class="orangebg" href="<%=basePath %>pc/user/order/depthList">返回订单列表</a></c:if>
						<c:if test="${payState != 'payed' }"><a class="orangebg" href="<%=basePath %>pc/user/order/detail/${orderId }">重新支付</a><a href="#">取消支付</a></c:if>
					</c:if>
				</div> --%>
		  	</div>
		</div>				
	</div>

</div>
	

<script type="text/javascript">
function back(){
	window.location.href="<%=basePath %>lxy/route/list.do";
}

</script>
</body>
</html>