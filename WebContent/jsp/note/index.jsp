<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="${base}/css/common.css" rel="stylesheet" type="text/css"/>
<link href="${base}/js/xDialog-master/xDialog.css" rel="stylesheet" type="text/css"/>
<style>
    #noteContent{
        width : 90%;
        height : 150px;
        background-color : #a3b2b5;
    }
    .divBtn{
        background-color : #94A5B5;
        border-radius:5px;
        cursor : pointer;
    }
</style>
</head>
<body>
<%@include file="../../static/headNew.jsp" %>
<div class="main">
    <div style="position:fixed;width:95%;height:300px;background-color:#5692F5;
        border-radius:5px;text-align:center;padding:15px;
        box-shadow:0 0 10px #06C;top:-268px;" id="noteContentDiv">
        <textarea style="width:100%;height:100%;margin:0px;padding:0px;" id="noteContent"></textarea>
        <div style="position:absolute;right:20px;bottom:-25px;height:30px;
            background-color:#5692F5;width:100px;border-radius:5px;line-height:30px;">
            <div id="addNoteBtn">新建笔记</div>
        </div>
    </div>
    <div class="container" style="height:500px;">
        <ul>
            <c:forEach var="item" items="${noteList}" varStatus="status">
                <li>${status.index+1} ${item.content}</li>
            </c:forEach>
        </ul>
    </div>
</div>
<div>
    
</div>
<%@include file="../../static/endNew.jsp" %>
<script>
    $(function(){
    	$("#addNoteBtn").hover(function(){
    		$(this).addClass("divBtn");
    		$("#noteContentDiv").css({"background-color":"#94A5B5"});
    	},function(){
    		$(this).removeClass("divBtn");
    		$("#noteContentDiv").css({"background-color":"#5692F5"});
    	}).click(function(){
    		var $noteContent = $("#noteContentDiv");
    		if($noteContent.css("top") == '60px'){
    			alert($("#noteContent").val());
    			$.ajax({
                    url : '${base}/note/my-addNote',
                    data : 'content='+$("#noteContent").val(),
                    type : 'post',
                    dataType : 'json',
                    success : function(data){
                        alert(data.message);
                    }
                });
    			$("#noteContentDiv").animate({"top":"-268px"});
    		}else{
	    		$("#noteContentDiv").animate({"top":"60px"});
    		}
    	});
    });
</script>
</body>
</html>