<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
request.getSession().setAttribute("page", 0);
System.out.println("wap登录");
%>
<!DOCTYPE html>
<html>

	<head>  
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">

		<title>登陆</title>
		<script src="${pageContext.request.contextPath}/weixin/js/mui.min.js"></script>
		<script src="${pageContext.request.contextPath}/weixin/js/jquery-1.9.0.min.js"></script>
		<link href="${pageContext.request.contextPath}/weixin/css/mui.min.css" rel="stylesheet" />
		<link href="loginapp.css" rel="stylesheet" />
		<script src="${pageContext.request.contextPath}/weixin/layer/layer.js"></script>
		

	</head>

	<body>

		<header class="mui-bar mui-bar-nav" style="background-color: #FF7900;">
			<a style="color: white;" class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left jiantou" style="background-color: #FF7900;"></a>
			<h1 style="color: white;" class="mui-title">归真太极养生</h1>
		</header>

		<div class="mui-content">

			<div class="top3">
				<div class="mui-input-row">
					<input type="text" class="mui-input-clear ren" placeholder="请输入您的手机号/邮箱 " id="txtUserName">
				</div>

				<div class="mui-input-row">
					<input type="password" class="mui-input-clear ren1" placeholder="请输入您的密码" id="txtPassWord">
				</div>
			</div>

			<button class="top" id="btnlogin">登 录</button>
			<div class="top456">
				<div class="wangjimima" id="wangjimima">忘记密码?</div>
				<div class="top5">|</div>
				<div class="top6" id="zhuce">新用户注册</div>
			</div>

		</div>
	</body>

	<script type="text/javascript" charset="utf-8">
		mui.init({
			beforeback: function() {
				/*var list = plus.webview.currentWebview().opener();
				mui.fire(list, 'refresh');
				return true;*/
			}
		});
		$("#zhuce").click(function() {
			window.top.location  = "${pageContext.request.contextPath}/weixin/home/zhuce.jsp";
		});
		$("#wangjimima").click(function() {
			window.top.location  = "${pageContext.request.contextPath}/weixin/home/forgetpws.jsp";
		});
		$("#btnlogin").click(function() {
			document.getElementById("btnlogin").disabled = true;
			document.getElementById("btnlogin").innerHTML = "正在登陆..."
			var username = document.getElementById("txtUserName").value;
			var userpwd = document.getElementById("txtPassWord").value;
			mui.ajax("${pageContext.request.contextPath}/wapUser.do?p=login", {

					data: {
						username: username,
						userpwd: userpwd
					},
					type: 'post',
					timeout: 3000,
					success: function(data) {
						if(data == "请先登录") {
							mui.toast("用户名或密码错误");
							document.getElementById("btnlogin").disabled = false;
							document.getElementById("btnlogin").innerHTML = "登  录"
						} else {
							document.getElementById("btnlogin").disabled = true;
							var user = eval("(" + data + ")");
							if(user.usersId != null && user.usersId != "") {
								window.top.location = "${pageContext.request.contextPath}/weixin/center.jsp";
								mui.toast("登录成功");
							}
						}

					},
					error: function(xhr, type, errorThrown) {
						document.getElementById("btnlogin").disabled = false;
							document.getElementById("btnlogin").innerHTML = "登  录"
						//异常处理；
						if(type == 'timeout') {
							layer.open({
								content: '<div style="height:100%;width:100%"><div><img src="${pageContext.request.contextPath}/weixin/images/jnweb-kulian.png" width="30px" height="30px" style="margin-top:-10px"/></div>服务器开了小差，请求超时了</div>',
								time: 2
							});
							//$(".hidden_div2").show();
							//mui('#pullrefresh').pullRefresh().endPullupToRefresh(true);
							return;
						}
						if(type == 'abort') {
							layer.open({
								content: '<div style="height:100%;width:100%"><div><img src="${pageContext.request.contextPath}/weixin/images/jnweb-kulian.png" width="30px" height="30px" style="margin-top:-10px"/></div>亲，您的网络有点问题哦！</div>',
								time: 2
							});
							//$(".hidden_div2").show();
							//mui('#pullrefresh').pullRefresh().endPullupToRefresh(true);
							return;
						} else {
							layer.open({
								content: '<div style="height:100%;width:100%"><div><img src="${pageContext.request.contextPath}/weixin/images/jnweb-kulian.png" width="30px" height="30px" style="margin-top:-10px"/></div>服务器拒绝了连接，稍后再试吧！</div>',
								time: 2
							});
							//$(".hidden_div2").show();
							//mui('#pullrefresh').pullRefresh().endPullupToRefresh(true);
							return;
						}
					}

				}

			);
		});
	</script>

</html>