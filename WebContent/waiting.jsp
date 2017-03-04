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
	<h2 style="text-align:center">待审核活动</h2>

	<div class="acts">
		<ul id="acts">
	<%
		List list=(List)s.getAttribute("waitings");
		if(list!=null&&list.size()!=0){
			Iterator it=list.iterator();
			while(it.hasNext()){
				Activity act=(Activity)it.next();
				Long aid=act.getAid();
				String poster=act.getPosterpath();
				String head=act.getHead();
				String posterpath;
				if(poster!=null)
					posterpath=basePath+"upload/"+aid+"/"+poster;
				else posterpath=basePath+"upload/default.jpg";
	%>
			<li>
				<a href="<%=basePath %>showActDetail?aid=<%=aid %>&res=preview">
				<div class="imgbox">
					<img src="<%=basePath%>upload/<%=aid %>/<%=poster %> "></img>
					<p><%=head %></p>
				</div>
				</a>
			</li>
	<%
			}
		}
	%>
		</ul>
	</div>
	<style>
		.acts li{
			width:240px;
			height:245px;
			display:inline;
			float:left;
			margin:10px;
		}
		.imgbox{
			margin:5px auto;
			text-align:center;
			font-size:20px;
		}
		.imgbox img{
			vertical-align:middle;
			padding:0 5px;
			height:160px;
			width:160px;
		}
	</style>
</body>
</html>