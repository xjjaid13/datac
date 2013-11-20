<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link type="text/css" rel="stylesheet" href="${base}/js/syntaxhighlighter_2.1.364/styles/shCore.css"/>
<link type="text/css" rel="stylesheet" href="${base}/js/syntaxhighlighter_2.1.364/styles/shThemeDefault.css"/>
<script type="text/javascript" src="${base}/js/syntaxhighlighter_2.1.364/scripts/shCore.js"></script>
<script type="text/javascript" src="${base}/js/syntaxhighlighter_2.1.364/scripts/shBrushes.js"></script>
<script type="text/javascript">
    SyntaxHighlighter.config.clipboardSwf = '${base}/js/syntaxhighlighter_2.1.364/scripts/clipboard.swf';
    SyntaxHighlighter.all();
</script>
<style>
	.main_content{
		margin-left : 50px;
		padding : 50px;
		width : 100%;
		margin-top:50px;
		color : black;
	}
</style>
</head>
<body>

	<%@include file="../../static/headNew.jsp" %>
	<div class="main">
		<div class="main_content row-fluid">
			<div class="span2"></div>
			<div class="span9">
				<div id="title" style="font-size:15px;font-weight:bold;padding-bottom:20px;">${article.title}</div>
				<div id="content">${article.content}</div>
			</div>
			<div class="span1"></div>
		</div>
	</div>
	<%@include file="../../static/endNew.jsp" %>
	<script>
		
	</script>
</body>
</html>