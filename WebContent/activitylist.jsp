<?xml version="1.0" encoding="utf-8" ?>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" import="java.util.*,model.*" %>
<% 
	 HttpSession s = request.getSession();
	 String path = request.getContextPath();
	 String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	 List<Activity> list=(List<Activity>)s.getAttribute("activities");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>在身边</title>
	<link href="<%=basePath %>css/bootstrap.min.css" rel="stylesheet" /> 
	<script src="//cdn.bootcss.com/jquery/2.0.0/jquery.min.js"></script>
	<script src="//cdn.bootcss.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
</head>
<body>
	<div id="header">
    <jsp:include page="./header.jsp" />
	</div>
	<div id="Main">
	<ul id="myTab" class="nav nav-tabs">
		<li class="active">
			<a href="#before" data-toggle="tab">未开始报名</a>
		</li>
		<li>
			<a href="#going" data-toggle="tab">正在报名中</a>
		</li>
		<li>
			<a href="#after" data-toggle="tab">报名已结束</a>
		</li>
	</ul>
	<div id="myTabContent" class="tab-content">
		<div class="tab-pane fade in active" id="before">
			<%	
			if(list!=null&&list.size()>0){
				int cnt=0;
			%>
			<div class="panel-group" id="accordion">
				<%
					for(Activity activity:list){	
						String posterpath=activity.getPosterpath();
						String status=activity.getStatus();
						Long aid=activity.getAid();
						String head=activity.getHead();
						Date now=new Date();
						if(!now.before(activity.getAplstart())) continue;
						cnt++;
				%>
					<div class="panel panel-default">
					<a href="<%=basePath%>showActDetail?aid=<%=aid%>">
					<div class="actbox panel-heading">
					<img src="<%=basePath%>upload/<%=aid %>/<%=posterpath%>"/>
					<h4><%=head %></h4>
					</div>
					</a>
					</div>	
				<%
					}
				%>
			</div>
			<%
				if(cnt==0){
			%>
				<p> 暂无 </p>
			<% 	
				}
			}
			%>
		</div>
		<div class="tab-pane fade" id="going">
			<%
			if(list!=null&&list.size()>0){
				int cnt=0;
			%>
			<div class="panel-group" id="accordion">
				<%
					for(Activity activity:list){	
						String posterpath=activity.getPosterpath();
						String status=activity.getStatus();
						Long aid=activity.getAid();
						String head=activity.getHead();
						String state="";
						Date now=new Date();
						if(!(now.before(activity.getAplend())&&now.after(activity.getAplstart()))) continue;
						cnt++;
				%>
					<div class="panel panel-default">
					<a href="<%=basePath%>showActDetail?aid=<%=aid%>">
					<div class="actbox panel-heading">
					<img src="<%=basePath%>upload/<%=aid %>/<%=posterpath%>"/>
					<h4><%=head %></h4>
					</div>
					</a>
					</div>	
				<%
					}
				%>
			</div>
			<%
				if(cnt==0){
			%>
				<p> 暂无 </p>
			<% 	
				}
			}
			%>
		</div>
		<div class="tab-pane fade" id="after">
			<%
				if(list!=null&&list.size()>0){
					int cnt=0;
			%>
			<div class="panel-group" id="accordion">
				<%
					for(Activity activity:list){	
						String posterpath=activity.getPosterpath();
						String status=activity.getStatus();
						Long aid=activity.getAid();
						String head=activity.getHead();
						String state="";
						Date now=new Date();
						if(!(now.after(activity.getAplend()))) continue;
						cnt++;
				%>
					<div class="panel panel-default">
					<a href="<%=basePath%>showActDetail?aid=<%=aid%>">
					<div class="actbox panel-heading">
					<img src="<%=basePath%>upload/<%=aid %>/<%=posterpath%>"/>
					<h4><%=head %></h4>
					</div>
					</a>
					</div>	
				<%
					}
				%>
			</div>
			<%
				if(cnt==0){
			%>
				<p> 暂无 </p>
			<% 	
				}
			}
			%>
	</div>
	</div>
	<style>
		#Main{
		 margin:0 10%
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
	</style>
</body>
</html>