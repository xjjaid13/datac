<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html><head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>博客</title>
<link type="text/css" rel="stylesheet" href="${base}/css/blog.css">
</head>     
     
<body >
    <div>
    
    </div>
<input type="hidden" name="page" value="${page+1}" >
<%@include file="../../static/headNew.jsp" %>
<!-- end navbar -->
<div class="main">
	<div class="container">
		<div class="row">
			<div class="box-wrapper span12">
				<div class="widget">
					<div class="wrapper-search">
						<form class="form-inline form-search border-rd4" action="${base}/blog/index/${userid}" method="post">
							<input type="hidden" name="page" value="${page+1}" >
							<input type="text" class="box-text" name="keyword" id="keyword" value="${keyword}" placeholder="请输入查询内容">
							<a class="btn-search" href="#"></a>
						</form>
					</div>
				</div>
			</div><!-- end box-wrapper -->
			
		</div>
		<div class="row">
			<div class="box-wrapper  span12">
				
				<div class="row">
					<div class="title span12">
						<c:if test="${isOperator}">
							<div>
								<a href="${base}/blog/my-addblog">新增博客</a>
							</div>
						</c:if>
						
					</div><!-- end title -->
				</div>
				<ul class="thumbnails thumbnails-horizontal">
					<c:forEach items="${blogList}" var="blog" >
					
						<li class="span3 contentMain" style="position:relative;">
							<div class="thumbnail border-radius-top">
								<div class="bg-thumbnail-img">
									<div>${blog.shortContent}</div>
								</div>
								<h5><a href="${base}/blog/article/${blog.bgArticleId}">${blog.title}</a></h5>
							</div>
							<div class="box border-radius-bottom">
								<p>
									<span class="title_torrent pull-left">
										<c:choose><c:when test="${blog.articleType==0}">原</c:when>
											 <c:when test="${blog.articleType==1}">转</c:when>
											 <c:when test="${blog.articleType==2}">译</c:when>
										</c:choose>
									</span>
									<span class="number-view pull-right"><i class="icon-white icon-eye-open"></i>${blog.createDate}</span>
								</p>
							</div>
							<div class="operate box border-radius-bottom">
								<a style="left:20px;" href="${base}/blog/my-updateArticle/${blog.bgArticleId}">修改</a>
								<a style="right:20px;" attr="${blog.bgArticleId}" class="delete">删除</a>
							</div>
						</li>
					</c:forEach>
					
				</ul>
				<div class="row">
					<div class="span12">
						<div id="pagination" class="navigation pagination pull-right">
							
   						</div>
					</div><!-- end navigation -->
				</div>
			</div><!-- end  -->
			
		</div><!-- row -->
				
	</div><!-- end container -->
</div><!-- end main -->
<%@include file="../../static/endNew.jsp" %>
</body>
<!-- js Boots_from -->
<script src="${base}/js/pagination/jquery.pagination.js"></script>
<script>
$(function(){
	 $("#pagination").pagination(${countArticle},{current_page:${page},callback : function(){
		 var page = 0;
		 $(".active").each(function(){
			 var $thisPage = $(this);
			 if($thisPage.attr("class") == "active"){
				 page = $thisPage.children().html();
			 }
		 })
		 location.href = "${base}/blog/${userid}?page="+page;
	 }});
	 <c:if test="${user != null}">
	 $(".contentMain").mouseenter(function(event){
		 $(this).closest("li").find(".operate").fadeIn();
		 event.preventDefault();
	 }).mouseleave(function(event){
		 $(this).closest("li").find(".operate").fadeOut();
		 event.preventDefault();
	 });
	 </c:if>
	 
	 $(".delete").click(function(){
		 $.ajax({
			 url : '${base}/blog/del-article?ids='+$(this).attr("attr"),
			 success : function(data){
				 location.href = location.href;
			 }
		 });
	 });
});
</script>
<!-- end Boots_from -->
</html>
