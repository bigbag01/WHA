<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<% 
	 HttpSession s = request.getSession();
	 String path = request.getContextPath();
	 String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta charset="UTF-8" />
	<title>登录</title>
	<link href="<%=basePath %>css/bootstrap.min.css" rel="stylesheet" />
	<script src="http://libs.baidu.com/jquery/2.0.0/jquery.min.js"></script>
	<script src="http://libs.baidu.com/bootstrap/3.0.3/js/bootstrap.min.js" ></script>
	<script src="http://static.runoob.com/assets/jquery-validation-1.14.0/dist/jquery.validate.min.js"></script>
</head>
<body>
	<div id="header">
    <jsp:include page="header.jsp" />
	</div>
	<h2>登录</h2>
	<div id="fm">
		<form action="" method="post" id="lgfm">
			<div class="form-group" style="margin:15px;text-align:center">
					<label id="con"></label>
			</div>
			<div class="form-group" style="margin:15px">
	       		<label for="userName">用户名</label>  
	    		<div class="input-group" >  
	        		<input type="text" class="form-control" placeholder="用户名" id="userName" name="userName" required />  
	       			 <span class="input-group-addon">  
	        			<span class="glyphicon glyphicon-user"></span>  
	       			 </span>
	   			</div>
	   		</div>
	   		<div class="form-group" style="margin:15px">
	        	<label for="password">密码</label>  
	    		<div class="input-group" >  
	        		<input type="password" class="form-control" placeholder="密码" id="password" name="password" required />  
	       			 <span class="input-group-addon">  
	        			<span class="glyphicon glyphicon-eye-open"></span>  
	       			 </span>
	   			</div>
	    	</div>
			<div class="form-group" style="text-align:center;">
        			<button class="btn btn-default" type="submit" style="margin:5px" id="fmbt">登录</button>
  			</div>	
  			<p style="text-align:center">没有账号？<a href="register.jsp">立即注册</a></p>
  		</form>
	</div>
	<style type="text/css" >
 		h2{
			font-weight:bold;
   			width:30%;
   			margin-left:auto;
   			margin-right:auto;
   			margin-bottom:15px;
   			text-align:center;
		}
		#fm{
			margin:5% 30%;
			padding:5% 7%;
			border:3px solid #C1C1C1;
			border-radius:10px;
		}

	</style>
	<script type="text/javascript">
	 $(document).ready(function(){	
		//if($("input[name=userName]").val()=="") con.innerHTML='<font color="red">用户名不可为空</font>';
		//else if($("input[name=password]").val()=="") con.innerHTML='<font color="red">密码不可为空</font>';
		//else{
		$('#lgfm').submit(function(){
			$.ajax({
				url:'<%=basePath%>login',
				data:$('#lgfm').serialize(),
				success:function(res){
					var data=JSON.parse(res);
					var con=document.getElementById('con');
					if(data.result=="pass"){
						con.innerHTML = '<font color="red">密码错误</font>';
					}else if(data.result=="usn"){
						con.innerHTML = '<font color="red">用户名不存在</font>';				
					}else{
						window.location.href="<%=basePath%>index";
					}
				}
			});
			return false;
		})
			
		//}
		
	});
	
	</script>
</body>
</html>