<?xml version="1.0" encoding="utf-8" ?>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" import="model.*,java.util.*,java.text.SimpleDateFormat"%>
<% 
	 HttpSession s = request.getSession();
	 String path = request.getContextPath();
	 String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	 Activitycontent activity=(Activitycontent)s.getAttribute("activity"); 
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>在身边</title>
	<link href="<%=basePath %>css/bootstrap.min.css" rel="stylesheet" /> 
	<link href="//cdn.bootcss.com/bootstrap-star-rating/4.0.1/css/star-rating.css" rel="stylesheet"/>
	<script src="//cdn.bootcss.com/jquery/2.0.0/jquery.min.js"></script>
	<script src="//cdn.bootcss.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
	<script src="<%=basePath%>js/jquery.base64.js"></script>
	<script src="//cdn.bootcss.com/bootstrap-star-rating/4.0.1/js/star-rating.js"></script>

	<%
		if(activity==null||activity.getStatus().equals("failed")||activity.getStatus().equals("waiting")){
	%>
		<script >window.location.href="<%=basePath%>norsc.jsp"</script>
	<%
		}
	%>
</head>
<body>
	<div id="header">
    <jsp:include page="./header.jsp" />
	</div>
	<%
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
		String location=activity.getLocation();
		int limitation=activity.getLimitation();
		String content=activity.getContent();
		Object un=s.getAttribute("userName");
		boolean flag=(un==null);
		String usnm="";
		if(!flag)usnm=(String)un;
		Date now=new Date();
		String state;
		int curnum=(s.getAttribute("numOfApply")==null)?0:(int)s.getAttribute("numOfApply");
		if(now.after(activity.getActend())) state="活动已结束";
		else if(now.after(activity.getActstart())&&now.before(activity.getActend())) state="活动进行中";
		else if(now.after(activity.getAplstart())&&now.before(activity.getAplend())) state="活动报名中";
		else if(now.before(activity.getActstart())&&now.after(activity.getAplend())) state="活动未开始";
		else state="报名未开始";
	%>
	<div class="container-fluid">
		<div class="row-fluid">
		<div class="title">
		活动详情<span style="font-weight:normal;color:wheat">【<%=state %>】</span>
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
			<button id="0th" class="btn btn-default" data-toggle="modal" data-target="#invite">邀请同伴</button>
			<a href="#" onclick="apply()" id="1st"><button class="btn btn-default" id="1stbtn">报名活动</button></a>
			<a href="<%=basePath %>pass?aid=<%=aid %>" id="2nd"><button class="btn btn-default">审核通过</button></a>
			<button id="3rd" class="btn btn-default" data-toggle="modal" data-target="#myModal">审核不通过</button>
		</div>
		<div style="display:none;margin:0 24%" id="ratebox">
			<div  style="display:inline-block;"><input id="rating" name="rating" class="rating"></input></div>
			<button class="btn btn-primary" style="display:inline-block;float:right" onclick="rating()">打分</button>
		</div>
		<div class="modal fade" id="invite" tabindex="-1" role="dialog" data-backdrop="false" aria-labelledby="inviteLabel" aria-hidden="true">
		   <div class="modal-dialog">
		      <div class="modal-content">
		         <div class="modal-header">
		            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
		                  &times;
		            </button>
		            <h4 class="modal-title" id="inviteLabel">邀请同伴</h4>
		         </div>
		         <div class="modal-body" style="padding:5px">
		         	<form id="invitefm" action="<%=basePath%>invite" >
		         	<input name="aid" value="<%=aid %>" style="display:none"></input>
		         	<label>同伴用户名</label>
		         	<input id="friend" name="receivernm" required  onchange="checkreceiver()"style="border:1px solid #e5e5e5;margin:1% 0"></input>
		            <p id="tip"></p>
		            <textarea required name="msg" style="border:1px solid #e5e5e5">我想邀请你一起参加这个活动，原因是：</textarea>
		            <input id="reset" name="reset" type="reset" style="display:none;" /> 
		            <font style="font-size:small;font-style:oblique;font-weight:bold">tip:成功后则当前页面刷新</font>
		            
		            </form>
		         </div>
		         <div class="modal-footer">
		            <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
		            <button form="invitefm" type="submit" class="btn btn-primary" onsubmit="checkflag">发送消息</button>
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
				<span class="ltitle">报名人数：</span><%=curnum %>/<%=limitation %>
			</div>
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
				<span class="ltitle">活动描述：</span><br></br>
				<div id="editor"/>
			</div>
		</div>

		<div id="cmtZone">
		<div class="title">评论区</div>
		
		<div style="margin:0 7%;width:80%">
		<div id="listOfCmt">
			<%
				List list=(List)s.getAttribute("comment");
				int cnt=0;
				if(list!=null&&list.size()!=0){
					Iterator it=list.iterator();
			%>
			<div class="cmt">
				<%
					while(it.hasNext()){
						cnt++;
						Message message=(Message)it.next();
						User sender=message.getSender();
						String sendername=sender.getUserName();
						String time=myFmt.format(message.getTime());
						String msg=message.getMsg();
						Long mid=message.getMid();
				%>
					<table style="width:100%;margin:2%;border:2px solid;padding:4px;border-collapse:separate">
						<tr>
						<td>#<%=cnt %></td>
						<td style="text-align:right">
						<a href="#comment" onclick="reply(<%=cnt%>,'<%=sender.getUserName()%>')"><span class="glyphicon glyphicon-file"></span></a>
						<%if(usnm.equals("admin")){ %>
						<a href="#" data-toggle="modal" onclick="openModal(<%=mid%>)"><span class="glyphicon glyphicon-remove-sign"></span></a>
						<%} %>
						</td>
						</tr>
						<tr>
						<td style="text-align:left"><font style="font-weight:bold;color:#5C70AB">评论者:</font><%=sendername %></td>
						<td style="text-align:right">评论时间:<%=time %></td>
						<hr></hr>
						</tr>
						<tr>
						<td><%=msg %></td>
						</tr>
					</table>
				<%
					}
				%>
			</div>
			<%
			}
			%>
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
		<div style="width:100%;margin:2%">
			<form id="cmtfm" action="submitComment" >
			  	<input name="aid" value="<%=aid %>" type="hidden"></input>
			  	<input id="forecmter" name="receivernm" type="hidden"></input>
			    <textarea required name="msg" placeholder="请填写你的评论" id="comment"></textarea>
			</form>
			<button form="cmtfm" type="submit" class="btn btn-default">提交评论</button>
		</div>
		</div>
	</div>
	</div>
	</div>
	<script type="text/javascript">
	var mode;
	var submitflag=false;
	$('#rating').rating({
		min:0,
		max:5,
		size:"sm",
		step:1,
		defaultCaption:"未打分",
		starCaptions: {1: '非常差', 2: '差', 3: '一般', 4: '好', 5: '非常好'},
	    starCaptionClasses: {1: 'text-danger', 2: 'text-warning', 3: 'text-info', 4: 'text-primary', 5: 'text-success'}
	})
	$(document).ready(function(){
		if(<%=(now.before(activity.getAplstart()))%>){
			$('#0th').hide();
			$('#1st').hide();
		}
			
		//如果当前时间早于活动开始时间，则发布者或管理员（admin）可以删除活动，发布者可以编辑活动
		if(<%=(now.before(activity.getActstart()))%>){
			if(<%=(usnm.equals(activity.getPublisher().getUserName()))%>){
				$('#editbtn').show();
				$('#deletebtn').show();
			}
			if(<%=usnm.equals("admin")%>)
				$('#deletebtn').show();
		}

		//如果已经报名，则key“in”对应的value为0~5之间的非负整数，
		//如果为0，则还未打分，可以打分
		//如果大于0，则显示已打过的分数
		if(<%=((int)s.getAttribute("in")>=0) %>){
			$('#1stbtn').html("取消报名");
			$('#ratebox').show();
			if(<%=((int)s.getAttribute("in")==0)%>) 
				$('#rating').val(0);
			else
				$('#rating').val(<%=(int)s.getAttribute("in") %>)
				.rating('refresh', {
				    disabled: true
				});
		}
		//一般隐藏审核按钮
		$('#2nd').hide();
		$('#3rd').hide();
		//如果用户是管理员且活动状态为waiting（待审核）则显示审核相关按钮，隐藏报名按钮和邀请按钮,隐藏评论区
		if('<%=(String)un%>'=='admin'&&<%=activity.getStatus().equals("waiting")%>){
			$('#0th').hide();
			$('#1st').hide();
			$('#2nd').show();
			$('#3rd').show();	
			$('#cmtZone').hide();
		}
		$('#editor').html($.base64.atob("<%=content%>", true));

		$('#invite').on('hidden.bs.modal', function () {
			  $('#reset').click();
			  var tip=document.getElementById("tip");
			  tip.innerHTML='';
			})

	});
	function rating(){
		$('#rating').rating('refresh', {disabled: true, showClear: false, showCaption: true});
		$.ajax({
			url:"<%=basePath%>rate",
			data:{rating:$('#rating').val(),aid:<%=aid%>},
			success:function(result){
				console.log(result);
			}
		});
	}
	function deleteAct(){
		$('#rmvfm').attr('action','<%=basePath%>rmvAct');
		$('#rmvcmt').modal({
			backdrop:false
		});
	}
	
	function checklogin(){
		if(<%=flag %>){
			alert("请先登录");
			setTimeout("top.location.href='" + "<%=basePath%>login.jsp" + "'", 3);
			return false;
		}
		return true;
	}
	//检验被邀请者的用户名是否存在
	function checkreceiver(){
		var tip=document.getElementById('tip');
		$.ajax({
			url:"<%=basePath%>checkUser",
			data:{userName:$("#friend").val()},
			success:function(res){
				if(res=="ok")
					tip.innerHTML='<font color="red">该用户不存在</font>';
				else if(res=="self")
					tip.innerHTML='<font color="red">不能邀请自己</font>';
				else {
					tip.innerHTML='';
					submitflag=true;
				}
			}
		})
	}
	function checkflag(){
		if(!submitflag) return false;
	}
	function apply(){
		if(<%=flag %>){
			alert("请先登录");
			setTimeout("top.location.href='" + "<%=basePath%>login.jsp" + "'", 3);
		}else{
			if(<%=(int)s.getAttribute("in")>=0%>){
				$.ajax({
					url:'<%=basePath%>cancel',
					data:{
						'aid':'<%=aid%>',
						'username':'<%=(String)un%>'
					},
					success:function(result){
						if(result=="late")
							alert("报名已结束，无法取消");
						else{
							alert("取消报名成功");
							setTimeout("window.location.href='"+"<%=basePath%>showActDetail?aid=<%=aid%>"+"'", 3);
						}
					}
				})
			}else{
				$.ajax({
					url:'<%=basePath%>apply',
					data:{
						'aid':'<%=aid%>',
						'username':'<%=(String)un%>'
						},
					success:function(result){
						if(result=="ok"){
							alert("报名成功");
							setTimeout("window.location.href='"+"<%=basePath%>showActDetail?aid=<%=aid%>"+"'", 3);
						}else if(result=="late"){
							alert("报名已结束");
						}else if(result=="exceed")
							alert("报名人数已满");
						else{
							console.log(result);
							alert("请勿重复报名");
						}
					}
				});
			}
		}
		}
	function openModal(mid){
		mode="cmt";
		$('#rmvcmt').modal({
			backdrop:false
		});
		$('input[name=mid]').val(mid);
	}
	function reply(floor,receiver){
		$('#comment').val("回复#"+floor+" "+receiver+":");
		$('#comment').html("");
		$('#forecmter').val(receiver);
		$('#comment').focus();
	}
	
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