<?xml version="1.0" encoding="utf-8" ?>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" import="model.*,java.text.SimpleDateFormat" %>
<% 
	 HttpSession s = request.getSession();
	 String path = request.getContextPath();
	 String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%> 
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>编辑活动_在身边</title>
	<link href="<%=basePath %>css/bootstrap-datetimepicker.css" rel="stylesheet"></link>
	<link href="<%=basePath %>css/bootstrap.min.css" rel="stylesheet" /> 
	<!-- <link href="../css/fileinput.css" /> -->
	<link href="//cdn.bootcss.com/summernote/0.8.2/summernote.css" rel="stylesheet" />
	<script src="http://libs.baidu.com/jquery/2.0.0/jquery.min.js"></script>
	<script src="http://libs.baidu.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
	<script src="<%=basePath%>js/jquery.base64.js"></script>
	<script src="<%=basePath %>js/bootstrap-datetimepicker.min.js"></script>
	<script src="<%=basePath %>js/bootstrap-datetimepicker.fr.js"></script>
	<script src="<%=basePath %>js/jquery.ajaxfileupload.js"></script>
	<script src="//cdn.bootcss.com/summernote/0.8.2/summernote.js"></script>
	<script src="//cdn.bootcss.com/summernote/0.8.2/lang/summernote-zh-CN.js"></script>
</head>
<body>
	<div id="header">
    <jsp:include page="../header.jsp" />
	</div>
	<%
	Activitycontent activity=(Activitycontent)s.getAttribute("activity");
	SimpleDateFormat myFmt=new SimpleDateFormat("yyyy-MM-dd hh:mm");	
	String aplstart=myFmt.format(activity.getAplstart());
	String aplend=myFmt.format(activity.getAplend());
	String actstart=myFmt.format(activity.getActstart());
	String actend=myFmt.format(activity.getActend());
	Long aid=activity.getAid();
	String posterpath=activity.getPosterpath();
	%>
	<div id="acfm">
	<div class="title">修改活动信息</div>	
	<form action="<%=basePath %>editActivity" id="actfm" method='post' enctype="multipart/form-data" data-toggle="validator" onsubmit="test()" role="form">	
  		<input name="aid" style="display:none" value="<%=aid%>"></input>
  		<div class="form-group">
    		<label for="name">活动标题</label>
    		<input type="text" class="form-control" placeholder="标题" name="head" required value="<%=activity.getHead() %>"></input>
  		</div>
  		<div class="form-group">
  			<label>活动类型</label>
  			<select class="form-control" name="category" required>
  				<option value=0>讲座</option>
  				<option value=1>招聘</option>
  				<option value=2>招新</option>
  				<option value=3>比赛</option>
  				<option value=4>游学</option>
  				<option value=5>艺术</option>
  				<option value=6>户外</option>
  				<option value=7>其他</option>
  			</select>
  		</div>
  		<div class="form-group">
  			<label for="name">地点</label>
  			<input type="text" class="form-control" placeholder="地点" name="location" required value="<%=activity.getLocation() %>"></input>
  		</div>
  		<div class="form-group">
			<label for="name">主办方</label>	
			<input type='text' class="form-control" placeholder="主办方" name="sponsor" required value="<%=activity.getSponsor() %>"></input>
		</div>
			
		<label for="name">时间节点</label>
		<div class="input-group date form_datetime form-group" style="margin:5px 0;width:50%"  >	
  		 	<input size="16" type="text"  name="aplstart" class="form-control" placeholder="开始报名" required value="<%=aplstart %>"></input>
  		 	<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
		</div>

		
		<div class="input-group date form_datetime form-group" style="margin:5px 0;width:50%" >
  		 	<input size="16" type="text"  name="aplend" class="form-control" placeholder="报名结束" required  value="<%=aplend%>"/>
  		 	<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
		</div>
		
		
		<div class="input-group date form_datetime form-group" style="margin:5px 0;width:50%" >
  		 	<input size="16" type="text"  name="actstart" class="form-control" placeholder="开始活动" required value="<%=actstart%>"/>
  		 	<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
		</div>
		
	
		<div class="input-group date form_datetime form-group" style="margin:5px 0;width:50%" >
  		 	<input size="16" type="text"  name="actend" class="form-control" placeholder="活动结束" required  value="<%=actend%>"/>
  		 	<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
		</div>	
		<div style="font-style:oblique;margin:10px"><span style="font-weight:bold">注意：</span>报名结束时间不得早于报名开始时间，活动结束时间不得早于活动开始时间，活动开始时间不得早于报名结束时间</div>
		<div class="form-group" style="width:50%">
			<label for="name">人数上限</label>
			<input type="number" class="form-control" name="limitation" required value="<%=activity.getLimitation()%>"></input>
		</div>
  		<div class="form-group">
  			<label for="summernote">活动描述</label>
  		<div id="summernote" name="content"></div>
  		</div>
  		<div class="form-group">
  			<label for="posterpath" class="control-label">活动海报</label>
  			<img src="<%=basePath%>upload/<%=aid%>/<%=posterpath %>" style="width:200px;height:auto;"></img>
  			<input type="file" name="poster" id="poster" class="file"  style="border:1px solid #cccccc"/>
  			<p style="font-style:oblique"><span style="font-weight:bold">注意：</span>上传文件大小不得大于10M</p>
  		</div>
  		<div class="form-group" style="text-align:center;">	
         	<button type="submit" class="btn btn-default" id="sbbtn">提交</button>	
  		</div>
  		</form>
 	</div>
 	<style type="text/css">
 		#acfm{
 			margin:5% 10%
 		}
 		.label{
 			font-size:larger;
 		}
 		.title{
 			font-size:20px;
 			font-weight:700;
 			background-color:#472F86;
 			color:white;
 			margin:10px 0;
 			padding:9px;
 		}
 	</style>
 	<script type="text/javascript">
 	$(document).ready(function(){
 		//登录检验
 		<% 
 			Object un=s.getAttribute("userName");
 			boolean flag=(un==null);
 		%>
 		if(<%=flag %>){
 			alert("请先登录后再进行此项操作。");
 			setTimeout("top.location.href='" + "<%=basePath%>login.jsp" + "'", 3);
 		}
 		//提交表单前验证日期
 		$('#actfm').on("submit",function(){
 			if($("input[name=aplstart]").val()>$("input[name=aplend]").val())
 				alert("报名截止时间不得早于报名开始时间！");
 			else if($("input[name=actstart]").val()<$("input[name=aplend]").val())
 				alert("活动开始时间不得早于报名截止时间！");
 			else if($("input[name=actstart]").val()>$("input[name=actend]").val())
 				alert("活动结束时间不得早于活动开始时间！");
 		});
 		
 		//初始化富文本框
 		$('#summernote').each(function() {
 	        var $this = $(this);
 	        $this.summernote({
 	            lang : 'zh-CN',
 	            minHeight : 200,
 	            dialogsFade : true,// Add fade effect on dialogs
 	            dialogsInBody : true,// Dialogs can be placed in body, not in
 	            toolbar: [
 	                    ['style', ['bold', 'italic', 'underline', 'clear']],
 	                    ['font', ['font']],
 	                    ['fontsize', ['fontsize']],
 	                    ['color', ['color']],
 	                    ['para', ['ul', 'ol', 'paragraph']],
 	                    ['insert',['hr','link']]
 	                  ]
 	           
 	        });
 	    });
 		$('#summernote').summernote('code',$.base64.atob("<%=activity.getContent()%>", true));
 		//将选择框中的值初始化
 		$("option").each(function(){
 			if($(this).val()==<%=activity.getCategory()%>)
 				$(this).attr('selected',true);
 		})
 	});
 	//初始化日期组件
  	$(".form_datetime").datetimepicker({
 		language:  'zh-CN', 
        autoclose: true,
        todayBtn: true,
        format:'yyyy-mm-dd hh:ii',
        pickerPosition: "bottom-left"
    }); 
 	//将富文本框中内容加入表单
	function test(){
		$.base64.utf8encode=true;
		var $this = $("#summernote");
		if(!$('#summernote').summernote("isEmpty")){
			var $form=$('#actfm');
 	        var editor= "<input type='hidden' name='" + $this.attr("name") + "' value='" +$.base64.btoa($this.summernote('code')) + "' />";
 	        var plain=$this.summernote('code').replace(/<\/?.+?>/g,"");
 	        var plaintext="<input type='hidden' name='plaintext' value='"+plain+"' />";
 	        $form.append(editor);
 	        $form.append(plaintext);
		}else{
			alert("请对活动进行描述！");
			return false;
		}
	}
	
 	</script>
</body>
</html>