<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html><head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>博客</title>
<link type="text/css" rel="stylesheet" href="${base}/css/blog.css">
<link href="${base}/js/levelMenu/levelMenu.css" rel="stylesheet" type="text/css"/>
<style>
    #content{
        width : 90%;
        height : 150px;
        background-color : #a3b2b5;
    }
    .divBtn{
        background-color : #8DD1FF;
        border-radius:5px;
        cursor : pointer;
    }
    .flowClass{
        padding : 10px;
        margin : 5px;
        background-color : wheat;
        word-break : break-all;
        border-radius:5px;
        box-shadow:0px 0px 10px #258ff2;
    }
    
</style>
</head>     
<body >
    <div>
    
    </div>
<input type="hidden" name="page" value="${page+1}" >
<%@include file="../../static/headNew.jsp" %>
<!-- end navbar -->
<div class="main">
	<div class="container">
	    <div class="span10" style="margin:0px;padding:0px;">
	    	<div class="row span9">
				<div class="box-wrapper">
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
			<div class="row span9">
				<div class="box-wrapper">
					
					<div class="row">
						<div class="title span12">
							<c:if test="${isOperator}">
								<div>
									<a href="${base}/blog/my-addblog">新增博客</a>
								</div>
							</c:if>
							
						</div><!-- end title -->
					</div>
					<ul class="thumbnails thumbnails-horizontal" id="blogContent">
						
						
						
					</ul>
					<div class="row span9" style="text-align:center;">
						<div id="pagination" class="navigation pagination">
							
   						</div>
					</div>
				</div><!-- end  -->
				
			</div><!-- row -->
	    </div>
		<div class="span2" id="menu">
        	<div id="recordWrap">
				<div id="toolDiv" class="span2" style="margin-left : 0;">
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
<ul id="blogWrap" class="hide">
	<li class="span3 contentMain" style="position:relative;">
		<div class="thumbnail border-radius-top">
			<div class="bg-thumbnail-img">
				<div>#shortContent#</div>
			</div>
			<h5><a href="${base}/blog/article/#bgArticleId#">#blogTitle#</a></h5>
		</div>
		<div class="box border-radius-bottom">
			<p>
				<span class="title_torrent pull-left">
					#articleType#
				</span>
				<span class="number-view pull-right"><i class="icon-white icon-eye-open"></i>#createDate#</span>
			</p>
		</div>
		<div class="operate box border-radius-bottom">
			<a style="left:20px;" href="${base}/blog/my-updateArticle/#bgArticleId#">修改</a>
			<a style="right:20px;" attr="#bgArticleId#" class="delete">删除</a>
		</div>
	</li>
</ul>
<%@include file="../../static/endNew.jsp" %>
</body>
<!-- js Boots_from -->
<script src="${base}/js/pagination/jquery.pagination.js"></script>
<script src="${base}/js/levelMenu/levelMenu.js"></script>
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
	 
	 $("#recordDiv").levelMenu({
		 yearUrl : '${base}/blog/returnTreeYear',
         monthUrl : '${base}/blog/returnTreeMonth',
         dayUrl : '${base}/blog/returnTreeDay'
	 });
	 
	 $(".delete").live("click",function(){
		 $.ajax({
			 url : '${base}/blog/del-article?ids='+$(this).attr("attr"),
			 success : function(data){
				 location.href = location.href;
			 }
		 });
	 });
	 
	 returnBlogList();
});
function returnBlogList(){
	$.ajax({
		url : '${base}/blog/returnBlogList',
		data : {page : 1 , recordNum : 10},
		dataType : 'json',
		success : function(data){
			var dataList = data.dataList;
			var content = "";
			var blogWrap = $("#blogWrap").html();
			for(var i = 0; i < dataList.length; i++){
				var tempWrap = blogWrap;
				var blog = dataList[i];
				var shortContent = blog.shortContent;
				var bgArticleId = blog.bgArticleId;
				var title = blog.title;
				var articleType = blog.articleType == 0;
				if(articleType == 0){
					articleType = '原';
				}else if(articleType == 1){
					articleType = '转';
				}else if(articleType == 2){
					articleType = '译';
				}
				var createDate = blog.createDate;
				tempWrap = tempWrap.replace(/#shortContent#/,shortContent);
				tempWrap = tempWrap.replace(/#bgArticleId#/g,bgArticleId);
				tempWrap = tempWrap.replace(/#blogTitle#/,title);
				tempWrap = tempWrap.replace(/#articleType#/,articleType);
				tempWrap = tempWrap.replace(/#createDate#/,createDate);
				content += tempWrap;
			}
			$("#blogContent").html(content);
			<c:if test="${user != null}">
			$(".contentMain").mouseenter(function(event){
			    $(this).closest("li").find(".operate").fadeIn();
			    event.preventDefault();
			}).mouseleave(function(event){
			    $(this).closest("li").find(".operate").fadeOut();
			    event.preventDefault();
			});
			</c:if>
		}
	});
}
</script>
<!-- end Boots_from -->
</html>
