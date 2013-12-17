<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html><head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>博客</title>
<link type="text/css" rel="stylesheet" href="${base}/css/blog.css">
<link href="${base}/js/levelMenu/levelMenu.css" rel="stylesheet" type="text/css"/>
<link href="${base}/js/xDialog-master/xDialog.css" rel="stylesheet" type="text/css"/>
<link type="text/css" rel="stylesheet" href="${base}/js/syntaxhighlighter_2.1.364/styles/shCore.css"/>
<link type="text/css" rel="stylesheet" href="${base}/js/syntaxhighlighter_2.1.364/styles/shThemeDefault.css"/>
<style>
	.menu_ul{      
		padding-left : 0px;
	}
	.title_div{
		padding-bottom : 15px;
	}
	.menu_ul .addBlog{
		background-color : grey;
	}
	.btnCode {
		background:transparent url(${base}/image/code.gif) no-repeat 16px 16px;
		background-position:2px 2px;
	}
</style>
</head>     
<body >
    <div>
    
    </div>
<%@include file="../../static/headNew.jsp" %>
<!-- end navbar -->
<div class="main">
	<div class="container">
	    <div class="span10" style="margin:-25px 0 0 0;padding:0px;">
			<div class="row span9">
				<div class="box-wrapper">
					<div class="span9" id="blogContent" style="border:5px solid #F3F3F3;border-radius:5px;display:table;padding:10px;">
						<a href="${base}/blog/list/${user.userId}">返回</a>
						<h4 align="center">${blog.title}</h4><br/>
						<div>${blog.content}</div>
					</div>
				</div><!-- end  -->
			</div><!-- row -->
	    </div>
		<div class="span2" id="menu">
        	<div id="recordWrap">
				<div id="toolDiv" class="span2" style="margin-left:0;margin-top:-20px;">
					<div id="timeMenu">
				        <ul id="timeTree">
				        </ul>
				    </div>
				    <div id="recordDiv">
				    	
				    </div>
				</div>
			</div>
        </div>
	</div><!-- end container -->
</div><!-- end main -->

<%@include file="../../static/endNew.jsp" %>
</body>
<!-- js Boots_from -->
<script src="${base}/js/levelMenu/levelMenu.js"></script>
<script src="${base}/js/sticky/jquery.sticky.js"></script>
<script type="text/javascript" src="${base}/js/syntaxhighlighter_2.1.364/scripts/shCore.js"></script>
<script type="text/javascript" src="${base}/js/syntaxhighlighter_2.1.364/scripts/shBrushes.js"></script>
<script>
	SyntaxHighlighter.config.clipboardSwf = '${base}/js/syntaxhighlighter_2.1.364/scripts/clipboard.swf';
	SyntaxHighlighter.all();
	$(function(){
	    $("#toolDiv").sticky({ topSpacing: 85, center:true, className:"hey" });
		
		$("#timeTree").levelMenu({
		    yearUrl : '${base}/blog/returnTreeYear',
	        monthUrl : '${base}/blog/returnTreeMonth',
	        dayUrl : '${base}/blog/returnTreeDay'
		});
	});
</script>
<!-- end Boots_from -->
</html>
