<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>导航</title>
<link href="${base}/js/xDialog-master/xDialog.css" rel="stylesheet" type="text/css"/>
<link type="text/css" rel="stylesheet" href="${base}/css/weblink.css" />
<style>
    .liWeblink{
        background-color : #5692F5;
    }
    .tabContent a{
        color : white;
    }
</style>
</head>
<body>
<%@include file="../../static/headNew.jsp" %>
<div class="main">
	<div class="container" style="height:500px;">
		  	<ul class="nav nav-tabs">
		  		<li class="active"><a class="typeTab" attr="0">常用</a></li>
		    	<c:forEach items="${webLinkTypeList}" var="webLinktype" >
		       		 <li class="liWebType" attr="${webLinktype.webLinktypeId}">
		       		 	<a class="typeTab" attr="${webLinktype.webLinktypeId}">${webLinktype.name}</a>
		       		 </li>
		        </c:forEach>
	            <li id="lastType" class="dropdown">
		            <a href="#" data-toggle="dropdown" class="dropdown-toggle">选项 <b class="caret"></b></a>
		            <ul class="dropdown-menu" style="background-color:grey;">
			            <li><a id="addType" href="#">新增类型</a></li>
			            <li><a href="#">个人设置</a></li>
			            <li><a href="#">about</a></li>
		            </ul>
	            </li>
            </ul>
		    
		    <ul style="list-style:none;" id="type0" class="tabContent">
				 <li class="liWeblink">
					<a href="http://www.sina.com.cn">新浪 </a>
				 </li>
				 <li class="liWeblink">
					<a href="http://www.baidu.com">百度</a>
				 </li>
				 <li class="liWeblink">
					<a href="http://www.google.com">谷歌</a>
				 </li>
			 </ul>
		    
			<c:forEach items="${webLinkTypeList}" var="webLinktype" >
				 <ul style="display:none;list-style:none;" id="type${webLinktype.webLinktypeId}" class="tabContent">
					 <c:forEach items="${webLinktype.webLinkList}" var="webLink" >
						 <li class="liWeblink" attr="${webLink.webLinkId}">
								<a target="_blank" href="${webLink.link}">${webLink.name}</a>
						 </li>
					 </c:forEach>
					 <li class="liWeblink" id="lastLink"><a class="addNewLink" style="cursor:pointer;">添加</a></li>
				 </ul>
			</c:forEach>
	</div>
</div>
<div id="addNewLinkContent" style="display:none;">
	<div>名称: <input type="text" name="linkName" id="linkName"></div>
	<div>链接: <input type="text" name="link" id="link"></div>
</div>
<div id="addNewLinkType" style="display:none;">
	<div>名称: <input type="text" name="linkType" id="linkType"></div>
</div>
<%@include file="../../static/endNew.jsp" %>
<script src="${base}/js/xDialog-master/xDialog.js"></script>
<script>
	$(function(){
		$(".typeTab").click(function(){
			$(".nav-tabs li").removeClass("active");
			$(this).parent().addClass("active");
			$(".tabContent").hide();
			$("#type"+$(this).attr("attr")).show();
		}).css("cursor","pointer");
		
		$(".addNewLink").click(function(){
			var $this = $(this);
			var dialog = $.xDialog({
				title:'温馨提示',
				content:$("#addNewLinkContent"),
				ok:function(){
					var linkName = $(".xDialog #linkName").val();
					var link = $(".xDialog #link").val();
					var type = $(".active .typeTab").attr("attr");
					$.ajax({
						url : "${base}/weblink/addNewLink",
						data : "linkName="+linkName+"&link="+link+"&type="+type,
						type : 'post',
						dataType : 'html',
						success : function(data){
							$this.closest(".tabContent").find("#lastLink").before('<li class="liWeblink">'+
									'<a href="'+link+'">'+linkName+'</a>'+
									 '</li>');
							dialog.close();
						}
					});
					return false;
				},
				cancel:function(){
					return true;
				}
			});
		});
		$(".liWeblink").live("mouseenter",function(){
            $(this).prepend("<a class='deleteWeblink'>x</a>");
        }).live("mouseleave",function(){
            $(this).find(".deleteWeblink").remove();
        });
		$(".liWebType").hover(function(){
			$(this).prepend("<span class='deleteWeblinkType'>x</span>");
		},function(){
			$(this).find(".deleteWeblinkType").remove();
		});
		$(".deleteWeblink").live("click",function(){
			var $this = $(this);
            var webLinkId = $this.parent().attr("attr");
            $.ajax({
                url : '${base}/weblink/deleteLink?webLinkId='+webLinkId,
                success : function(data){
                    top.location.reload();
                }
            });
		});
		$(".deleteWeblinkType").live("click",function(){
			var $this = $(this);
			var webLinktypeId = $this.parent().attr("attr");
			$.xDialog({
		        title:'提示',
		        content:'删除该类型会删除其所有子链接，确认删除该类型？',
		        ok:function(){
		        	$.ajax({
		                url : '${base}/weblink/deleteLinkType?webLinktypeId='+webLinktypeId,
		                success : function(data){
		                    top.location.reload();
		                }
		            });
		        },
		        cancel:function(){
		           // alert('cancel');
		        }
		    });
		});
		$("#addType").click(function(){
			var dialog = $.xDialog({
				title:'温馨提示',
				content:$("#addNewLinkType"),
				ok:function(){
					var linkType = $(".xDialog #linkType").val();
					$.ajax({
						url : "${base}/weblink/addNewLinkType",
						data : "linkType="+linkType,
						type : 'post',
						success : function(data){
							top.location.reload();
						}
					});
					return false;
				},
				cancel:function(){
					return true;
				}
			});
		});
	});
</script>
</body>
</html>