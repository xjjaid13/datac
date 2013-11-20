<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${base}/js/flexgrid/flexigrid.css">
<style>
	.main{
		margin-left : 40px;
		margin-right : 40px;
		border : 1px solid grey;
		border-radius : 3px 3px 3px 3px;
	}
	.content_main{
		float : left;
		padding : 20px;
	}
	.menu_ul{
		padding-left : 0px;
	}
	.input_class{
		width : 500px;
		padding : 3px;
		background-color : #FFFFFF;
		border-radius : 3px 3px 3px 3px;
		border : 1px solid #AAAAAA;
	}
	.title_div{
		padding-bottom : 20px;
	}
	.menu_ul .addBlog{
		background-color : grey;
	}
</style>
</head>
<body>
<%@include file="../../static/headNew.jsp" %>
	
	<div class="main">
		<div class="main_content row-fluid">
			<div class="span2"></div>
			<div class="span9">
				<div class="content_main">
					<table id="flex1" style="display:none"></table>
				</div>
				<div style="clear:both;"></div>
			</div>
		</div>
		
	</div>
	
	<%@include file="../../static/endNew.jsp" %>

</body>
<script type="text/javascript" src="${base}/js/flexgrid/flexigrid.js"></script>
<script>
	$(function(){
		$("#flex1").flexigrid({
			url: '${base}/blog/my-blogListist',
			dataType: 'json',
			colModel : [
				{display: '标题', name : 'title', width : 600, sortable : false, align: 'left'},
				{display: '创建时间', name : 'createDate', width : 200, sortable : false, align: 'left'},
				{display: '操作', name : 'ids', width : 200, sortable : false, align : 'middle'}
			],
			sortname: "id",
			sortorder: "DESC",
			usepager: true,
			title: 'title',
			useRp: true,
			rp: 15,
			width: 1000,
			height: 400,
			onSuccess : function(){
				$(".alterArticle").bind("click",function(){
					var id = $(this).parent().attr("attr");
					//id = $("#flex1 :checked").val();
					if(id == ""){
						alert("请选择要修改的文章");
						return false;
					}
					location.href = "${base}/blog/my-updateArticle/" + id;
				});
				$(".delArticle").bind("click",function(){
					var id = $(this).parent().attr("attr");
					$.ajax({
						url : "${base}/blog/del-article",
						data : "ids="+id,
						success : function(data){
							$("#flex1").flexReload();
						}
					});
				});
			}
		});
	});
	
</script>
</html>