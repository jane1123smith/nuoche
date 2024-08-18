<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE HTML>

<html lang="zh-CN">
<head>
<link href="${pageContext.request.contextPath }/weixin/css/css.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/weixin/css/style.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/weixin/css/font-awesome.min.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/weixin/css/font-awesome.css" rel="stylesheet" type="text/css">
<!--<base href="/static_files/"/>-->

<meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
<!--<meta content="width=device-width,height=device-height,inital-scale=1.0,maximum-scale=1.0,user-scalable=no;" name="viewport">--><!--禁用其缩放（zooming）功能-->

<meta content="yes" name="apple-mobile-web-app-capable">
<meta content="black" name="apple-mobile-web-app-status-bar-style">
<meta content="telephone=no" name="format-detection">
<meta charset="utf-8">
<meta name="description" content="" /><!--网站描述-->
<meta name="keywords" content="" /><!--网站关键字-->
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1.0,maximum-scale=1.0"/>
<!--width - viewport的宽度 height - viewport的高度
initial-scale - 初始的缩放比例
minimum-scale - 允许用户缩放到的最小比例
maximum-scale - 允许用户缩放到的最大比例
user-scalable - 用户是否可以手动缩放-->


<script type="text/javascript" src = "${pageContext.request.contextPath}/daili/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/daili/js/dailichongzhi/amazeui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/daili/js/dailichongzhi/ui-choose.js"></script>





<!--页面滚动插件-->

         
<title>微信支付</title>

</head>


<body style="background-color: #d0f4fa; height: 100%; position: relative; background-position: bottom center; background-size: 100% auto; background-repeat: no-repeat;">
	
	<ul>
		<li>微信支付</li>
		<li>
			<img src="${pageContext.request.contextPath}/payerweima/${returnimg}" style="width: 300px; display: block; margin: 80px auto 20px; box-shadow: 0 0 6px #94E6F3;">
		</li>
		<li> 请用微信扫码支付</li>
	
	</ul>

</body>
订单号：${dingdanhao }



 <script type="text/javascript">
		/* var t1 = window.setInterval(hello,1000); 
		var t2 = window.setInterval("panduan()",3000);  */
		/* 	
		$(function(){
 				setInterval("panduan()",3000)}); */
	</script> 

	
	
<script type="text/javascript">
	
	
	function panduan(){
		var dingdanhao = "${dingdanhao }";
		
		 $.ajax({
			url:'${pageContext.request.contextPath}/dlchongzhi.do?p=pdstatus',
			type:'post',
			
			data:{dingdanhao:dingdanhao},
			
			success:function(jd){
				if($.trim(jd)=="1"){
					clearInterval(t);
					//showPopWin(0,"支付成功！");
					window.location.replace("${pageContext.request.contextPath}/daili_chongzhi.do?p=chongzhilisting");
				}else{
					
				}				
			},
			error:function()
			{
			   alert(122)
			}
		}); 
		
	}
	// window.setTimeout("panduan()", 1000);
	 var t = window.setInterval("panduan()", 5000);
</script> 

</html>
