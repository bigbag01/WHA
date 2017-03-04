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
	<link href="//cdn.bootcss.com/bootstrap-table/1.11.0/bootstrap-table.css" rel="stylesheet" />
	<link href="./css/bootstrap-datetimepicker.css" rel="stylesheet"></link>
	<script src="http://libs.baidu.com/jquery/2.0.0/jquery.min.js"></script>
	<script src="http://libs.baidu.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
	<script src="//cdn.bootcss.com/bootstrap-table/1.11.0/bootstrap-table.js"></script>
	<script src="//cdn.bootcss.com/bootstrap-table/1.11.0/locale/bootstrap-table-zh-CN.js"></script>
	<script src="./js/bootstrap-datetimepicker.min.js"></script>
	<script src="./js/bootstrap-datetimepicker.fr.js"></script>
	<title>在身边</title>
</head>
<body>
	
	<div id="header">
    <jsp:include page="./header.jsp" />
	</div>
	<div class="container-fluid">
	<div class="row-fluid">
		<jsp:include page="./sidebar.jsp" />
		<div class="right-side" > 
        <table id="user-data" class="table  table-hover table-striped"></table>
        <div id="toolbar">
		 <div class="btn btn-default" id="grant">权限设定</div>
		 <div class="btn btn-default" id="info">查看资料</div>
		</div>
		<div style="margin:10px 0;font-style:oblique ">
			<p><span style="color:blue;">提示：</span>
			用户权限级别分四档，0 可浏览活动，可查看修改个人信息，1 可报名活动，邀请好友参与活动，可打分已报名的活动，2 可对活动进行评论，3 可发布活动</p>
			<p>未设置过的用户权限默认为3</p>
		</div>
        </div>
	</div>
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
   		<div class="modal-dialog">
     		 <div class="modal-content">
		         <div class="modal-header">
		            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"> &times;</button>
		            <h4 class="modal-title" id="myModalLabel">修改用户权限</h4>
		         </div>
		         <div class="modal-body">
		           	<form id="lockfm" action="<%=basePath%>lockUser">
		           		<input name="userName" style="display:none"></input>
		           		<label>用户权限等级</label>
		           		<label class="radio-inline"><input type="radio" name="auth" value="0" checked/>0</label>
		           		<label class="radio-inline"><input type="radio" name="auth" value="1" />1</label>
		           		<label class="radio-inline"><input type="radio" name="auth" value="2" />2</label>
		           		
		           		<div class="input-group date form_datetime form-group" style="margin:5px 0;width:50%"  >	
				  		 	<input size="16" type="text"  name="start" class="form-control" placeholder="开始锁定" required />
				  		 	<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
						</div>
						<div class="input-group date form_datetime form-group" style="margin:5px 0;width:50%" >
				  		 	<input size="16" type="text"  name="end" class="form-control" placeholder="解除锁定" required />
				  		 	<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
						</div>
						<textarea name="msg" id="msg" placeholder="锁定原因是：" required></textarea>
		           	</form>
		         </div>
		         <div class="modal-footer">
		            <button type="button" class="btn btn-default"  data-dismiss="modal">关闭</button>
		            <button type="submit" form="lockfm" class="btn btn-primary">确定</button>
		         </div>
     		</div><!-- /.modal-content -->
		</div><!-- /.modal -->	
	</div>
	<div class="modal fade" id="infoModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
   		<div class="modal-dialog">
     		 <div class="modal-content">
		         <div class="modal-header">
		            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"> &times;</button>
		            <h4 class="modal-title" id="myModalLabel">用户信息</h4>
		         </div>
		         <div class="modal-body" id="body">
		           	
		         </div>
     		</div><!-- /.modal-content -->
		</div><!-- /.modal -->	
	</div>
	</div>
	<style>
		.input-group{
			width:40%;
			margin:0 30%
		}
		.right-side{
			display:inline-block;
			width:70%;
			margin:0 5%
		}
		#msg{
			height:80px;
			width:100%;
			border-color:#cccccc;
			border-radius:4px
		}
	</style>
	<script type="text/javascript">
		$(document).ready(function(){
			$(".form_datetime").datetimepicker({
		 		language:  'zh-CN', 
		        autoclose: true,
		        todayBtn: true,
		        format:'yyyy-mm-dd hh:ii',
		        pickerPosition: "bottom-left"
		    }); 
		   $('#user-data').bootstrapTable({
	        	url:"<%=basePath%>showAuth",
	        	locale:'zh-CN',
	        	search:true,
	        	searchOnEnterKey:true,
	        	clickToSelect:true,
	        	showColumns:true,
	        	singleSelect:true,
	        	toolbar:'#toolbar',
	        	columns:[
	        		 {
                        title: "单选",
                        field: "select",
                        checkbox: true,
                        align: "center",//水平
                        valign: "middle"//垂直
	                 },{
	                	 title:"用户名",
	                	 field:"userName" 
	                 },{
	                	 title:"开始时间",
	                	 field:"start"
	                 },{
	                	 title:"结束时间",
	                	 field:"end"
	                 },{
	                	 title:"权限",
	                	 field:"auth"
	                 }
	        	]
	        });
		   //权限设定按钮
		   $('#grant').on('click',function(){
			   var data=[];
			   data=$('#user-data').bootstrapTable('getSelections');
			   if(data.length==0) {
				   alert("请先选中一位用户");
				   return false
				}
			   var userName=data[0].userName;
			   $('#myModal').modal({
				   backdrop:false
			   });
			   $('input[name=userName]').val(userName);
		   });
		   //查看资料按钮
		   $('#info').on('click',function(){
			   var data=[];
		   	   data=$('#user-data').bootstrapTable('getSelections');
		   	   if(data.length==0) {
		   		   alert("请先选中一位用户");
		   		   return false;
		   	   }
		   	   var userName=data[0].userName;
		   	   $.ajax({
		   		   url:"<%=basePath%>searchUserInfo",
		   		   data:{userName:userName},
		   		   success:function(res){
		   			   res=JSON.parse(res);
		   			   var msg=res.msg;
		   			   var htmlstr="<p>用户名："+res.userName+"</p>"+
   					   "<p>邮箱："+res.email+"</p>"+
   					   "<p>电话："+res.phone+"</p>";
   					   if(msg.length>0) 
   						   htmlstr+="<p>设定权限为"+
   						   "<span style='color:red'>"+res.auth+"</span>"+"的原因是："+"<br>"+msg+"</p>";
		   			   $('#body').html(htmlstr);
		   		   }
		   	   }) 
		   	   $('#infoModal').modal();
		   })
		})
	</script>
</body>
</html>
