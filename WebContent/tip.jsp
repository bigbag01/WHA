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
	<div style="margin:5% 30%;padding:5% 7%;border:3px solid #C1C1C1;border-radius:10px;">
		<h4 style="text-align:center">提示：</h4>
		<%
		Map tip=(Map)s.getAttribute("tip");
		if(tip!=null&&tip.size()>0){
			int type=(int)tip.get("type");
			if (type==4){
		%>
			<p>抱歉，此操作需要管理员权限，您并无管理员权限！</p>
		<% 
			}else{
				int auth=(int)tip.get("auth");
				String start=(String) tip.get("start");
				String end=(String) tip.get("end");
				String reason=(String)tip.get("reason");
		%>
			<p>
			抱歉，此操作需要 <span class="rqr"><%=type %>级</span> 权限，
			而您现在的权限为 <span class="owm"><%=auth %>级</span> 。
			</p>
			<p>
			您被限制为当前权限是因为：
			<%=reason %>
			</p>
			<p>
			限制时间从 <span style="font-style:bold"><%=start %></span> 开始
			限制时间至 <span style="font-style:bold"><%=end %></span> 结束。
			</p>
		<%
			}
		} 
		%>
	</div>
	
</body>
</html>