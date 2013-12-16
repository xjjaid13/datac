<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html><head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>博客</title>
<link type="text/css" rel="stylesheet" href="${base}/css/blog.css">
<link href="${base}/js/levelMenu/levelMenu.css" rel="stylesheet" type="text/css"/>
<link href="${base}/js/xDialog-master/xDialog.css" rel="stylesheet" type="text/css"/>
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
<input type="hidden" name="page" value="${page+1}" >
<%@include file="../../static/headNew.jsp" %>
<!-- end navbar -->
<div class="main">
	<div class="container">
	    <div class="span10" style="margin:0px;padding:0px;">
	    	<div class="row span9 hide">
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
					<div class="row" style="padding:20px;">
						<div class="title span12">
							<c:if test="${isOperator}">
								<div>
									<a id="addBlog" class="pointer">新增博客</a>
								</div>
							</c:if>
							
						</div><!-- end title -->
					</div>
					<ul class="thumbnails thumbnails-horizontal" id="blogContent">
						
					</ul>
					<div id="bottomClass" style="position:fixed;bottom:0;">
						<div class="row span9" style="text-align:right;">
							<div id="pagination" class="navigation pagination" style="margin:0 30px;">
								
	   						</div>
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
					#blogType#
				</span>
				<span class="number-view pull-right"><i class="icon-white icon-eye-open"></i>#createDate#</span>
			</p>
		</div>
		<div class="operate box border-radius-bottom">
			<a style="left:20px;" attr="#bgArticleId#" class="modifyBlog">修改</a>
			<a style="right:20px;" attr="#bgArticleId#" class="deleteBlog">删除</a>
		</div>
	</li>
</ul>
<div id="blogContentWrap" class="hide">
	<div>
		<div class="row-fluid" style="padding-top:20px;height:430px;overflow:auto;">
			<div class="span1"></div>
			<div class="span10">
				<div>
					<select id="article_type" style="width:70px;">
						<option value="0">原创</option>
						<option value="1">转载</option>
						<option value="2">翻译</option>
					</select>
					<input type="text" id="title" class="input_class">
				</div>
				<div class="title_div">
					<textarea id="content" name="content" rows="22" cols="80" style="width: 100%; height : 300px;"></textarea>
				</div>
				<div><label class="pull-left" style="padding:4px 6px;">关键字： </label><input type="text" class="input_class" name="keyword" id="keyword"></div>
			</div>
		</div>
	</div>
</div>
<%@include file="../../static/endNew.jsp" %>
</body>
<!-- js Boots_from -->
<script src="${base}/js/pagination/jquery.pagination.js"></script>
<script src="${base}/js/levelMenu/levelMenu.js"></script>
<script src="${base}/js/xDialog-master/xDialog.js"></script>
<script type="text/javascript" src="${base}/js/xheditor-1.2.1/xheditor-1.2.1.min.js"></script>
<script type="text/javascript" src="${base}/js/xheditor-1.2.1/xheditor_lang/zh-cn.js"></script>
<script type="text/javascript" src="${base}/js/xheditor-1.2.1/xheditor.js"></script>
<script src="${base}/js/sticky/jquery.sticky.js"></script>
<script>
	$(function(){
	    $("#toolDiv").sticky({ topSpacing: 70, center:true, className:"hey" });
		 
		$("#recordDiv").levelMenu({
		    yearUrl : '${base}/blog/returnTreeYear',
	        monthUrl : '${base}/blog/returnTreeMonth',
	        dayUrl : '${base}/blog/returnTreeDay'
		});
		
		var editor;
		$("#addBlog").click(function(){
		    $.xDialog({
			    title:'新增博客',
			    content:$("#blogContentWrap").html(),
			    width : 900,
			    popCallBack : function(){
			        editor = $('.xDialog #content').xheditor({plugins:plugins,tools:'Source,|,Fontface,FontSize,Bold,Italic,Underline,Strikethrough,FontColor,BackColor,|,Removeformat,Align,List,|,Link,Unlink,Img,Flash,Media,|,Hr,Emot,Table,Code,|,Preview,Fullscreen,About',skin:'o2007silver',showBlocktag:false,forcePtag:false,emotMark:true});
			    },
			    ok : function(){
			        var title = $(".xDialog #title").val();
			    	var content = editor.getSource();
			    	var article_type = $(".xDialog #article_type").html();
			    	var keyword = $(".xDialog #keyword").val();
			    	if(title == "" || $.trim(content) == "<br>"){
			    	    alert("请输入标题或者内容");
			    	}else{
				        $.post('${base}/blog/my-addblog-post',{ title: title,keyword : keyword, content: content,article_type : article_type }, function(data) {
				    	    closeDialog();
						    returnBlogList();
				    	});
			    	}
			    	return false;
			    }
			});
		})
		 
		$(".deleteBlog").live("click",function(){
			 $.ajax({
				 url : '${base}/blog/del-article?ids='+$(this).attr("attr"),
				 success : function(data){
					 location.href = location.href;
				 }
			 });
		});
		 
		$(".modifyBlog").live("click",function(){
			 var bgArticleId = $(this).attr("attr");
			 $.ajax({
				 url : '${base}/blog/returnSingleArticle.action',
				 data : 'bgArticleId='+bgArticleId,
				 type : 'post',
				 dataType : 'json',
				 success : function(ajaxData){
					 var data = ajaxData.data;
					 $.xDialog({
					     title:'修改博客',
					     content:$("#blogContentWrap").html(),
					     width : 900,
					     popCallBack : function(){
					    	 editor = $('.xDialog #content').xheditor({plugins:plugins,tools:'Source,|,Fontface,FontSize,Bold,Italic,Underline,Strikethrough,FontColor,BackColor,|,Removeformat,Align,List,|,Link,Unlink,Img,Flash,Media,|,Hr,Emot,Table,Code,|,Preview,Fullscreen,About',skin:'o2007silver',showBlocktag:false,forcePtag:false,emotMark:true});
					    	 $(".xDialog #title").val(data.title);
							 $(".xDialog #article_type").val(data.article_type);
							 $(".xDialog #keyword").val(data.keyword);
					    	 editor.setSource(data.content);
					     },
					     ok : function(){
					    	 var title = $(".xDialog #title").val();
					    	 var content = editor.getSource();
					    	 var article_type = $(".xDialog #article_type").html();
					    	 var keyword = $(".xDialog #keyword").val();
					    	 if(title == "" || $.trim(content) == "<br>"){
					    	 	alert("请输入标题或者内容");
					    	 }else{
						    	 $.post('${base}/blog/my-addblog-post',{ title: title,keyword : keyword, content: content,article_type : article_type }, function(data) {
						    		 closeDialog();
								     returnBlogList();
						    	 });
					    	 }
					    	 return false;
					     }
					 });
				 }
			 });
		});
		returnBlogList(1);
		
	});
	
	var init = false;
	function returnBlogList(startPage){
		$.ajax({
			url : '${base}/blog/returnBlogList',
			data : {startPage : startPage , recordNum : 10},
			dataType : 'json',
			success : function(ajaxData){
				$("#pagination").pagination(ajaxData.recordSum,{
				    current_page : startPage - 1,
				    callback : function(startPage){
				    	startPage++;
				    	returnBlogList(startPage);
					}
				});
				var dataList = ajaxData.dataList;
				var content = "";
				var blogWrap = $("#blogWrap").html();
				for(var i = 0; i < dataList.length; i++){
					var tempWrap = blogWrap;
					var blog = dataList[i];
					var shortContent = blog.shortContent;
					var bgArticleId = blog.bgArticleId;
					var title = blog.title;
					var blogType = blog.blogType == 0;
					if(blogType == 0){
						blogType = '原';
					}else if(blogType == 1){
						blogType = '转';
					}else if(blogType == 2){
						blogType = '译';
					}
					var createDate = blog.createDate;
					tempWrap = tempWrap.replace(/#shortContent#/,shortContent);
					tempWrap = tempWrap.replace(/#bgArticleId#/g,bgArticleId);
					tempWrap = tempWrap.replace(/#blogTitle#/,title);
					tempWrap = tempWrap.replace(/#blogType#/,blogType);
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
