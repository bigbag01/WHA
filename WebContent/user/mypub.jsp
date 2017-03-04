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
	<script src="//cdn.bootcss.com/jquery/2.0.0/jquery.min.js"></script>
	<script src="//cdn.bootcss.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
	<script src="//cdn.bootcss.com/bootstrap-table/1.11.0/bootstrap-table.js"></script>
	<script src="//cdn.bootcss.com/bootstrap-table/1.11.0/locale/bootstrap-table-zh-CN.js"></script>

	<title>在身边</title>
</head>
<body>
	<div id="header">
    <jsp:include page="../header.jsp" />
	</div>
	<div class="container-fluid">
	<div class="row-fluid">
		<h2 style="text-align:center;font-weight:600;color:#777777">所有我发布的活动</h2>
		<jsp:include page="../sidebar.jsp" />
		<div  style="display:inline-block;margin:0 5%;width:70%">
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
		<%
			List list=(List)s.getAttribute("myPub");
			if(list!=null&&list.size()!=0){
				Iterator it=list.iterator();
		%>	
			<div class="title">通过审核的活动</div>
			<div class="panel-group" id="accordion">
				<%
					while(it.hasNext()){
						Activity activity=(Activity)it.next();
						String posterpath=activity.getPosterpath();
						String status=activity.getStatus();
						Long aid=activity.getAid();
						String head=activity.getHead();
						if(status.equals("passed")){
				%>
					<div class="panel panel-default">
					
					<div class="actbox panel-heading">
					<img src="<%=basePath%>upload/<%=aid %>/<%=posterpath%>"/>
					<div class="hdbtn">
					<p><%=head %></p>
					<div class="mybtns">
						<a href="#collapse<%=aid %>" data-toggle="collapse" data-parent="#accordion" onclick="showsth(<%=aid %>)" class="btn btn-default mybtn">报名详情</a>
						<a href="<%=basePath%>showActDetail?aid=<%=aid%>" class="btn btn-default mybtn">活动详情</a>
					</div>
					</div>
					</div>
					
					<div id="collapse<%=aid%>" class="panel-collapse collapse ">
					 <div class="panel-body">
						<div id="toolbar<%=aid %>" >
							<button id="refuse<%=aid %>" class="btn btn-danger refuse" disabled onclick="refuse(<%=aid%>)">
								<i class="glyphicon glyphicon-remove"></i> 拒绝
							</button>
							<button id="info" class="btn btn-default" onclick="seeinfo(<%=aid %>)">资料</button>
						</div>
						<table id="grid-data<%=aid %>" class="table table-condensed table-hover table-striped" ></table>	
					 </div>
					</div>
					</div>
				<%
						}
					}
				%>
			</div>

			<div class="title">待审核的活动</div>
			<div class="panel-group" id="accordion">
				<%
					it=list.iterator();
					while(it.hasNext()){
						Activity activity=(Activity)it.next();
						String posterpath=activity.getPosterpath();
						String status=activity.getStatus();
						String head=activity.getHead();
						Long aid=activity.getAid();
						if(status.equals("waiting")){
				%>
					<div class="panel panel-default">
					<div class="actbox panel-heading">
					<img src="<%=basePath%>upload/<%=aid %>/<%=posterpath%>"/>
					<div class="hdbtn">
					<p><%=head %></p>
					<div class="mybtns">
						<a href="<%=basePath%>showActDetail?aid=<%=aid%>&res=preview" class="btn btn-default mybtn">活动详情</a>
					</div>
					</div>
					</div>
					</div>
				<%
						}
					}
				%>
			</div>
			<div class="title">未通过审核的活动</div>
			<div class="panel-group" id="accordion">
				<%
					it=list.iterator();
					while(it.hasNext()){
						Activity activity=(Activity)it.next();
						String posterpath=activity.getPosterpath();
						String status=activity.getStatus();
						String head=activity.getHead();
						Long aid=activity.getAid();
						if(status.equals("failed")){
				%>
					<div class="panel panel-default">
					<div class="actbox panel-heading">
					<img src="<%=basePath%>upload/<%=aid %>/<%=posterpath%>"/>
					<div class="hdbtn">
					<p><%=head %></p>
					<div class="mybtns">
						<a href="<%=basePath%>showActDetail?aid=<%=aid%>" class="btn btn-default mybtn">活动详情</a>
						<a href="#back<%=aid %>" data-toggle="collapse" data-parent="#accordion" onclick="showback(<%=aid %>)" class="btn btn-default mybtn">反馈详情</a>
					</div>
					</div>
					</div>
					<div id="back<%=aid%>" class="panel-collapse collapse ">
					<div class="panel-body">
					  <p id="msg<%=aid%>"></p>
					</div>
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
	<style >
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
 			vertical-align:-webkit-baseline-middle;
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
 		.mybtn{
 			display:inline-block;
 			margin:5px;
 		}
 		.mybtns{
 			display:inline-block;	
 		}
 		.hdbtn{
 			display:inline-block;
 			vertical-align:-webkit-baseline-middle;
 		}
	</style>
	<script type="text/javascript"> 
	function showsth(id){
        $('#grid-data'+id).bootstrapTable({
        	url:"<%=basePath%>showAppliers?aid="+id,
        	locale:'zh-CN',
        	clickToSelect:true,
        	singleSelect:false,
        	toolbar:'#toolbar'+id,
        	columns:[
        		 {
                 title: "全选",
                 field: "select",
                 checkbox: true,
                 align: "center",//水平
                 valign: "middle"//垂直
                 },{
                	 title:"用户名",
                	 field:"userName" 
                 },{
                	 title:"性别",
                	 field:"gender"
                 },{
                	 title:"邮箱",
                	 field:"email"
                 },{
                	 title:"电话",
                	 field:"phone"
                 }
        	],
        	formatNoMatches: '目前无报名者'
        	
        });
	}
	var selections=[];
	$('.table').on('check.bs.table uncheck.bs.table ' +
            'check-all.bs.table uncheck-all.bs.table', function () {
        $('.refuse').prop('disabled', !$('.table').bootstrapTable('getSelections').length);
    });
	function refuse(id){
		selections=$('#grid-data'+id).bootstrapTable('getSelections');
		var ids=[];
		for(var i=0;i<selections.length;i++){
			ids[i]=selections[i].userName;
		}
		ids=JSON.stringify(ids);
		$.ajax({
			url:"<%=basePath%>refuse",
			data:{data:ids,aid:id},
			success:function(res){
				if(res=='ok'){
					$('#grid-data'+id).bootstrapTable('refresh',{silent:true});
				}
				else if(res=='late')
					alert("活动已开始，无法筛选报名者");
				else alert(res);
			}
		})
	}

	function showback(id){
		$.ajax({
			url:"<%=basePath%>getMsg",
			data:{aid:id},
			success:function(msg){
				var obj=$('#msg'+id);
				obj.html("审核不通过原因："+msg);
			}
		})
	}
	 //查看资料按钮
	   function seeinfo(id) {
		   var data=[];
	   	   data=$('#grid-data'+id).bootstrapTable('getSelections');
	   	   if(data.length==0) {
	   		   alert("请先选中一位用户");
	   		   return false;
	   	   }
	   	   if(data.length>1){
	   		   alert("请不要选中多个用户");
	   		   return false;
	   	   }
	   	   var userName=data[0].userName;
	   	   $.ajax({
	   		   url:"<%=basePath%>searchUserInfo",
	   		   data:{userName:userName},
	   		   success:function(res){
	   			   res=JSON.parse(res);
	   			   var msg=res.msg;
	   			   var htmlstr="<p>用户名："+res.userName+"</p>"
	   			   +"<p>当前权限为"+res.auth+"</span>";
				   if(msg.length>0) 
					   htmlstr+="<p>设定权限为"+
					   "<span style='color:red'>"+res.auth+"</span>"+"的原因是："+"<br>"+msg+"</p>";
	   			   $('#body').html(htmlstr);
	   		   }
	   	   }) 
	   	   $('#infoModal').modal();
	   }
	</script>
</body>
</html>