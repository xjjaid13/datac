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
</head>
<body>
<%@include file="../../static/headNew.jsp" %>
<div class="main">
    <div class="container" style="height:500px;">
        <div id="inputArea">
            <textarea id="noteContent"></textarea>
            <input id="addNoteContent" type="button" value="提交"/>
        </div>
    </div>
</div>
<%@include file="../../static/endNew.jsp" %>
<script>
    for(var i = 0; i < 10; i++){
    	$.ajax({
    		url : '${base}/note/test',
    		data : 'test='+i
    	});
    }
</script>
</body>
</html>