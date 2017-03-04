<?xml version="1.0" encoding="utf-8" ?>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" import="java.util.*,model.*"%>
<% 
	 HttpSession s = request.getSession();
	 String path = request.getContextPath();
	 String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<link href="<%=basePath %>css/bootstrap.min.css" rel="stylesheet" />
	<script src="http://libs.baidu.com/jquery/2.0.0/jquery.min.js"></script>
	<script src="http://libs.baidu.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
	<title>在身边</title>
</head>
<body>
	
	<div id="header">
    <jsp:include page="./header.jsp" />
	</div>
	<div class="container-fluid">
	<div class="row-fluid" style="text-align:center">
	<h2>相关链接</h2>
	<ul>
		<li class="lnk"><a href="http://www.sjtu.edu.cn/">上海交通大学</a></li>
		<li class="lnk"><a href="http://www.tongqu.me/">同去网</a></li>
	</ul>
	</div>
	</div>
	<style>
	h2{
		font-weight:700;
		padding:9px;
		margin-bottom:10px;
		text-align:center;
 	}
 	ul{
 		padding:0;	
 	}
 	.lnk{
 		list-style:none;
 		margin:10px;
 	}
	</style>
</body>
</html>
