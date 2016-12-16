<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!doctype html>
<head>
	<meta charset="utf-8">
	<meta content="text/html">
	<base href="<%=basePath%>">
	<script type="text/javascript" src="static/1.9.1/jquery.min.js"></script>
	
	<script>
		function sendData(){
			
			//一、测试锁车接口
			
			var jsonData = {userId:'14ccdea00b38410bb644089f6382a0d6',token:"78c265eef138465c9fafc0bca40e6826",startTime:"2016-10-01",endTime:"2016-10-02",needCars:[{typeId:1,count:2},{typeId:2,count:2},{typeId:3,count:2}]}
			
			/* jsonData = JSON.stringify(jsonData);
			jsonData = {data:jsonData}; */
			$.ajax({
				'type' : 'POST',  
	            'url' : 'mobile/car/lockCar',  
	           'contentType' : 'application/json',
	            'data' : jsonData,
	            'dataType' : 'json',  
	            'success' : function(data){
	            	
	            	alert(data);
	            	alert(JSON.stringify(data))
	            }  });   
	            
	        //2、测试路线细节站点公里数接口
			/*  var jsonData = [["0100010001","0200060014","0200120024"],["0200120024","0300070012","0400010001"],["0400010001","0300040008","0300030005","0100010001"]];
			
			jsonData = JSON.stringify(jsonData);
			$.ajax({
				'type' : 'POST',  
	            'url' : 'mobile/route/dtlDstList',  
	            'contentType' : 'application/json',  
	            'data' : jsonData,
	            'dataType' : 'json',  
	            'success' : function(data){
	            	
	            	alert(data);
	            	alert(JSON.stringify(data))
	            }  });    */ 
	            
	          
	        //3/测试提交订单    
	        
			/* var jsonData = {userId:'14ccdea00b38410bb644089f6382a0d6',
	    	   	 oldToken:"3b064097d338444cb4b7c1248db9cf31",
	    	   	 carStateIds:'1037',
				 startTime:'2016-09-11',
				 endTime:'2016-09-12', 
				 personPhone:"18286101861",
				 addChargesIds:'1,2', 
				 name:'郭朝永xxxxx', 
				 distanceIds:'[[263,7446],[7881,8112]]',
				 personName:'郭朝永', 
				 payMethod:'ALLPAY'};
			
			//jsonData = JSON.stringify(jsonData);
			$.ajax({
				'type' : 'POST',  
	            'url' : 'mobile/order/submit',
	            'data' : jsonData,
	            'dataType' : 'json',  
	            'success' : function(data){
	            	
	            	alert(data);
	            	alert(JSON.stringify(data))
	            }  });  */
	            
	            
	        //4.查车选车
			/*  var jsonData = {startTime:"2016-10-01",endTime:"2016-10-02"}
			
			$.ajax({
				'type' : 'POST',  
	            'url' : 'mobile/car/availableCars',  
	            'data' : jsonData,
	            'dataType' : 'json',  
	            'success' : function(data){
	            	
	            	alert(data);
	            	alert(JSON.stringify(data))
	            }  }); */ 
	        
	        //5.登录
	         
			/* var jsonData = {USERNAME:'gcy',PASSWORD:'ch2301'};
			
			$.ajax({
				'type' : 'POST',  
	            'url' : 'mobile_login',  
	            'data' : jsonData,
	            'dataType' : 'json',  
	            'success' : function(data){
	            	
	            	alert(data);
	            	alert(JSON.stringify(data))
	            }  }); */
	          
	            
	        //6.订单列表
			/* var jsonData = {pageNum:1,userId:'efed8ea355a84762880da089f00247af',token:'ae1ae90c015b46f992eca0078db1944f'};
			
			$.ajax({
				'type' : 'POST',  
	            'url' : 'mobile/order/getList',  
	            'data' : jsonData,
	            'dataType' : 'json',  
	            'success' : function(data){
	            	
	            	alert(data);
	            	alert(JSON.stringify(data))
	            }  }); */
	            
	            
	      //订单详情
			/* var jsonData = {orderId:170};
			
			$.ajax({
				'type' : 'POST',  
	            'url' : 'mobile/order/orderDetail',  
	            'data' : jsonData,
	            'dataType' : 'json',  
	            'success' : function(data){
	            	
	            	alert(data);
	            	alert(JSON.stringify(data))
	            }  }); */
	      
		}
	</script>
</head>
<body>
	<a onclick="sendData()">发数据</a>
</body>