<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>导航</title>
<link href="${base}/js/xDialog-master/xDialog.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<%@include file="../../static/headNew.jsp" %>
<link type="text/css" rel="stylesheet" href="${base}/css/weblink.css" />
<div class="main">
	<div class="container">
		  	<ul class="nav nav-tabs chat-tabs">
		  		<li class="liWebType" attr="-1"><a class="typeTab pointer" attr="0">常用</a></li>
		    	<c:forEach items="${webLinkTypeList}" var="webLinktype" >
		       		 <li class="liWebType" attr="${webLinktype.webLinktypeId}">
		       		 	<a class="typeTab pointer" attr="${webLinktype.webLinktypeId}">${webLinktype.name}</a>
		       		 </li>
		        </c:forEach>
	            <li id="lastType" class="dropdown">
		            <a href="#" >+</a>
	            </li>
            </ul>
		    
		    <ul style="list-style:none;" id="type0" class="tabContent hide">
				 <li class="liWeblink">
				    <div class="linkTitle">baidu</div>
				    <div class="linkContent"><a href="www.baidu.com">baidu</a></div>
				    <div class="linkBottom"></div>
				 </li>
			 </ul>
		    
			<c:forEach items="${webLinkTypeList}" var="webLinktype" >
				 <ul style="list-style:none;" id="type${webLinktype.webLinktypeId}" class="tabContent hide">
					 <c:forEach items="${webLinktype.webLinkList}" var="webLink" >
						 <li class="liWeblink" attr="${webLink.webLinkId}" id="webLink${webLink.webLinkId}">
						    <div class="linkTitle"><img class="iconClass" width="16" height="16" style="padding-top:3px;margin-right:5px;" src="${webLink.icon}" />
						    	<span title="${webLink.name}" class="webLinkName">
							    	<c:choose>
									   <c:when test="${fn:length(webLink.name) > 16}">
									   	   <c:out value="${fn:substring(webLink.name, 0, 16)}..." /> 
									   </c:when>
									   <c:otherwise>
									       ${webLink.name}
									   </c:otherwise>
									</c:choose>
						    	</span>
						    </div>
						    <div class="linkContent" style="padding-left:15px;padding-right:15px;">
						    	<a style="color:black;" title="${webLink.description}" class="webLinkDescription" href="${webLink.link}">
						    		<c:choose>
									   <c:when test="${fn:length(webLink.description) > 64}">
									   	   <c:out value="${fn:substring(webLink.description, 0, 64)}..." /> 
									   </c:when>
									   <c:otherwise>
									       ${webLink.description}
									   </c:otherwise>
									</c:choose>
						        </a>
						    </div>
						    <div class="linkBottom"><span><a class="pointer weblinkConfig">设置</a></span></div>
						 </li>
					 </c:forEach>
					 <li class="liWeblink" id="lastLink"><a class="addNewLink pointer">添加</a></li>
				 </ul>
			</c:forEach>
	</div>
</div>
<div id="webListWrap" class="hide">
	<div><input type="text" placeHolder="请输入网址" style="width:95%;margin:0px;" name="webLinkContent" id="webLinkContent" /></div>
</div>
<%@include file="../../static/endNew.jsp" %>
<script src="${base}/js/xDialog-master/xDialog.js"></script>
<script src="${base}/js/cookie/jquery.cookie.js"></script>
<script>
		
	$(function(){
		resetHeight();
		$(window).resize(function(){
			resetHeight();
		});
		var tabIndex = $.cookie('tabIndex');
		if(tabIndex == undefined){
			tabIndex = "0";
		}
		$("#lastType").click(function(){
			var $this = $(this);
			$.ajax({
				url : '${base}/weblink/my-addWebLinktype',
				dataType : 'json',
				success : function(ajaxData){
					var content = "<li class='liWebType' attr='"+ajaxData.webLinktype.webLinktypeId+"'><input class='tempInput' type='text' value='自定义' /></li>";
					$this.before(content);
					$(".tempInput").select();
				}
			});
		});
		$(".tempInput").live("blur",function(){
			var $this = $(this);
			var name = $this.val();
			var webLinktypeId = $this.parent().attr("attr");
			$.ajax({
				url : '${base}/weblink/my-updateWebLinktype',
				data : {name:name,webLinktypeId:webLinktypeId},
				dataType : 'json',
				success : function(ajaxData){
					if(ajaxData.result == 'success'){
						$this.parent().html('<a class="typeTab pointer" attr="'+webLinktypeId+'">'+name+'</a>');
					}
				}
			});
			
		});
		$(".typeTab[attr="+tabIndex+"]").parent().addClass("active");
		$("#type"+tabIndex).show();
		$(".typeTab").live("click",function(){
			$(".nav-tabs li").removeClass("active");
			$(this).parent().addClass("active");
			$(".tabContent").hide();
			var tabIndex = $(this).attr("attr");
			$("#type"+tabIndex).show();
			$.cookie('tabIndex',tabIndex,{
				expires : 7
			});
		});
		
		$(".weblinkConfig").live("click",function(){
			var $this = $(this);
			$.xDialog({
			    title:'设置链接',
			    content:$("#webListWrap").html(),
			    popCallBack : function(){
			    	$(".xDialog #webLinkContent").focus();
			    },
			    width : 300,
			    ok : function(){
			    	var webLinkId = $this.closest(".liWeblink").attr("attr");
			        var webLinkContent = $(".xDialog #webLinkContent").val();
			        var webLinkTypeId = $(".container .nav .active").attr("attr");
			    	if(webLink == ""){
			    	    alert("请输入内容");
			    	}else{
				        $.ajax({
				        	url : '${base}/weblink/my-updateWebLink',
				        	data : 'webLinkContent='+webLinkContent+"&webLinkId="+webLinkId,
				        	type : 'post',
				        	dataType : 'json',
				        	success : function(ajaxData){
				        		if(ajaxData.name.length > 15){
					        		$("#webLink" + webLinkId).find(".webLinkName").html(ajaxData.name.substring(0,15) + "...");
				        		}else{
					        		$("#webLink" + webLinkId).find(".webLinkName").html(ajaxData.name);
				        		}
				        		$("#webLink" + webLinkId).find(".webLinkName").attr("title",ajaxData.name);
				        		$("#webLink" + webLinkId).find(".iconClass").attr("src",ajaxData.icon);
				        		if(ajaxData.description.length > 64){
					        		$("#webLink" + webLinkId).find(".webLinkDescription").html(ajaxData.description.substring(0,64) + "...");
				        		}else{
				        			$("#webLink" + webLinkId).find(".webLinkDescription").html(ajaxData.description);
				        		}
				        		$("#webLink" + webLinkId).find(".webLinkDescription").attr("title",ajaxData.description);
				        		$("#webLink" + webLinkId).find(".webLinkDescription").attr("href", ajaxData.link);
				        		
				        		closeDialog();
				        	}
				        });
			    	}
			    	return false;
			    }
			});
		});
	});
	function resetHeight(){
		$(".tabContent").css("height",$(window).height()-60-37);	
	}
</script>
</body>
</html>