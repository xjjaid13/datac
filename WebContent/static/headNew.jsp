<%@page import="com.util.Constant"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="shortcut icon" type="image/x-icon" href="http://localhost:8080/datac/image/littleCat.ico" media="screen" />
<link rel="stylesheet" type="text/css" href="http://netdna.bootstrapcdn.com/bootstrap/2.2.2/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="http://netdna.bootstrapcdn.com/bootstrap/2.2.2/css/bootstrap-responsive.css">
<link type="text/css" rel="stylesheet" href="${base}/css/global.css">
<link type="text/css" rel="stylesheet" href="${base}/css/face/<%=Constant.STYLE%>.css">
<div class="navbar navbar-fixed-top"> 
	<div class="navbar-inner" style="height:60px;">
		<div class="container">
			<div class="nav-collapse">
				<a class="brand" href="${base}/login/index" style="margin-left : 150px;margin-top:0;padding-top:0;">
					<img src="${base}/image/angryCat.png" style="height:50px;margin-top:5px;"/>
				</a>
				
				<c:choose>
					<c:when test="${user != null}">
						<ul class="nav pull-right" style="padding-top:10px;">
		            		<li class="dropdown">
		            			<a href="#" data-toggle="dropdown" class="dropdown-toggle" style="color : #8DD1FF;">${user.username}<b class="caret"></b></a>
								<ul aria-labelledby="drop5" role="menu" class="dropdown-menu" id="userInfo" style="background-color:#8DD1FF;font:12px/1.5 微软雅黑,Tahoma,Verdana,宋体">
				                    <li role="presentation"><a href="${base}/blog/${user.userId}" tabindex="-1" role="menuitem">我的博客</a></li>
				                    <li role="presentation"><a href="${base}/weblink/${user.userId}" tabindex="-1" role="menuitem">我的导航</a></li>
				                    <li role="presentation"><a href="${base}/note/${user.userId}" tabindex="-1" role="menuitem">我的便签</a></li>
				                    <li class="divider" role="presentation"></li>
				                    <li role="presentation"><a href="#" tabindex="-1" role="menuitem">退出</a></li>
				                </ul>
		            		</li>
		            	</ul>
					</c:when>
					<c:otherwise>
						<ul class="nav pull-right" style="padding-top:10px;">
							<li>
								<a href="${base}/login/index" style="color : #8DD1FF;">登陆</a>
							</li>
						</ul>
					</c:otherwise>
					
				</c:choose>

				<c:if test="${user != null}">
					
				</c:if>
				
			</div>
		</div>
	</div>
</div>