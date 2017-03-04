<?xml version="1.0" encoding="UTF-8" ?>
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
	<meta http-equiv="Content-Type" content="text/html charset=UTF-8" />
	<title>在身边</title>
	<link href="<%=basePath %>css/bootstrap.min.css" rel="stylesheet" />
	<script src="http://libs.baidu.com/jquery/2.0.0/jquery.min.js"></script>
	<script src="http://libs.baidu.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
</head>
<body>
    <div id="header">
    <jsp:include page="header.jsp" />
	</div>
	<div class="acts">
		<ul id="acts">
	<%
		List<Activity> list=(List<Activity>)s.getAttribute("activities");
		for(Activity act:list){
				Long aid=act.getAid();
				String poster=act.getPosterpath();
				String head=act.getHead();
				Date now=new Date();
				String state;
				if(now.after(act.getActend())) continue;
				else if(now.after(act.getActstart())&&now.before(act.getActend())) state="活动进行中";
				else if(now.after(act.getAplstart())&&now.before(act.getAplend())) state="活动报名中";
				else if(now.before(act.getActstart())&&now.after(act.getAplend())) state="活动未开始";
				else state="报名未开始";
	%>
			<li>
				<a href="<%=basePath %>showActDetail?aid=<%=aid %>">
				<div class="actbox">
					<div class="imgbox">
					<img src="<%=basePath%>upload/<%=aid %>/<%=poster %> "></img>
					</div>
					<p><%=head %></p>
					<p style="font-size:16px;">[<%=state %>]</p>
				</div>
				</a>
			</li>
	<%
			
		}
	%>
		</ul>
	</div>
	<style>
		.acts li{
			width:240px;
			height:245px;
			display:inline-block;
			float:left;
			margin:10px;
			text-align:center
		}
		.actbox{
			margin:5px auto;
			font-size:18px;
		}
		.actbox img{
			vertical-align:middle;
			width:auto;
			height:auto;
			max-height:160px;
			max-width:220px;
		}
		.imgbox{
			height:160px;
			width:220px;
			margin-left:auto;
			margin-right:auto;
			text-align:center;
		}
	</style>
</body>
</html>