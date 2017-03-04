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
	<link href="//cdn.bootcss.com/bootstrap-table/1.11.0/bootstrap-table.css" rel="stylesheet" />
	<script src="http://libs.baidu.com/jquery/2.0.0/jquery.min.js"></script>
	<script src="http://libs.baidu.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
	<script src="//cdn.bootcss.com/bootstrap-table/1.11.0/bootstrap-table.js"></script>
	<script src="//cdn.bootcss.com/bootstrap-table/1.11.0/locale/bootstrap-table-zh-CN.js"></script>

	<title>在身边</title>
</head>
<body>
	<div id="header">
    <jsp:include page="../header.jsp" />
	</div>
	<div class="container-fluid">
		<div class="row-fluid">
			<jsp:include page="../sidebar.jsp" />
			<div  style="display:inline-block;margin:0 7%;width:66%">
			<h2 style="text-align:center;font-weight:600;color:#777777">所有我参加的活动</h2>
		<%
			List list=(List)s.getAttribute("myAttend");
			if(list!=null&&list.size()!=0){
				Iterator it=list.iterator();
		%>
			<div class="title">我报名的活动</div>
			<div class="panel-group" id="accordion">
				<%
					while(it.hasNext()){
						Activity activity=(Activity)it.next();
						String posterpath=activity.getPosterpath();
						String status=activity.getStatus();
						Long aid=activity.getAid();
						String head=activity.getHead();
						String state="";
						Date now=new Date();
						if(now.before(activity.getActstart())) state="尚未开始";
						if(now.after(activity.getActend())) state="已经结束";
						else state="进行中";
				%>
					<div class="panel panel-default">
					<a href="<%=basePath%>showActDetail?aid=<%=aid%>">
					<div class="actbox panel-heading">
					<img src="<%=basePath%>upload/<%=aid %>/<%=posterpath%>"/>
					<h4><%=head %>[<%=state %>]</h4>
					</div>
					</a>
					</div>	
				<%
					}
				%>
			</div>
			<%
			}
			%>
			</div>
		</div>
	</div>
	<style>
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
	</style>
</body>
</html>