<?xml version="1.0" encoding="utf-8" ?>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" import="java.util.*,model.*,java.text.SimpleDateFormat"%>
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
	<script src="//cdn.bootcss.com/jquery/2.0.0/jquery.min.js"></script>
	<script src="//cdn.bootcss.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
</head>
<body>
	<div id="header">
    <jsp:include page="../header.jsp" />
	</div>
	<div class="container-fluid">
	<div class="row-fluid">
		<jsp:include page="../sidebar.jsp" />
		<div  style="display:inline-block;margin:0 7%;width:66%">
		<%
			List list=(List)s.getAttribute("myMessages");
			if(list!=null&&list.size()!=0){
				Iterator it=list.iterator();
		%>
			<div class="title">我收到的消息</div>
			<div class="panel-group" id="accordion">
				<%
					while(it.hasNext()){
						Message message=(Message)it.next();
						/* if(message.getMyType().equals("lockinfo")) 
							continue; */
						String msg=message.getMsg();
						User sender=message.getSender();
						String sendername=sender.getUserName();
						SimpleDateFormat myFmt=new SimpleDateFormat("yyyy年MM月dd日 HH:mm");
						String time=myFmt.format(message.getTime());
						String myType=message.getMyType();
						if(myType.equals("lockinfo")){
				%>
					<div class="panel panel-default">
					<div class="actbox panel-heading">
					<h4>权限更改：</h4>
					<p>原因：<%=msg %></p>
					<p>时间：<%=time %></p>
					</div>
					</div>
				<%
						}else{
						Activity activity=message.getActivity();
						String head=activity.getHead();
						Long aid=activity.getAid();
						
				%>
					<div class="panel panel-default">
					<div class="actbox panel-heading">
					<% if(myType.equals("message")){ %>
					<h4>消息来自：<%=sendername %></h4>
					<%}else if(myType.equals("comment")){ %>
					<h4>评论来自：<%=sendername %></h4>
					<%}else if(myType.equals("invitation")){ %>
					<h4>邀请来自：<%=sendername %></h4>
					<%}else{ %>
					<h4>消息来自活动发起者：<%=sendername %></h4>
					<%} %>
					<p>活动：<a href="<%=basePath%>showActDetail?aid=<%=aid %>"><%=head %></a></p>
					<p>时间：<%=time %></p>
					<p>消息内容：<%=msg %></p>
					</div>
					</div>	
				<%
						}
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
	</style>
</body>
</html>