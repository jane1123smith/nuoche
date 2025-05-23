<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<html>
	<head>


		<meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
		<!--<meta content="width=devicnnjnjnjne-width,height=device-height,inital-scale=1.0,maximum-scale=1.0,user-scalable=no;" name="viewport">-->
		<meta content="yes" name="apple-mobile-web-app-capable">
		<meta content="black" name="apple-mobile-web-app-status-bar-style">
		<meta content="telephone=no" name="format-detection">
		<meta charset="utf-8">
		<meta name="description" content="" />
		<!--网站描述-->
		<meta name="keywords" content="" />
		<!--网站关键字-->
		<meta name="viewport"
			content="width=device-width, initial-scale=1, minimum-scale=1.0,maximum-scale=1.0" />
		<!--width - viewport的宽度 height - viewport的高度
initial-scale - 初始的缩放比例
minimum-scale - 允许用户缩放到的最小比例
maximum-scale - 允许用户缩放到的最大比例
user-scalable - 用户是否可以手动缩放-->
		<!--标准mui.css-->
		<link rel="stylesheet"
			href="${pageContext.request.contextPath }/weixin/css/mui.min.css">
		<!--App自定义的css-->
		<link rel="stylesheet" type="text/css"
			href="${pageContext.request.contextPath }/weixin/css/app.css" />
		<link href="${pageContext.request.contextPath }/weixin/css/css.css"
			rel="stylesheet" type="text/css">
		<link href="${pageContext.request.contextPath }/weixin/css/style.css"
			rel="stylesheet" type="text/css">
		<link
			href="${pageContext.request.contextPath }/weixin/css/font-awesome.min.css"
			rel="stylesheet" type="text/css">
		<link
			href="${pageContext.request.contextPath }/weixin/css/font-awesome.css"
			rel="stylesheet" type="text/css">
		<link href="${pageContext.request.contextPath }/weixin/css/css.css" rel="stylesheet" type="text/css">

		<script type="text/javascript"
			src="${pageContext.request.contextPath }/weixin/js/jquery-2.1.3.min.js"></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath }/weixin/js/jquery.form.js"></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath }/weixin/js/popwin.js"></script>

		<title>卡卡挪车</title>

		<style type="text/css">
body {
	padding: 0 0 10px 0;
	height: 100%;
	box-sizing: border-box;
	overflow: visible;
}

.topA {
	position: fixed;
	border-bottom: 1px solid #eee;
	z-index: 100;
}
.xg{

margin-right: -55px;
}
.weifukuan{
margin-right: -55px;
}
#beizhu{
  	word-wrap: break-word;
  	word-break: break-all;
 	overflow: hidden;
 	white-space: normal;
}
</style>

	</head>


	<body>
		<input type="hidden" id="pathnuoche"
			value="${pageContext.request.contextPath }">

		<div id="segmentedControl" class="EvaCT"
			style="position: fixed; top: 0; left: 0; z-index: 100;">
			<a href="#" onclick="list(this,-1)" class="EvaCTb">所有预约</a>
			<a href="#" onclick="list(this,1)" class="EvaCTb">未服务</a>
			<a href="#" onclick="list(this,2)" class="EvaCTb">已服务</a>
			<a href="#" onclick="list(this,3)" class="EvaCTb">服务管理</a>

		</div>

		<div id="pullrefresh" class="mui-content mui-scroll-wrapper"
			style="margin-top: 40px;">
			<div class="mui-scroll">
				<ul id="yuyueRecordList"
					class="mui-table-view mui-table-view-striped mui-table-view-condensed mui-table-view-chevron">

				</ul>
				<ul id="yuyueRecordList0"
					class="mui-table-view mui-table-view-striped mui-table-view-condensed mui-table-view-chevron">
				</ul>
				<ul id="yuyueRecordList2"
					class="mui-table-view mui-table-view-striped mui-table-view-condensed mui-table-view-chevron">
				</ul>
				<ul id="yuyueRecordList3"
					class="mui-table-view mui-table-view-striped mui-table-view-condensed mui-table-view-chevron">
				</ul>
			</div>
		</div>
		</div>





		<input type="hidden" id="pageAt" value="1" />
		<input type="hidden" id="status" value="" />
		<input type="hidden" id="getAction" value="-1" />
		<input type="hidden" id="getPage" value="${page }" />
		<input type="hidden" id="getCount" value="${count }" />
		<input type="hidden" id="trueOrFalse" value="false" />

		<!-- 确认 弹窗 -->
		<div class="pop" id="checkWin" style="display: none;">
			<div class="popC">
				<div class="pop_tit">
					操作确认
				</div>
				<div class="popCC">
					<strong id="checkMsgTip"></strong>
				</div>
				<div class="popBut">
					<a onclick="hidePopWin()">取 消</a>
					<a id="btnCheck" class="butRed">确 认</a>
				</div>
			</div>
		</div>

		<!-- 提示 弹窗 -->
		<div class="pop" id="msgWin" style="display: none;">
			<div class="popC">
				<div class="pop_tit">
					操作提示
				</div>
				<div class="popCC">
					<strong id="msgTip">提示语</strong>
				</div>
				<div class="popBut">
					<a onclick="hidePopWin()" class="butRed">确 定</a>
				</div>
			</div>
		</div>

		<!-- loading 弹窗 -->
		<div class="pop" id="loadingWin" style="display: none;">
			<div class="popC">
				<div class="popCC">
					<strong id="loadingMsg"></strong>
				</div>
			</div>
		</div>

		



		<script type="text/javascript"
			src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath }/weixin/js/mui.min.js"></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath }/weixin/js/mui.pullToRefresh.js"></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath }/weixin/js/mui.pullToRefresh.material.js"></script>




		<script type="text/javascript">
		
		$(document).ready(function(){
		list(this,-1);
	});
	</script>

		<script>
			var page=$('#getPage').val();
			var jsons = null;	
			var isTrue = false;
			
			mui.init({
				pullRefresh: {
					container: '#pullrefresh',
					down: {
						height:50,//可选,默认50.触发下拉刷新拖动距离,
      					auto: false,//可选,默认false.首次加载自动下拉刷新一次
						contentdown : "下拉可以刷新",//可选，在下拉可刷新状态时，下拉刷新控件上显示的标题内容
     			 		contentover : "释放立即刷新",//可选，在释放可刷新状态时，下拉刷新控件上显示的标题内容
      					contentrefresh : "正在刷新...",//可选，正在刷新状态时，下拉刷新控件上显示的标题内容
						//contentrefresh: '正在刷新...',
						callback: pulldownRefresh
					},
					up: {
						height:50,		// 可选.默认50.触发上拉加载拖动距离
            			auto:false,		// 可选,默认false.自动上拉加载一次
						contentrefresh : "正在加载...",		// 可选，正在加载状态时，上拉加载控件上显示的标题内容
            			contentnomore:'没有更多数据了',			// 可选，请求完毕若没有更多数据时显示的提醒内容；
						callback: pullupRefresh
					}
				}
			});
	

			/**
			 * 下拉刷新具体业务实现
			 */
			function pulldownRefresh() {
				setTimeout(function() {
				if($('#trueOrFalse').val()=='true')
				{
					//mui('#pullrefresh').pullRefresh().endPulldown();
					$('#trueOrFalse').val('false');
					mui('#pullrefresh').pullRefresh().endPulldownToRefresh();//开启下拉刷新
					mui('#pullrefresh').pullRefresh().refresh(true);		//重置上拉加载下拉刷新
					mui('#pullrefresh').pullRefresh().endPullupToRefresh(false);	//开启上拉加载
					//mui('#pullrefresh').pullRefresh().pullupLoading();    //自动上拉加载一次
					}
				var action=$('#getAction').val();
				if(action==1)
				{
					var status = 1;
					var url = "${pageContext.request.contextPath}/sjyuyuerecord.do?method=findByStatus&page=1";
					page=1;
					$('#getPage').val(1);
					var param = {status : status};
					
					$.post(url, param, function(data) {
					jsons = eval("(" + data + ")");
					json = jsons.yuyuerecords;
					//alert(json[0].time);  
					if (json.length == 0) 
					{ //当数据为空
						$("#yuyueRecordList0").html('<li class="payBX"><img src="${pageContext.request.contextPath}/weixin/images/NoData.png" style="width: 100px; display: block; margin: 0 auto; padding: 20px 0;"/></li>');
					} 
					else 
					{
						// 清空列表
						$("#yuyueRecordList0").empty();
						for (var i = 0; i < json.length; i++) {
							var m = '<li class="mui-table-view-cell">';
							m = m + '<div class="mui-table">';
							m = m + '<div class="mui-table-cell mui-text-left mui-col-xs-8" style="height: 20px;">';
							m = m + '<h5 class="mui-ellipsis">服务名称：'+json[i].service.title+'&nbsp;</h5>';
							m = m + '</div>';
							m = m + '<div class="mui-table-cell mui-col-xs-4 mui-text-right">';		
							m = m + '<span class="mui-h5">';
							if (json[i].status == 0){
							m = m + '<span class="weifukuan" style="margin-right: -55px;" >未付款</span>';
							}	
							if (json[i].status == 1){
							m = m + '<a id="'+json[i].id+'" class="xg"  title="修改状态"><button class="label label-defaunt radius">未服务</button></a>';
							}
							if (json[i].status == 2){
							m = m + '<a  id="'+json[i].id+'" class="xg"  title="修改状态"><button class="label label-success radius">已服务</button></a>';
							}		
							m = m + '</span></div></div></li>';					
							m = m + '<li class="mui-table-view-cell">';				
							m = m + '<div class="mui-table">';					
							m = m + '<div class="mui-table-cell mui-text-left">';	
							m = m + '<p class="mui-h6 mui-ellipsis">商家：'+json[i].service.business.shopname+'</p>';		
							m = m + '<p class="mui-h6 mui-ellipsis">时间：'+json[i].created+'</p>';				
							m = m + '<p class="mui-h6 mui-ellipsis">金额：'+json[i].pay+'元</p>';
							m = m + '<p class="mui-h6 mui-ellipsis">昵称：'+json[i].user.nickname+'</p>';					
							m = m + '<p class="mui-h6 mui-ellipsis">电话：'+json[i].user.wxtel+'</p>';
							m = m + '<p class="mui-h6 mui-ellipsis" id="beizhu">备注：'+json[i].buyerComment+'';
							m = m + '</div>';
							m = m + '</div></li><hr />';
							
							
											
							$("#yuyueRecordList0").append(m);
						} 
					}
				});
					
				}else if(action==2)
				{
					var status = 2;
					var url = "${pageContext.request.contextPath}/sjyuyuerecord.do?method=findByStatus&page=1";
					page=1;
					$('#getPage').val(1);
					var param = {status : status};
					
					$.post(url, param, function(data) {
					jsons = eval("(" + data + ")");
					json = jsons.yuyuerecords;
					//alert(json[0].time);  
					if (json.length == 0) { //当数据为空
						$("#yuyueRecordList2").html('<li class="payBX"><img src="${pageContext.request.contextPath}/weixin/images/NoData.png" style="width: 100px; display: block; margin: 0 auto; padding: 20px 0;"/></li>');
					} else {
						// 清空列表
						$("#yuyueRecordList2").empty();
						for (var i = 0; i < json.length; i++) {
							var m = '<li class="mui-table-view-cell">';
							m = m + '<div class="mui-table">';
							m = m + '<div class="mui-table-cell mui-text-left mui-col-xs-8" style="height: 20px;">';
							m = m + '<h5 class="mui-ellipsis">服务名称：'+json[i].service.title+'&nbsp;</h5>';
							m = m + '</div>';
							m = m + '<div class="mui-table-cell mui-col-xs-4 mui-text-right">';		
							m = m + '<span class="mui-h5">';	
							if (json[i].status == 0){
							m = m + '<span class="weifukuan" style="margin-right: -55px;" >未付款</span>';
							}
							if (json[i].status == 1){
							m = m + '<a id="'+json[i].id+'" class="xg"  title="修改状态"><button class="label label-defaunt radius">未服务</button></a>';
							}
							if (json[i].status == 2){
							m = m + '<a  id="'+json[i].id+'" class="xg"  title="修改状态"><button class="label label-success radius">已服务</button></a>';
							}
							m = m + '</span></div></div></li>';					
							m = m + '<li class="mui-table-view-cell">';				
							m = m + '<div class="mui-table">';					
							m = m + '<div class="mui-table-cell mui-text-left">';
							m = m + '<p class="mui-h6 mui-ellipsis">商家：'+json[i].service.business.shopname+'</p>';			
							m = m + '<p class="mui-h6 mui-ellipsis">时间：'+json[i].created+'</p>';				
							m = m + '<p class="mui-h6 mui-ellipsis">金额：'+json[i].pay+'元</p>';
							m = m + '<p class="mui-h6 mui-ellipsis">昵称：'+json[i].user.nickname+'</p>';					
							m = m + '<p class="mui-h6 mui-ellipsis">电话：'+json[i].user.wxtel+'</p>';
							m = m + '<p class="mui-h6 mui-ellipsis" id="beizhu">备注：'+json[i].buyerComment+'';
							m = m + '</div>';	
						
							m = m + '</div></li><hr />';				
							$("#yuyueRecordList2").append(m);
						} 
					}
				});
					
				}
				else if(action == 3){
					page = 1;	
					$('#getPage').val(1);	
					var url = "${pageContext.request.contextPath}/sjyuyueservice.do?p=servicelist&page=1";
					var param = {};
					$.post(url, param, function(data) {
						jsons = eval("(" + data + ")");
						json = jsons.servicelist;
						if (json.length == 0) { //当数据为空
							$("#yuyueRecordList3").html('<li class="payBX"><img src="${pageContext.request.contextPath}/weixin/images/NoData.png" style="width: 100px; display: block; margin: 0 auto; padding: 20px 0;"/><button onclick="subEdit()" class="butA butBlue" style="margin-top: 0;font-size:20px;line-height:30px">新 增 服 务</button></li>');
						} else {
							// 清空列表
							$("#yuyueRecordList3").empty();
							$("#yuyueRecordList3").html('<button onclick="subEdit()" class="butA butBlue" style="margin-top: 0;font-size:20px;line-height:30px">新 增 服 务</button>');	
							for (var i = 0; i < json.length; i++) {
								var m = '<li class="mui-table-view-cell">';
								m = m + '<div class="mui-table">';
								m = m + '<div class="mui-table-cell mui-text-left mui-col-xs-8" style="height: 20px;">';
								m = m + '<h5 class="mui-ellipsis">服务名称：'+json[i].title+'&nbsp;</h5>';
								m = m + '</div>';
								m = m + '<div class="mui-table-cell mui-col-xs-4 mui-text-right">';		
								m = m + '<span class="mui-h5">';
								if (json[i].status == 0){
								m = m + '<a id="'+json[i].id+'" class="xg"  title="修改状态"><button class="label label-defaunt radius">下架</button></a>';
								}
								if (json[i].status == 1){
								m = m + '<a  id="'+json[i].id+'" class="xg"  title="修改状态"><button class="label label-success radius">上架</button></a>';
								}
								m = m + '</span></div></div></li>';					
								m = m + '<li class="mui-table-view-cell">';				
								m = m + '<div class="mui-table">';					
								m = m + '<div class="mui-table-cell mui-text-left">';
								m = m + '<img style="width: 80px; height: 80px;" class="mui-media-object mui-pull-left" src="${pageContext.request.contextPath}/'+json[i].image+'" />'
								m = m + '<p class="mui-h6 mui-ellipsis">服务类型：'+json[i].serviceType.name+'</p>';				
								m = m + '<p class="mui-h6 mui-ellipsis">市场价格：'+json[i].shichangPrice+'元</p>';				
								m = m + '<p class="mui-h6 mui-ellipsis">预约价格：'+json[i].yuyuePrice+'元</p>';
								m = m + '<p class="mui-h6 mui-ellipsis">服务所需时间：'+json[i].time+'分钟</p>';
								m = m + '</div>';	
								m = m + '<div class="mui-table-cell mui-col-xs-4 mui-text-right" >';		
								m = m + '<span class="mui-h5">';
								m = m + '<span class="xg"><button class="label label-defaunt radius" onclick="gotoedit('+json[i].id+')">编辑</button></span>';
								m = m + '</span></div>';		 
								m = m + '</div></li><hr />';				
								$("#yuyueRecordList3").append(m);
							} 
						}
					});
				}
				else
				{
					page = 1;	
					$('#getPage').val(1);	
					var url = "${pageContext.request.contextPath}/sjyuyuerecord.do?method=findAll&openid=${openid}&page=1";
					var param = {};
					$.post(url, param, function(data) {
						jsons = eval("(" + data + ")");
						json = jsons.yuyuerecords;
						//alert(json[0].time);  
						if (json.length == 0) { //当数据为空
							$("#yuyueRecordList").html('<li class="payBX"><img src="${pageContext.request.contextPath}/weixin/images/NoData.png" style="width: 100px; display: block; margin: 0 auto; padding: 20px 0;"/></li>');
						} else {
							// 清空列表
							$("#yuyueRecordList").empty();
							for (var i = 0; i < json.length; i++) {
								var m = '<li class="mui-table-view-cell">';
								m = m + '<div class="mui-table">';
								m = m + '<div class="mui-table-cell mui-text-left mui-col-xs-8" style="height: 20px;">';
								m = m + '<h5 class="mui-ellipsis">服务名称：'+json[i].service.title+'&nbsp;</h5>';
								m = m + '</div>';
								m = m + '<div class="mui-table-cell mui-col-xs-4 mui-text-right">';		
								m = m + '<span class="mui-h5">';	
								if (json[i].status == 0){
								m = m + '<span class="weifukuan" style="margin-right: -55px;" >未付款</span>';
								}
								if (json[i].status == 1){
								m = m + '<a id="'+json[i].id+'" class="xg"  title="修改状态"><button class="label label-defaunt radius">未服务</button></a>';
								}
								if (json[i].status == 2){
								m = m + '<a  id="'+json[i].id+'" class="xg"  title="修改状态"><button class="label label-success radius">已服务</button></a>';
								}
								m = m + '</span></div></div></li>';					
								m = m + '<li class="mui-table-view-cell">';				
								m = m + '<div class="mui-table">';					
								m = m + '<div class="mui-table-cell mui-text-left">';	
								m = m + '<p class="mui-h6 mui-ellipsis">商家：'+json[i].service.business.shopname+'</p>';		
								m = m + '<p class="mui-h6 mui-ellipsis">时间：'+json[i].created+'</p>';				
								m = m + '<p class="mui-h6 mui-ellipsis">金额：'+json[i].pay+'元</p>';
								m = m + '<p class="mui-h6 mui-ellipsis">昵称：'+json[i].user.nickname+'</p>';					
								m = m + '<p class="mui-h6 mui-ellipsis">电话：'+json[i].user.wxtel+'</p>';
								m = m + '<p class="mui-h6 mui-ellipsis" id="beizhu">备注：'+json[i].buyerComment+'';
								m = m + '</div>';	
								m = m + '</div></li><hr />';				
								$("#yuyueRecordList").append(m);
							} 
						}
					});
				}
				
						
						//li.innerHTML = '<a class="mui-navigate-right">Item ' + (i + 1) + '</a>';
						//下拉刷新，新纪录插到最前面；
						//table.insertBefore(li, table.firstChild);
					
					mui('#pullrefresh').pullRefresh().endPulldownToRefresh(); 
				
				}, 1500);
			}
			
		
			/**
			 * 上拉加载具体业务实现
			 */
			function pullupRefresh() 
			{
				setTimeout(function() {
				//alert($('#getAction').val());
				var table = document.body.querySelector('#yuyueRecordList');
				var cells = document.body.querySelectorAll('.movecardetail_li');
				
				
				var action=$('#getAction').val();
				if(action==1){
					isTrue = ($('#getPage').val() >= jsons.count);
					$('#trueOrFalse').val(isTrue);
					//alert(isTrue);
					mui('#pullrefresh').pullRefresh().endPullupToRefresh(isTrue); //参数为true代表没有更多数据了。
					
					//alert($('#getPage').val());
					var status = 1;
					page = $('#getPage').val()*1+1;
					$('#getPage').val(page);
					var url = "${pageContext.request.contextPath}/sjyuyuerecord.do?method=findByStatus&page="+page;
					param = {status : status, page : page};
					
					$.post(url, param, function(data) {
				    //alert(data);
					var jsons = eval("(" + data + ")");
					var json = jsons.yuyuerecords;
					//alert(cells.length);  
					if (jsons.sum == 0) { //当数据为空
						$("#yuyueRecordList0").html('<li class="payBX"><img src="${pageContext.request.contextPath}/weixin/images/NoData.png" style="width: 100px; display: block; margin: 0 auto; padding: 20px 0;"/></li>');
						mui('#pullrefresh').pullRefresh().endPullupToRefresh(true);
						$('#trueOrFalse').val('true');
					} else {
						for (var i = 0; i < json.length; i++) {
							var m = '<li class="mui-table-view-cell">';
							m = m + '<div class="mui-table">';
							m = m + '<div class="mui-table-cell mui-text-left mui-col-xs-8" style="height: 20px;">';
							m = m + '<h5 class="mui-ellipsis">服务名称：'+json[i].service.title+'&nbsp;</h5>';
							m = m + '</div>';
							m = m + '<div class="mui-table-cell mui-col-xs-4 mui-text-right">';		
							m = m + '<span class="mui-h5">';	
							if (json[i].status == 0){
							m = m + '<span class="weifukuan" style="margin-right: -55px;" >未付款</span>';
							}
							if (json[i].status == 1){
							m = m + '<a id="'+json[i].id+'" class="xg"  title="修改状态"><button class="label label-defaunt radius">未服务</button></a>';
							}
							if (json[i].status == 2){
							m = m + '<a  id="'+json[i].id+'" class="xg"  title="修改状态"><button class="label label-success radius">已服务</button></a>';
							}
							m = m + '</span></div></div></li>';					
							m = m + '<li class="mui-table-view-cell">';				
							m = m + '<div class="mui-table">';					
							m = m + '<div class="mui-table-cell mui-text-left">';
							m = m + '<p class="mui-h6 mui-ellipsis">商家：'+json[i].service.business.shopname+'</p>';			
							m = m + '<p class="mui-h6 mui-ellipsis">时间：'+json[i].created+'</p>';				
							m = m + '<p class="mui-h6 mui-ellipsis">金额：'+json[i].pay+'元</p>';
							m = m + '<p class="mui-h6 mui-ellipsis">昵称：'+json[i].user.nickname+'</p>';					
							m = m + '<p class="mui-h6 mui-ellipsis">电话：'+json[i].user.wxtel+'</p>';
							m = m + '<p class="mui-h6 mui-ellipsis" id="beizhu">备注：'+json[i].buyerComment+'';
							m = m + '</div>';	
							m = m + '</div></li><hr />';				
							$("#yuyueRecordList0").append(m);
						}
					}
				});
				
				}else if(action==2){
					isTrue = ($('#getPage').val() >= jsons.count);
					$('#trueOrFalse').val(isTrue);
					//alert(isTrue);
					mui('#pullrefresh').pullRefresh().endPullupToRefresh(isTrue); //参数为true代表没有更多数据了。
					//mui('#pullrefresh').pullRefresh().endPullupToRefresh(($('#getPage').val() >= jsons.count)); //参数为true代表没有更多数据了。
					var status = 2;
					page = $('#getPage').val()*1+1;
					$('#getPage').val(page);
					var url = "${pageContext.request.contextPath}/sjyuyuerecord.do?method=findByStatus&page="+page;
					param = {status : status, page : page};
					
					$.post(url, param, function(data) {
					    //alert(data);
						var jsons = eval("(" + data + ")");
						var json = jsons.yuyuerecords;
						//alert(cells.length);  
						if (jsons.sum == 0) { //当数据为空
							$("#yuyueRecordList2").html('<li class="payBX"><img src="${pageContext.request.contextPath}/weixin/images/NoData.png" style="width: 100px; display: block; margin: 0 auto; padding: 20px 0;"/></li>');
						} else {
							for (var i = 0; i < json.length; i++) {
								var m = '<li class="mui-table-view-cell">';
								m = m + '<div class="mui-table">';
								m = m + '<div class="mui-table-cell mui-text-left mui-col-xs-8" style="height: 20px;">';
								m = m + '<h5 class="mui-ellipsis">服务名称：'+json[i].service.title+'&nbsp;</h5>';
								m = m + '</div>';
								m = m + '<div class="mui-table-cell mui-col-xs-4 mui-text-right">';		
								m = m + '<span class="mui-h5">';	
								if (json[i].status == 0){
								m = m + '<span class="weifukuan" style="margin-right: -55px;" >未付款</span>';
								}
								if (json[i].status == 1){
								m = m + '<a id="'+json[i].id+'" class="xg"  title="修改状态"><button class="label label-defaunt radius">未服务</button></a>';
								}
								if (json[i].status == 2){
								m = m + '<a  id="'+json[i].id+'" class="xg"  title="修改状态"><button class="label label-success radius">已服务</button></a>';
								}
								m = m + '</span></div></div></li>';					
								m = m + '<li class="mui-table-view-cell">';				
								m = m + '<div class="mui-table">';					
								m = m + '<div class="mui-table-cell mui-text-left">';	
								m = m + '<p class="mui-h6 mui-ellipsis">商家：'+json[i].service.business.shopname+'</p>';		
								m = m + '<p class="mui-h6 mui-ellipsis">时间：'+json[i].created+'</p>';				
								m = m + '<p class="mui-h6 mui-ellipsis">金额：'+json[i].pay+'元</p>';
								m = m + '<p class="mui-h6 mui-ellipsis">昵称：'+json[i].user.nickname+'</p>';					
								m = m + '<p class="mui-h6 mui-ellipsis">电话：'+json[i].user.wxtel+'</p>';
								m = m + '<p class="mui-h6 mui-ellipsis" id="beizhu">备注：'+json[i].buyerComment+'';
								m = m + '</div>';	
								m = m + '</div></li><hr />';				
								$("#yuyueRecordList2").append(m);
							}
						}
					});
				}
				else if(action==3){
					isTrue = ($('#getPage').val() >= jsons.count);
					$('#trueOrFalse').val(isTrue);
					//alert(isTrue);
					mui('#pullrefresh').pullRefresh().endPullupToRefresh(isTrue); //参数为true代表没有更多数据了。
					page = $('#getPage').val()*1+1;
					$('#getPage').val(page);
					var url = "${pageContext.request.contextPath}/sjyuyueservice.do?p=servicelist&openid=${openid}&page="+page;
					param = {page:page};
					
					$.post(url, param, function(data) {
					    //alert(data);
						var jsons = eval("(" + data + ")");
						var json = jsons.servicelist;
						//alert(cells.length);  
						if (jsons.sum == 0) { //当数据为空
							$("#yuyueRecordList3").html('<li class="payBX"><img src="${pageContext.request.contextPath}/weixin/images/NoData.png" style="width: 100px; display: block; margin: 0 auto; padding: 20px 0;"/><button onclick="subEdit()" class="butA butBlue" style="margin-top: 0;font-size:20px;line-height:30px">新 增 服 务</button></li>');
						} else {
							for (var i = 0; i < json.length; i++) {
								var m = '<li class="mui-table-view-cell">';
								m = m + '<div class="mui-table">';
								m = m + '<div class="mui-table-cell mui-text-left mui-col-xs-8" style="height: 20px;">';
								m = m + '<h5 class="mui-ellipsis">服务名称：'+json[i].title+'&nbsp;</h5>';
								m = m + '</div>';
								m = m + '<div class="mui-table-cell mui-col-xs-4 mui-text-right">';		
								m = m + '<span class="mui-h5">';
								if (json[i].status == 0){
								m = m + '<a id="'+json[i].id+'" class="xg"  title="修改状态"><button class="label label-defaunt radius">下架</button></a>';
								}
								if (json[i].status == 1){
								m = m + '<a  id="'+json[i].id+'" class="xg"  title="修改状态"><button class="label label-success radius">上架</button></a>';
								}
								m = m + '</span></div></div></li>';					
								m = m + '<li class="mui-table-view-cell">';				
								m = m + '<div class="mui-table">';					
								m = m + '<div class="mui-table-cell mui-text-left">';
								m = m + '<img style="width: 80px; height: 80px;" class="mui-media-object mui-pull-left" src="${pageContext.request.contextPath}/'+json[i].image+'" />'
								m = m + '<p class="mui-h6 mui-ellipsis">服务类型：'+json[i].serviceType.name+'</p>';				
								m = m + '<p class="mui-h6 mui-ellipsis">市场价格：'+json[i].shichangPrice+'元</p>';				
								m = m + '<p class="mui-h6 mui-ellipsis">预约价格：'+json[i].yuyuePrice+'元</p>';
								m = m + '<p class="mui-h6 mui-ellipsis">服务所需时间：'+json[i].time+'分钟</p>';
								m = m + '</div>';	
								m = m + '<div class="mui-table-cell mui-col-xs-4 mui-text-right" >';		
								m = m + '<span class="mui-h5">';
								m = m + '<span class="xg"><button class="label label-defaunt radius" onclick="gotoedit('+json[i].id+')">编辑</button></span>';
								m = m + '</span></div>';		 
								m = m + '</div></li><hr />';				
								$("#yuyueRecordList3").append(m);
							}
						}
					});
				}
				else{
					isTrue = ($('#getPage').val() >= jsons.count);
					$('#trueOrFalse').val(isTrue);
					//alert(isTrue);
					mui('#pullrefresh').pullRefresh().endPullupToRefresh(isTrue); //参数为true代表没有更多数据了。
					page = $('#getPage').val()*1+1;
					$('#getPage').val(page);
					var url = "${pageContext.request.contextPath}/sjyuyuerecord.do?method=findAll&openid=${openid}&page="+page;
					param = {page:page};
					
					$.post(url, param, function(data) {
				    //alert(data);
					var jsons = eval("(" + data + ")");
					var json = jsons.yuyuerecords;
					//alert(cells.length);  
					if (jsons.sum == 0) { //当数据为空
						$("#yuyueRecordList").html('<li class="payBX"><img src="${pageContext.request.contextPath}/weixin/images/NoData.png" style="width: 100px; display: block; margin: 0 auto; padding: 20px 0;"/></li>');
					} else {
						for (var i = 0; i < json.length; i++) {
							var m = '<li class="mui-table-view-cell">';
							m = m + '<div class="mui-table">';
							m = m + '<div class="mui-table-cell mui-text-left mui-col-xs-8" style="height: 20px;">';
							m = m + '<h5 class="mui-ellipsis">服务名称：'+json[i].service.title+'&nbsp;</h5>';
							m = m + '</div>';
							m = m + '<div class="mui-table-cell mui-col-xs-4 mui-text-right">';		
							m = m + '<span class="mui-h5">';	
							if (json[i].status == 0){
							m = m + '<span class="weifukuan" style="margin-right: -55px;" >未付款</span>';
							}
							if (json[i].status == 1){
							m = m + '<a id="'+json[i].id+'" class="xg"  title="修改状态"><button class="label label-defaunt radius">未服务</button></a>';
							}
							if (json[i].status == 2){
							m = m + '<a  id="'+json[i].id+'" class="xg"  title="修改状态"><button class="label label-success radius">已服务</button></a>';
							}
							m = m + '</span></div></div></li>';					
							m = m + '<li class="mui-table-view-cell">';				
							m = m + '<div class="mui-table">';					
							m = m + '<div class="mui-table-cell mui-text-left">';	
							m = m + '<p class="mui-h6 mui-ellipsis">商家：'+json[i].service.business.shopname+'</p>';		
							m = m + '<p class="mui-h6 mui-ellipsis">时间：'+json[i].created+'</p>';				
							m = m + '<p class="mui-h6 mui-ellipsis">金额：'+json[i].pay+'元</p>';
							m = m + '<p class="mui-h6 mui-ellipsis">昵称：'+json[i].user.nickname+'</p>';					
							m = m + '<p class="mui-h6 mui-ellipsis">电话：'+json[i].user.wxtel+'</p>';
							m = m + '<p class="mui-h6 mui-ellipsis" id="beizhu">备注：'+json[i].buyerComment+'';
							m = m + '</div>';	
							m = m + '</div></li><hr />';				
							$("#yuyueRecordList").append(m);
						}
					}
				});
				}
				
			
				
					
					
				}, 1500);
			}
			
			
			function list(alink, action) 
			{
			var pathnuoche = $("#pathnuoche").val();
			alink.className = "EvaCTa";
			$(alink).siblings().removeClass("EvaCTa").addClass("EvaCTb");
			if (action == -1) {
				$("#status").val("");
			} else {
				$("#status").val(action);
			}
			$("#pageAt").val("0");
			isAppend = 0;
			//  根据状态查询
			if (action == -1) {
				$('#yuyueRecordList').css("display","block");
				$('#yuyueRecordList0').css("display","none");
				$('#yuyueRecordList2').css("display","none");
				$('#yuyueRecordList3').css("display","none");
				//查全部
				if($('#trueOrFalse').val()=='true'){
			
				$('#trueOrFalse').val('false');
				mui('#pullrefresh').pullRefresh().endPulldownToRefresh();//开启下拉刷新
				mui('#pullrefresh').pullRefresh().refresh(true);		//重置上拉加载下拉刷新
				mui('#pullrefresh').pullRefresh().endPullupToRefresh(false);	//开启上拉加载
				
				}
				$('#getAction').val(-1);
				$('#getPage').val(1);
				var url = "${pageContext.request.contextPath}/sjyuyuerecord.do?method=findAll&page=1";
				
				var param = {};
				showPopWin(0, "正在处理，请稍候...");
				
				$.post(url, param, function(data) {
					hideLoading();
					jsons = eval("(" + data + ")");
					json = jsons.yuyuerecords;
					//alert(jsons.count);
					$('#getCount').val(jsons.count);
					//alert(json[0]);  
					if (json.length == 0) { //当数据为空
						$("#yuyueRecordList").html('<li class="payBX"><img src="${pageContext.request.contextPath}/weixin/images/NoData.png" style="width: 100px; display: block; margin: 0 auto; padding: 20px 0;"/></li>');
						mui('#pullrefresh').pullRefresh().endPullupToRefresh(true);
						$('#trueOrFalse').val('true');
					} else {
						// 清空列表
						$("#yuyueRecordList").empty();
						for (var i = 0; i < json.length; i++) {
							var m = '<li class="mui-table-view-cell">';
							m = m + '<div class="mui-table">';
							m = m + '<div class="mui-table-cell mui-text-left mui-col-xs-8" style="height: 20px;">';
							m = m + '<h5 class="mui-ellipsis">服务名称：'+json[i].service.title+'&nbsp;</h5>';
							m = m + '</div>';
							m = m + '<div class="mui-table-cell mui-col-xs-4 mui-text-right">';		
							m = m + '<span class="mui-h5">';	
							if (json[i].status == 0){
							m = m + '<span class="weifukuan" style="margin-right: -55px;" >未付款</span>';
							}
							if (json[i].status == 1){
							m = m + '<a id="'+json[i].id+'" class="xg"  title="修改状态"><button class="label label-defaunt radius">未服务</button></a>';
							}
							if (json[i].status == 2){
							m = m + '<a  id="'+json[i].id+'" class="xg"  title="修改状态"><button class="label label-success radius">已服务</button></a>';
							}	
							m = m + '</span></div></div></li>';					
							m = m + '<li class="mui-table-view-cell">';				
							m = m + '<div class="mui-table">';					
							m = m + '<div class="mui-table-cell mui-text-left">';	
							m = m + '<p class="mui-h6 mui-ellipsis">商家：'+json[i].service.business.shopname+'</p>';		
							m = m + '<p class="mui-h6 mui-ellipsis">时间：'+json[i].created+'</p>';				
							m = m + '<p class="mui-h6 mui-ellipsis">金额：'+json[i].pay+'元</p>';	
							m = m + '<p class="mui-h6 mui-ellipsis">昵称：'+json[i].user.nickname+'</p>';					
							m = m + '<p class="mui-h6 mui-ellipsis">电话：'+json[i].user.wxtel+'</p>';
							m = m + '<p class="mui-h6 mui-ellipsis" id="beizhu">备注：'+json[i].buyerComment+'';
							m = m + '</div>';	
						
							m = m + '</div></li><hr />';	
										
							$("#yuyueRecordList").append(m);
							
						
						}	
								//	alert(document.getElementById("yuyueRecordList").innerHTML);
								//alert($('#yuyueRecordList').html());		
					}
					
				});
	
				
				
			} 
			else if (action == 1) 
			{
				$('#yuyueRecordList0').css("display","block");
				$('#yuyueRecordList').css("display","none");
				$('#yuyueRecordList2').css("display","none");
				$('#yuyueRecordList3').css("display","none");
				if($('#trueOrFalse').val()=='true'){
				$('#trueOrFalse').val('false');
				mui('#pullrefresh').pullRefresh().endPulldownToRefresh();
				mui('#pullrefresh').pullRefresh().refresh(true);
				mui('#pullrefresh').pullRefresh().endPullupToRefresh(false);
				//mui('#pullrefresh').pullRefresh().pullupLoading();
				}
				// status = 1 表示未服务
				$('#getAction').val(1);
				$('#getPage').val(1);
				var status = 1;
				showPopWin(0, "正在处理，请稍候...");
				var url = "${pageContext.request.contextPath}/sjyuyuerecord.do?method=findByStatus&page=1";
				var param = {
					status : status
				};
				
				$.post(url, param, function(data) {
					hideLoading();
					jsons = eval("(" + data + ")");
					json = jsons.yuyuerecords;
					
					$('#getCount').val(jsons.count);
					//alert(json[0]);  
					if (json.length == 0) { //当数据为空
						$("#yuyueRecordList0").html('<li class="payBX"><img src="${pageContext.request.contextPath}/weixin/images/NoData.png" style="width: 100px; display: block; margin: 0 auto; padding: 20px 0;"/></li>');
						mui('#pullrefresh').pullRefresh().endPullupToRefresh(true);
						$('#trueOrFalse').val('true');
					} else {
					
						// 清空列表
						$("#yuyueRecordList0").empty();
						for (var i = 0; i < json.length; i++) {
							var m = '<li class="mui-table-view-cell">';
							m = m + '<div class="mui-table">';
							m = m + '<div class="mui-table-cell mui-text-left mui-col-xs-8" style="height: 20px;">';
							m = m + '<h5 class="mui-ellipsis">服务名称：'+json[i].service.title+'&nbsp;</h5>';
							m = m + '</div>';
							m = m + '<div class="mui-table-cell mui-col-xs-4 mui-text-right">';		
							m = m + '<span class="mui-h5">';	
							if (json[i].status == 0){
							m = m + '<span class="weifukuan" style="margin-right: -55px;" >未付款</span>';
							}
							if (json[i].status == 1){
							m = m + '<a id="'+json[i].id+'" class="xg"  title="修改状态"><button class="label label-defaunt radius">未服务</button></a>';
							}
							if (json[i].status == 2){
							m = m + '<a  id="'+json[i].id+'" class="xg"  title="修改状态"><button class="label label-success radius">已服务</button></a>';
							}
							m = m + '</span></div></div></li>';					
							m = m + '<li class="mui-table-view-cell">';				
							m = m + '<div class="mui-table">';					
							m = m + '<div class="mui-table-cell mui-text-left">';	
							m = m + '<p class="mui-h6 mui-ellipsis">商家：'+json[i].service.business.shopname+'</p>';		
							m = m + '<p class="mui-h6 mui-ellipsis">时间：'+json[i].created+'</p>';				
							m = m + '<p class="mui-h6 mui-ellipsis">金额：'+json[i].pay+'元</p>';
							m = m + '<p class="mui-h6 mui-ellipsis">昵称：'+json[i].user.nickname+'</p>';						
							m = m + '<p class="mui-h6 mui-ellipsis">电话：'+json[i].user.wxtel+'</p>';
							m = m + '<p class="mui-h6 mui-ellipsis" id="beizhu">备注：'+json[i].buyerComment+'';
							m = m + '</div>';	
						
							m = m + '</div></li><hr />';				
							$("#yuyueRecordList0").append(m);
							
						}
					}
				});
				
				
			} 
			else if (action == 2) {
				$('#yuyueRecordList2').css("display","block");
				$('#yuyueRecordList').css("display","none");
				$('#yuyueRecordList0').css("display","none");
				$('#yuyueRecordList3').css("display","none");
				if($('#trueOrFalse').val()=='true'){
					$('#trueOrFalse').val('false');
					mui('#pullrefresh').pullRefresh().endPulldownToRefresh();
					mui('#pullrefresh').pullRefresh().refresh(true);
					mui('#pullrefresh').pullRefresh().endPullupToRefresh(false);
					//mui('#pullrefresh').pullRefresh().pullupLoading();
				}
				//  status = 2表示 服务
				$('#getAction').val(2);
				$('#getPage').val(1);
				var status = 2;
				showPopWin(0, "正在处理，请稍候...");
				var url = "${pageContext.request.contextPath}/sjyuyuerecord.do?method=findByStatus&page=1";
				var param = {
					status : status
				};
				
				$.post(url, param, function(data) {
					hideLoading();
					jsons = eval("(" + data + ")");
					json = jsons.yuyuerecords;
					//alert(jsons.count);
					$('#getCount').val(jsons.count);
					//alert(json[0]);  
					if (json.length == 0) { //当数据为空
						$("#yuyueRecordList2").html('<li class="payBX"><img src="${pageContext.request.contextPath}/weixin/images/NoData.png" style="width: 100px; display: block; margin: 0 auto; padding: 20px 0;"/></li>');
						mui('#pullrefresh').pullRefresh().endPullupToRefresh(true);
						$('#trueOrFalse').val('true');
					} else {
						// 清空列表
						$("#yuyueRecordList2").empty();
						for (var i = 0; i < json.length; i++) {
							var m = '<li class="mui-table-view-cell">';
							m = m + '<div class="mui-table">';
							m = m + '<div class="mui-table-cell mui-text-left mui-col-xs-8" style="height: 20px;">';
							m = m + '<h5 class="mui-ellipsis">服务名称：'+json[i].service.title+'&nbsp;</h5>';
							m = m + '</div>';
							m = m + '<div class="mui-table-cell mui-col-xs-4 mui-text-right">';		
							m = m + '<span class="mui-h5">';	
							if (json[i].status == 0){
							m = m + '<span class="weifukuan" style="margin-right: -55px;" >未付款</span>';
							}
							if (json[i].status == 1){
							m = m + '<a id="'+json[i].id+'" class="xg"  title="修改状态"><button class="label label-defaunt radius">未服务</button></a>';
							}
							if (json[i].status == 2){
							m = m + '<a  id="'+json[i].id+'" class="xg"  title="修改状态"><button class="label label-success radius">已服务</button></a>';
							}
							m = m + '</span></div></div></li>';					
							m = m + '<li class="mui-table-view-cell">';				
							m = m + '<div class="mui-table">';					
							m = m + '<div class="mui-table-cell mui-text-left">';
							m = m + '<p class="mui-h6 mui-ellipsis">商家：'+json[i].service.business.shopname+'</p>';				
							m = m + '<p class="mui-h6 mui-ellipsis">时间：'+json[i].created+'</p>';				
							m = m + '<p class="mui-h6 mui-ellipsis">金额：'+json[i].pay+'元</p>';
							m = m + '<p class="mui-h6 mui-ellipsis">昵称：'+json[i].user.nickname+'</p>';
							m = m + '<p class="mui-h6 mui-ellipsis">电话：'+json[i].user.wxtel+'</p>';	
							m = m + '<p class="mui-h6 mui-ellipsis" id="beizhu">备注：'+json[i].buyerComment+'';					
							m = m + '</div>';	
							m = m + '</div></li><hr />';				
							$("#yuyueRecordList2").append(m);
						}
					}
				});
			}
			else if(action=3){
				$('#yuyueRecordList3').css("display","block");
				$('#yuyueRecordList2').css("display","none");
				$('#yuyueRecordList').css("display","none");
				$('#yuyueRecordList0').css("display","none");
				if($('#trueOrFalse').val()=='true'){
					$('#trueOrFalse').val('false');
					mui('#pullrefresh').pullRefresh().endPulldownToRefresh();
					mui('#pullrefresh').pullRefresh().refresh(true);
					mui('#pullrefresh').pullRefresh().endPullupToRefresh(false);
					//mui('#pullrefresh').pullRefresh().pullupLoading();
				}
				//  getAction = 3表示 服务列表
				$('#getAction').val(3);
				$('#getPage').val(1);
				showPopWin(0, "正在处理，请稍候...");
				var url = "${pageContext.request.contextPath}/sjyuyueservice.do?p=servicelist&page=1";
				var param = {
				};
				
				$.post(url, param, function(data) {
					hideLoading();
					jsons = eval("(" + data + ")");
					json = jsons.servicelist;
					//alert(jsons);
					$('#getCount').val(jsons.count);
					//alert(json[0]);  
								
					if (json.length == 0) { //当数据为空
						$("#yuyueRecordList3").html('<li class="payBX"><img src="${pageContext.request.contextPath}/weixin/images/NoData.png" style="width: 100px; display: block; margin: 0 auto; padding: 20px 0;"/><button onclick="subEdit()" class="butA butBlue" style="margin-top: 0;font-size:20px;line-height:30px">新 增 服 务</button></li>');
						mui('#pullrefresh').pullRefresh().endPullupToRefresh(true);
						$('#trueOrFalse').val('true');
					} else {
						// 清空列表
						$("#yuyueRecordList3").empty();
						$("#yuyueRecordList3").html('<button onclick="subEdit()" class="butA butBlue" style="margin-top: 0;font-size:20px;line-height:30px">新 增 服 务</button>');	
						//alert(json.length);
						//alert(json);
						for (var i = 0; i < json.length; i++) {
							//alert(i);
							var m = '<li class="mui-table-view-cell">';
							m = m + '<div class="mui-table">';
							m = m + '<div class="mui-table-cell mui-text-left mui-col-xs-8" style="height: 20px;">';
							m = m + '<h5 class="mui-ellipsis">服务名称：'+json[i].title+'&nbsp;</h5>';
							m = m + '</div>';
							m = m + '<div class="mui-table-cell mui-col-xs-4 mui-text-right">';		
							m = m + '<span class="mui-h5">';
							if (json[i].status == 0){
							m = m + '<a id="'+json[i].id+'" class="xg"  title="修改状态"><button class="label label-defaunt radius">下架</button></a>';
							}
							if (json[i].status == 1){
							m = m + '<a  id="'+json[i].id+'" class="xg"  title="修改状态"><button class="label label-success radius">上架</button></a>';
							}
							
							m = m + '</span></div></div></li>';					
							m = m + '<li class="mui-table-view-cell">';				
							m = m + '<div class="mui-table">';					
							m = m + '<div class="mui-table-cell mui-text-left">';
							m = m + '<img style="width: 80px; height: 80px;" class="mui-media-object mui-pull-left" src="${pageContext.request.contextPath}/'+json[i].image+'" />'
							m = m + '<p class="mui-h6 mui-ellipsis">服务类型：'+json[i].serviceType.name+'</p>';				
							m = m + '<p class="mui-h6 mui-ellipsis">市场价格：'+json[i].shichangPrice+'元</p>';				
							m = m + '<p class="mui-h6 mui-ellipsis">预约价格：'+json[i].yuyuePrice+'元</p>';
							m = m + '<p class="mui-h6 mui-ellipsis">服务所需时间：'+json[i].time+'分钟</p>';
							m = m + '</div>';	
							m = m + '<div class="mui-table-cell mui-col-xs-4 mui-text-right" >';		
							m = m + '<span class="mui-h5">';
							m = m + '<span class="xg"><button class="label label-defaunt radius" onclick="gotoedit('+json[i].id+')">编辑</button></span>';
							m = m + '</span></div>';		 
							m = m + '</div></li><hr />';				
							$("#yuyueRecordList3").append(m);
						}
					}
				});
				
				}
				
				
				
		}
		
		
			
		</script>
		
			<script type="text/javascript">
			$("#beizhu").removeAttr("style");
			
			$(function(){
			
			     mui("ul").on("tap","a",function(){
						    var id = $(this).attr("id");
			                xiugai_status(this,id);
			         });
			});
			
			//进入编辑页面
			function gotoedit(id){
				window.location.href="${pageContext.request.contextPath}/sjyuyueservice.do?p=goeditorservice&id="+id;
			}
			
			//进入新增页面
			function subEdit(){
				window.location.href="${pageContext.request.contextPath}/sjyuyueservice.do?p=goaddservice";
			}
			
			function xiugai_status(a,id){
				var url = "${pageContext.request.contextPath}/sjyuyueservice.do?p=updatestatus";
				var param = {
					id : id
				};
				$.post(url, param, function(data) {
					if(data=="1")
					{
							a.innerHTML='<button class="label label-defaunt radius">上架</button>';
						alert("已修改成上架");
					}
					else{
						a.innerHTML='<button class="label label-success radius">下架</button>';
						alert("已修改成下架");
					}
				});
			}
		</script>

	</body>


</html>