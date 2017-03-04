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
	<title>header</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body>
	<div class="navbar-default sidebar " >
			<div class="sidebar-nav navbar-collapse">
				<ul class="nav nav-tabs nav-stacked" id="sidebar" style="border:0;text-align:center;font-size:initial">
					<li><a href="showUserInfo">个人信息</a></li>   
					<li id="second"><a href="showMyMessage" >站内消息</a></li>
					<li id="third"><a href="showMyAttend" >我参加的活动</a></li> 
					<li id="fourth"><a href="showMyPub" >我发布的活动</a></li>
					
				</ul>
			</div>
		</div>
	<script type="text/javascript">
	$(document).ready(function(){
		<% 
		Object usn=s.getAttribute("userName");
		String us="";
		if(usn!=null){
			us=(String)usn;
		}
		%>
		if('<%=us%>'=="admin"){
			//$('#second').html("<a href='<%=basePath%>waiting'>待审核活动</a>");
			$('#third').html("<a href='<%=basePath%>usrmanagement.jsp'>用户管理</a>");
			$('#sidebar').append("<li><a href='<%=basePath%>waiting'>待审核活动</a></li>");
			$('#sidebar').append("<li><a href='<%=basePath%>feedback.jsp'>用户反馈</a></li>");
		}

	});
	</script>
	<style>
		.sidebar{
			border:solid 1px;
			border-color:#E7E7E7;
			border-radius:2px;
			display:inline;
			float:left;
			width:17%;
			padding:3% 0;
		}

	</style>
</body>
</html>