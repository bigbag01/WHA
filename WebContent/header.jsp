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
	<!-- <link href="http://libs.baidu.com/bootstrap/3.0.3/css/bootstrap.min.css" rel="stylesheet" />
	<script src="http://libs.baidu.com/jquery/2.0.0/jquery.min.js"></script>
	<script src="http://libs.baidu.com/bootstrap/3.0.3/js/bootstrap.min.js"></script> -->
</head>
<body>
	 
	 <nav class="navbar navbar-default">
	  <div class="container-fluid">
	    <!-- Brand and toggle get grouped for better mobile display -->
	    <div class="navbar-header">
	      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
	        <span class="sr-only">Toggle navigation</span>
	        <span class="icon-bar"></span>
	        <span class="icon-bar"></span>
	        <span class="icon-bar"></span>
	      </button>
	      <a class="navbar-brand" href="#">在身边</a>
	    </div>
	
	    <!-- Collect the nav links, forms, and other content for toggling -->
	    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
	      <ul class="nav navbar-nav">
	        <li><a href="<%=basePath%>index">首页<span class="sr-only">(current)</span></a></li>
	        <li><a href="<%=basePath%>listAct">活动</a></li>
	        <li><a href="<%=basePath%>recommend">推荐活动</a>
	      </ul>
	      <form class="navbar-form navbar-left" role="search" id="srch" action="<%=basePath%>searchAct">
	        <div class="input-group" style="margin:0;width:100%">
	          <input type="text" class="form-control" placeholder="活动名" aria-describedby="sch" name="qry"/>
	          <span class="input-group-addon" id="sch"><a href="#" onclick="doSearch()"><span class="glyphicon glyphicon-search"></a></span></span>
	        </div>
	      </form>
	      <ul class="nav navbar-nav navbar-right">
	        <li id="usr"><a href="<%=basePath%>login.jsp">登录</a></li>
	        <li id="out"><a href="<%=basePath%>register.jsp">注册</a></li>
	        <li class="dropdown" id="plus">
	          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"  ><span class="glyphicon glyphicon-plus"></span></a>
	          <ul class="dropdown-menu" role="menu">
	            <li><a href="<%=basePath%>showMyMessage">站内消息</a></li>
	            <li><a href="<%=basePath%>user/pubact.jsp">发布活动</a></li>
	            <li role="separator" class="divider"></li>
	            <li><a href="relatedlink.jsp">相关站点</a></li>
	          </ul>
	        </li>
	      </ul>
	    </div><!-- /.navbar-collapse -->
	  </div><!-- /.container-fluid -->
	</nav>
	<script type="text/javascript">
	$(document).ready(function(){
		$('#plus').hide();
		<% 
			Object usn=s.getAttribute("userName");
			String us="";
			if(usn!=null){
				us=(String)usn;
			}
		%>
		
		if('<%=us%>'!=''){
			var usn='<%=us%>';
			$('#usr').html("<a href='<%=basePath%>showUserInfo'>" + usn+"</a>");			
			$('#out').html("<a href='<%=basePath%>logout'>"+"退出"+"</a>");
			$('#plus').show();
		}

	});
	function doSearch(){
		$('#srch').submit();
	}
	</script>
</body>
</html>