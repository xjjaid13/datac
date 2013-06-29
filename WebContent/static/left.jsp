<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	.menu_left ul li{
		list-style : none;
		width : 100px;
		padding-top : 10px;
		padding-bottom : 5px;
	}
	.menu_left ul li a{
		padding-left : 15px;
	}
	.menu_left{
		width : 100px;
		float : left;
	}
</style>
<div class="menu_left">
	<ul class="menu_ul">
		<li class="addBlog"><a href="${base}/blog/my-addblog">添加博客</a></li>
		<li><a href="${base}/blog/my-blogList">博客列表</a></li>
		<li><a href="#">添加博客</a></li>
		<hr>
		<li><a href="#">个人信息</a></li>
		<li><a href="#">个人信息</a></li>
		<li><a href="#">个人信息</a></li>
	</ul>
</div>