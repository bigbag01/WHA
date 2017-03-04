
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
	<script>
	    function initradio(rName,rValue){
	        var rObj = document.getElementsByName(rName);   
	        for(var i = 0;i < rObj.length;i++){
	            if(rObj[i].value == rValue){
	                rObj[i].checked =  'checked';
	            }
	        }
	     
	    }
	</script>
	<div id="header">
    <jsp:include page="../header.jsp" />
	</div>
	<div class="container-fluid">
	<div class="row-fluid">
		<jsp:include page="../sidebar.jsp" />
		<%
		User user=(User)s.getAttribute("user");
		String usn=user.getUserName();
		String pass=user.getPassword();
		String email=user.getEmail();
		String phone=user.getPhone();
		String gender=user.getGender();
		%>
		
		<div  style="display:inline-block;margin:0 7%;width:66%">
		<div class="title">个人信息</div>
		<form id="fm" method='post' action='editUser'>
		<div style="text-align:center">
		<table style="margin-left:auto;margin-right:auto;text-align:start">
			<tr>
			<td>用户名</td>
			<td><input name="userName"  class="form-control" placeholder="<%=usn %>" value='<%=usn %>' disabled></input></td>
			</tr>
			<tr>
			<td>密码</td>
			<td><input name="password" class="form-control" type="password" value="<%=pass%>" data-options="required:true"></input></td>
			</tr>
			<tr>
			<td>邮箱</td>
			<td><input name="email" class="form-control" value="<%=email %>" data-options="validType:'email'"></input></td>
			</tr>
			<tr>
			<td>电话</td>
			<td><input name="phone" class="form-control" value="<%=phone %>" ></input></td>
			</tr>
			<tr>
			<td>性别</td>
			<td>
     		 <input type="radio" name="gender" 	value="男" > 男</input>
     		 <input type="radio" name="gender"  value="女" > 女</input>
     		</td>
			</tr>
		</table>
		<button type="submit" class="btn btn-default" >完成修改</button>
		</div>
		</form>
		<script>
				initradio('gender','<%=gender%>' );
		</script>
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
 		tr{
 			border:10px solid transparent;
 		}
	</style>
	<script type="text/javascript">

	</script>
</body>
</html>