<?xml version="1.0" encoding="utf-8" ?>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" import="model.*,java.util.*,java.text.SimpleDateFormat"%>
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
	<link href="//cdn.bootcss.com/bootstrap-star-rating/4.0.1/css/star-rating.css" rel="stylesheet"/>
	<script src="http://libs.baidu.com/jquery/2.0.0/jquery.min.js"></script>
	<script src="http://libs.baidu.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
	<script src="<%=basePath%>js/jquery.base64.js"></script>
		<%if(s.getAttribute("userName")==null){ %>
			<script >window.location.href="<%=basePath%>nologin.jsp"</script>
		<% }%>
</head>

<body>
	<div id="header">
    <jsp:include page="./header.jsp" />
	</div>
	<%
		Activitycontent activity=(Activitycontent)s.getAttribute("activity"); 
		if(activity==null) return;
		Long aid=activity.getAid();
		String posterpath=activity.getPosterpath();
		String src;
		if(posterpath!=null)
			src=basePath+"upload/"+String.valueOf(aid)+"/"+posterpath;
		else src=basePath+"upload/default.jpg";
		String head=activity.getHead();
		String category;
		switch(activity.getCategory()){
		case 0:category="讲座";break;
		case 1:category="招聘";break;
		case 2:category="招新";break;
		case 3:category="比赛";break;
		case 4:category="游学";break;
		case 5:category="艺术";break;
		case 6:category="户外";break;
		default:category="其他";
		}
		SimpleDateFormat myFmt=new SimpleDateFormat("yyyy年MM月dd日 HH:mm");
		String aplstart=myFmt.format(activity.getAplstart());
		String aplend=myFmt.format(activity.getAplend());
		String actstart=myFmt.format(activity.getActstart());
		String actend=myFmt.format(activity.getActend());
		String sponsor=activity.getSponsor();
		String publisher=activity.getPublisher().getUserName();
		String location=activity.getLocation();
		int limitation=activity.getLimitation();
		String content=activity.getContent();
		Object un=s.getAttribute("userName");
		boolean flag=(un==null);
		String usnm="";
		if(!flag)usnm=(String)un;
	%>
	<div class="container-fluid">
		<div class="row-fluid">
		<div class="title">
		活动详情<span style="font-weight:normal;color:wheat">【预览】</span>
		<a href='<%=basePath%>showActDetail?aid=<%=aid%>&res=edit' id="editbtn" style="display:none;color:white"><span class="glyphicon glyphicon-pencil" style="float:right;margin:5px"></span></a>
		<a href="#" id="deletebtn" style="display:none;color:white" onclick="deleteAct()" data-toggle="modal"><span class="glyphicon glyphicon-trash" style="float:right;margin:5px"></span></a>
		</div>
		<div style="padding-left:9px;font-size:16px;font-weight:600;color: #5C70A3;">
		活动类型 : <span style="font-weight:500;color: #777777;"><%=category %></span>
		</div>
		<div id="head"><%=head %></div>
		<div id="poster_con">
			<img src="<%=src %>" id="poster"></img>
		</div>
		<div style="text-align:center;margin:10px" id="butns">
			<a href="<%=basePath %>pass?aid=<%=aid %>" id="2nd"><button class="btn btn-default">审核通过</button></a>
			<button id="3rd" class="btn btn-default" data-toggle="modal" data-target="#myModal">审核不通过</button>
		</div>
		<div class="modal fade" id="rmvcmt" tabindex="-1" role="dialog" data-backdrop="false" aria-labelledby="rmvcmtLabel" aria-hidden="true">
		   <div class="modal-dialog">
		      <div class="modal-content">
		         <div class="modal-header">
		            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
		                  &times;
		            </button>
		            <h4 class="modal-title" id="rmvcmtLabel">反馈信息</h4>
		         </div>
		         <div class="modal-body" style="padding:5px">
		         	<form id="rmvfm" action="<%=basePath%>rmvCmt" >
		         	<input name="mid"  style="display:none"></input>
		         	<input name="aid" value="<%=aid%>" style="display:none"/>
		            <textarea required name="msg" style="border:0" placeholder="删除原因"></textarea>
		            </form>
		         </div>
		         <div class="modal-footer">
		            <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
		            <button form="rmvfm" type="submit" class="btn btn-primary">提交反馈</button>
		         </div>
		      </div><!-- /.modal-content -->
			</div><!-- /.modal-dialog -->
		</div>
	
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog" data-backdrop="false" aria-labelledby="myModalLabel" aria-hidden="true">
		   <div class="modal-dialog">
		      <div class="modal-content">
		         <div class="modal-header">
		            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
		                  &times;
		            </button>
		            <h4 class="modal-title" id="myModalLabel">反馈信息</h4>
		         </div>
		         <div class="modal-body" style="padding:5px">
		         	<form id="msgfm" action="<%=basePath%>fail" >
		         	<input name="aid" value="<%=aid %>" style="display:none"></input>
		            <textarea required name="msg" style="border:0">【<%=head %>】未通过审核，原因是：</textarea>
		            </form>
		         </div>
		         <div class="modal-footer">
		            <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
		            <button form="msgfm" type="submit" class="btn btn-primary">提交反馈</button>
		         </div>
		      </div><!-- /.modal-content -->
			</div><!-- /.modal-dialog -->
		</div>
		<hr></hr>
		<div id="actinfo">
			<div class="info">
				<p><span class="ltitle">报名开始：</span><%=aplstart %></p>
				<p><span class="ltitle">报名结束：</span><%=aplend %></p>
				<p><span class="ltitle">活动开始：</span><%=actstart %></p>
				<p><span class="ltitle">活动结束：</span><%=actend %></p> 
			</div>
			<div class="info" >
				<span class="ltitle">地点：</span><%=location %>
			</div>
			<div class="info" >
				<span class="ltitle">主办方：</span><%=sponsor %>
			</div>
			<div class="info" >
				<span class="ltitle">活动描述：</span><div id="editor"/>
			</div>
		</div>
		
	</div>
	</div>
	<script>
	function deleteAct(){
		$('#rmvfm').attr('action','<%=basePath%>rmvAct');
		$('#rmvcmt').modal({
			backdrop:false
		});
	}
	$(document).ready(function(){
		//一般隐藏审核按钮
		$('#2nd').hide();
		$('#3rd').hide();
		//如果用户是活动发布者，显示修改删除活动按钮
		if(<%=((String)un).equals(publisher)%>){
			$('#editbtn').show();
			$('#deletebtn').show();
		}
		//如果用户是管理员且活动状态为待审核
		if('<%=(String)un%>'=='admin'){
			if(<%=activity.getStatus().equals("waiting")%>){
				$('#2nd').show();			
				$('#3rd').show();
				$('#deletebtn').show();
			}
		}
		$('#editor').html($.base64.atob("<%=content%>", true));
	})
	</script>
	<style>
		.info{
			text-align:start;
			margin-bottom:20px;
			margin:2% 10%;
		}
		#head{
			font-size:30px;
			text-align:center;
			font-weight:bold;
		}
		#poster_con{
			padding: 0.5em;
			text-align: center; 
			display: block; 
			vertical-align:middle;	
		}
		#poster{ 
			width:200px;
			height:auto;
			vertical-align: middle;
		}
		hr{
			margin:2% 20%;
			border-top: 1px solid #E7E7E7;
		}
		textarea{
			width:100%;
			height:80px;
		}
		.title{
 			font-size:20px;
 			font-weight:700;
 			background-color:#472F86;
 			color:white;
 			padding:9px;
 			margin-bottom:10px;
 		}
 		.ltitle{
 			font-size:16px;
 			font-weight:600;
 			color: #5C70A3;
 		}
	</style>
</body>
</html>