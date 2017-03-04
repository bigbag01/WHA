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
	<title>注册</title>
	<link href="<%=basePath %>css/bootstrap.min.css" rel="stylesheet" />
	<link href="//cdn.bootcss.com/bootstrap-validator/0.5.3/css/bootstrapValidator.css"></link>
	<script src="http://libs.baidu.com/jquery/2.0.0/jquery.min.js"></script>
	<script src="http://libs.baidu.com/bootstrap/3.0.3/js/bootstrap.min.js" ></script>
	<script src="//cdn.bootcss.com/bootstrap-validator/0.5.3/js/bootstrapValidator.js"></script>
</head>
<body>
	<div id="header">
    <jsp:include page="header.jsp" />
	</div>
	<h2>注册</h2>
	<div id="fm">
		<form action="" id="regfm">
	   		<div class="form-group" style="margin:15px;text-align:center">
					<label id="con"></label>
		    </div>
	   		<div class="form-group" style="margin:15px">
	       		<label for="userName">用户名<span style="color:red">*</span></label>  
	    		<div class="input-group" >  
	        		<input type="text" class="form-control" placeholder="用户名" id="userName" name="userName" required />  
	       			 <span class="input-group-addon">  
	        			<span class="glyphicon glyphicon-user"></span>  
	       			 </span>
	   			</div>
	   			<p style="font-style:oblique">（长度不限，支持汉字、数字、字母、下划线）</p>
	   		</div>
	   		<div class="form-group" style="margin:15px">
	        	<label for="password">密码<span style="color:red">*</span></label>  
	    		<div class="input-group" >  
	        		<input type="password" class="form-control required" placeholder="密码" id="password" name="password" required />  
	       			 <span class="input-group-addon">  
	        			<span class="glyphicon glyphicon-eye-open"></span>  
	       			 </span>
	   			</div>
	   			<p style="font-style:oblique">（长度为6-12个字符，支持数字、大小写字母、下划线）</p>
	    	</div>
	    	<div class="form-group" style="margin:15px">
	        	<label for="email">邮箱</label>
	       		<input type="email" class="form-control" placeholder="邮箱" name="email" />
	    	</div>
	    	<div class="form-group" style="margin:15px">
	        	<label for="phone">电话</label>
	       		 <input type="number" class="form-control" placeholder="电话" name="phone" />
	    	</div>
	    	<div class="form-group" style="text-align:center;">
	        	<button class="btn btn-default" type="submit" style="margin:5px">注册</button>
	  		</div>	
  		</form>
    </div>
	<style type="text/css">
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
		$('#regfm').submit(function(){
			$.ajax({
				url:'register',
				data:$('#regfm').serialize(),
				success:function(result){
					if(result=="ok"){
						alert("注册成功，3秒后将跳转登录页面");
						setTimeout("top.location.href='" + "<%=basePath%>login.jsp" + "'", 3);
						window.location.href="login.jsp";
					}else if(result=="illusn"){
						con.innerHTML='<font color="red">用户名不合法</font>'	;
					}else if(result=="illpass"){
						con.innerHTML='<font color="red">密码不合法</font>'	;
					}
					else{
						con.innerHTML='<font color="red">用户名已存在</font>';
					}
				}
			});
			return false;
		})
	})
		
	</script>
</body>
</html>