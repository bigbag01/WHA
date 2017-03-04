<?xml version="1.0" encoding="utf-8" ?>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" import="model.*"%>
<% 
	 HttpSession s = request.getSession();
	 String path = request.getContextPath();
	 String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<link href="http://libs.baidu.com/bootstrap/3.0.3/css/bootstrap.min.css" rel="stylesheet" />
	<script src="http://libs.baidu.com/jquery/2.0.0/jquery.min.js"></script>
	<script src="http://libs.baidu.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
	<title>在身边</title>
</head>
<body>
	<div id="header">
    <jsp:include page="header.jsp" />
	</div>
	<div class="container-fluid">
	<div class="row-fluid">
		<div class="navbar-default sidebar " >
			<div class="sidebar-nav navbar-collapse">
				<ul class="nav nav-tabs nav-stacked">
					<li><a href="manage.jsp">个人信息</a></li>
					<li><a href="<%=basePath %>waiting">待审核活动</a></li>   
					<li><a href="#">所有用户</a></li>
					<li><a href="#">用户反馈</a></li> 
					 
				</ul>
			</div>
		</div>
	</div>
	</div>
	<style>
		.sidebar{
			border-right:solid 1px;
			border-right-color:lightgray;
			display:inline;
			float:left;
			margin-right:10px;
		}
		.title{
 			font-size:20px;
 			font-weight:700;
 			background-color:#472F86;
 			color:white;
 			padding:9px;
 			margin-bottom:10px;
 		}
	</style>
</body>
</html>