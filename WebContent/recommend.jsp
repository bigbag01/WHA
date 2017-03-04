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
	<title>在身边</title>
	<link href="<%=basePath %>css/bootstrap.min.css" rel="stylesheet" /> 
	<script src="http://libs.baidu.com/jquery/2.0.0/jquery.min.js"></script>
	<script src="http://libs.baidu.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
</head>
<body>
	<div id="header">
    <jsp:include page="./header.jsp" />
	</div>
	<div style="margin:0 10%;">
		<%
			List list=(List)s.getAttribute("recommend");
			if(list!=null&&list.size()!=0){
				Iterator it=list.iterator();
		%>	
			<div class="title">推荐给你的活动</div>
			<div class="panel-group" id="accordion">
				<%
					while(it.hasNext()){
						Activity activity=(Activity)it.next();
						String posterpath=activity.getPosterpath();
						String status=activity.getStatus();
						Long aid=activity.getAid();
						String head=activity.getHead();
						if(status.equals("passed")){
				%>
					<a href="<%=basePath%>showActDetail?aid=<%=aid %>">
					<div class="panel panel-default">
					<div class="actbox panel-heading">
					<img src="<%=basePath%>upload/<%=aid %>/<%=posterpath%>"/>
					<h4><%=head %></h4>
					</div>
					</div>
					</img>
				<%
						}
					}
				%>
			</div>

		<%
			}
		%>
	</div>
	<style >
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
 		.actbox img{
 			display:inline-block;
 			vertical-align:middle;
			padding:0 5px;
			height:80px;
			width:80px;
 		}
 		.actbox h4{
 			display:inline-block;
 		}
 		li{
 			display:block;
 			list-style:none;
 		}
 		ul{
 			padding:0;
 		}
 		.actbox{
 			padding:10px;
 			border-radius:4px;
 			background-color:#F8F8F8;
 		}
 		.mybtn{
 			display:block;
 			margin:5px;
 		}
 		.mybtns{
 			display:inline-block;
 			float:right;
 		}
	</style>
</body>
</html>