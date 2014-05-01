<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>导航</title>
<link type="text/css" rel="stylesheet" href="${base}/css/common.css" />
<script src="http://code.jquery.com/jquery-1.8.3.min.js"></script>
<c:if test="${view == 0}">
<link rel="stylesheet" href="${base}/js/jquery-ui/themes/base/jquery.ui.all.css">
<script src="${base}/js/jquery-ui/ui/jquery.ui.core.js"></script>
<script src="${base}/js/jquery-ui/ui/jquery.ui.widget.js"></script>
<script src="${base}/js/jquery-ui/ui/jquery.ui.mouse.js"></script>
<script src="${base}/js/jquery-ui/ui/jquery.ui.sortable.js"></script>
<script src="${base}/js/jquery-ui/ui/jquery.ui.droppable.js"></script>
<script src="${base}/js/jquery-ui/ui/jquery.ui.button.js"></script>
<script src="${base}/js/jquery-ui/ui/jquery.ui.draggable.js"></script>
<script src="${base}/js/jquery-ui/ui/jquery.ui.position.js"></script>
<script src="${base}/js/jquery-ui/ui/jquery.ui.resizable.js"></script>
<script src="${base}/js/jquery-ui/ui/jquery.ui.button.js"></script>
<script src="${base}/js/jquery-ui/ui/jquery.ui.dialog.js"></script>
<script src="${base}/js/jquery-ui/ui/jquery.ui.effect.js"></script>
<script>
	$(function(){
		var deleteDiv = $("#deleteDiv").html();
		$(document).on( "mouseenter", ".panel .panel-content li", function() {
			$(this).addClass("active").append(deleteDiv);
		}).on( "mouseleave", ".panel .panel-content li", function() {
			$(this).removeClass("active").find(".deleteUrl").remove();
		}).on( "click", ".panel .panel-content li", function() {
			window.open($(this).attr("attr"));
		});
		
		var startIndex = 0;
		var oringType = 0;
		
		$( ".panel-content ul" ).sortable({
			placeholder: "sort-placeholder",
			connectWith: ".connectedSortable",
			start : function(event, ui){
				startIndex = ui.item.index();
				oringType = ui.item.closest('.panel').attr('attr');
			},
			stop : function(event, ui){
				var item = ui.item;
				item.removeClass("active").find(".deleteUrl").remove();
				var currentType = item.closest('.panel').attr('attr');
				if(item.index() != startIndex || oringType != currentType){
					$.ajax({
						url : '${base}/weblink/updateWebLinkData',
						data : 'handleType=webLink&fromIndex='+startIndex+'&toIndex='+item.index()+'&typeIndex='+currentType+'&oringType='+oringType,
						type : 'post',
						dataType : 'json',
						success : function(ajaxData){
							
						}
					});
				}
			}
		});
		$( ".main" ).sortable({
			placeholder: "main-sort-placeholder",
			start : function(event, ui){
				startIndex = ui.item.index();
			},
			stop : function(event, ui){
				var item = ui.item;
				var toIndex = item.index();
				$.ajax({
					url : '${base}/weblink/updateWebLinkData',
					data : 'handleType=webLinktype&fromIndex='+startIndex+'&toIndex='+toIndex,
					type : 'post',
					dataType : 'json',
					success : function(ajaxData){
						
					}
				});
			}
		});
		
		$(".addType").click(function(){
			$(this).hide();
			$(".inputType").show().find("input").focus();
		});
		
		$("#addType").click(function(){
			$("#addUrlTypeDiv" ).dialog({
				autoOpen: true,
				height: 170,
				width: 350,
				modal: true,
				buttons: {
					"保存": function() {
						var typeName = $("#typeName").val();
						if($.trim(typeName) == ''){
							alert('类型不能为空');
							return false;
						}
						var $thisDialog = $(this);
						$.ajax({
							url : '${base}/weblink/addWebLinkData',
							data : 'handleType=webLinktype&title='+typeName,
							type : 'post',
							dataType : 'json',
							success : function(ajaxData){
								var typeSize = $(".panel").size();
								$(".main").append('<div class="panel" attr="'+typeSize+'">'
										+'<div class="panel-heading">'+typeName+'<a class="addUrl">+</a></div>'
										+'<div class="panel-content">'
										+'<ul></ul></div></div>');
								$thisDialog.dialog( "close" );
							}
						});
					},
					"取消": function() {
						$( this ).dialog( "close" );
					}
				}
			});
		});
		
		$(document).on("click",".addUrl",function(){
			var $this = $(this);
			$( "#addUrlDiv" ).dialog({
				autoOpen: true,
				height: 220,
				width: 350,
				modal: true,
				buttons: {
					"保存": function() {
						var urlName = $("#urlName").val();
						var url = $("#url").val();
						if($.trim(urlName) == ''){
							alert('标题不能为空');
							return false;
						}
						if($.trim(url) == ''){
							alert('url不能为空');
							return false;
						}
						var $thisDialog = $(this);
						$.ajax({
							url : '${base}/weblink/addWebLinkData',
							data : 'handleType=webLink&title='+urlName+'&url='+url+'&typeIndex='+$this.closest(".panel").attr("attr"),
							type : 'post',
							dataType : 'json',
							success : function(ajaxData){
								var webLink = ajaxData.webLink;
								
								var content = '';
								content += '<li attr="'+url+'">';
								content += '<span title="'+webLink.name+'">';
								if(webLink.name.length > 16){
									content += webLink.name.substring(0,16) + '...';
								}else{
									content += webLink.name;
								}
								content += '</span></li>';
								$this.closest(".panel").find(".panel-content ul").append(content);
								$("#urlName").val("");
								$("#url").val("");
								$thisDialog.dialog( "close" );
							}
						});
					},
					"取消": function() {
						$( this ).dialog( "close" );
					}
				}
			});
		}).on("click",".deleteUrl",function(){
			var deleteLi = $(this).closest("li");
			var urlIndex = deleteLi.index();
			var typeIndex = deleteLi.closest(".panel").index();
			$.post("${base}/weblink/my-deleteWebLink",{webLinkId:deleteLi.attr("attrid"),urlIndex:urlIndex,typeIndex:typeIndex},function(){
				deleteLi.fadeOut().remove();
			});
			event.stopPropagation();
		}).on("click",".deleteType",function(){
			if(confirm("sure delete?")){
				var deleteDiv = $(this).closest(".panel");
				var typeIndex = deleteDiv.index();
				$.post("${base}/weblink/my-deleteWebLinktype",{webLinktypeId:deleteDiv.attr("attrid"),typeIndex:typeIndex},function(){
					deleteDiv.slideUp().remove();
				});
			}
		});
		
	});
</script>
</c:if>
<c:if test="${view != 0}">
<script>
	$(function(){
		$(document).on( "mouseenter", ".panel .panel-content li", function() {
			$(this).addClass("active");
		}).on( "mouseleave", ".panel .panel-content li", function() {
			$(this).removeClass("active");
		}).on( "click", ".panel .panel-content li", function(event) {
			window.open($(this).attr("attr"));
		});
	});
</script>
</c:if>
<style>
	.main-sort-placeholder{
		border: 1px dashed #808080;
    	height: 30px;
	}
	.panel{
		width : 100%;
		background-color : white;
		border : 1px solid #EDEDED;
	}
	.panel .panel-heading{
		padding : 10px 15px;
		background-color : #EDEDED;
	}
	.panel .panel-content{
		padding : 5px;
		background-color:wheat;
	}
	.panel-content ul{
		content : "";
		display : table;
	}
	.panel-content ul li{
		float : left;
		padding : 5px;
		border : 1px solid transparent;
		cursor : pointer;
		padding-right : 25px;
		position : relative;
	}
	.panel-content ul .sort-placeholder{
		border: 1px dashed #808080;
	    height: 25px;
	    margin-right: 15px;
	    padding: 0;
	    width: 80px;
	}
	.panel-content .active{
		background-color : #EDEDED;
		border : 1px solid grey;
	}
	.panel-content .active .deleteUrl{
		background-color : #FAFAFA;
		border : 1px solid grey;
		padding : 0 3px;
		position : absolute;
		right : 2px;
		top : 5px;
		display : block;
		border-radius : 3px;
		text-decoration : none;
	}
	.addUrl,.deleteType{
		background-color : #FAFAFA;
		border : 1px solid grey;
		padding : 0 3px;
		border-radius : 3px;
		text-decoration : none;
		text-decoration : none;
		cursor : pointer;
	}
	.panel-content .active a:hover{
		background-color : #FFFFFF;
	}
	.hide{
		display : none;
	}
	label{
		display : block;
	}
	.textClass{
		border:1px solid #EDEDED;
		padding:0 6px;
		height : 30px;
		width : 95%;
	}
	#addType{
		width : 100%;
		height : 30px;
		background-color : #EDEDED;
		padding-top: 7px;
    	text-align: center;
    	cursor : pointer;
	}
	.placeHolderPadding{
		padding:1px 20px;
	}
</style>
</head>
<body>
<c:if test="${view == 0}">
	<div id="deleteDiv" class="hide">
		<a class="deleteUrl">×</a>
	</div>
	<div id="addUrlTypeDiv" class="hide" title="新增类型">
		<label for="typeName">名称</label>
		<input type="text" class="textClass" id="typeName" name="typeName">
	</div>
	<div id="addUrlDiv" class="hide" title="新增链接">
		<label for="urlName"><font color=red>*</font>名称</label>
		<input type="text" class="textClass" id="urlName" name="urlName">
		<label for="url"><font color=red>*</font>链接</label>
		<input type="text" class="textClass" value="" id="url" name="url">
	</div>
</c:if>
<div class="main">
	<c:forEach items="${webLinktypeList}" var="webLinktype" varStatus="linkType" >
		<div class="panel" attr='${linkType.index}' attrid='${webLinktype.webLinktypeId}'>
			<div class="panel-heading">${webLinktype.name}
			<c:if test="${view == 0}">
				<a class="addUrl">+</a>
				<a class="deleteType">×</a>
			</c:if>
			</div>
			<div class="panel-content">
				<c:choose>
					<c:when test="${webLinktype.webLinkList == null || webLinktype.webLinkList[0].name == null}">
						<ul class="connectedSortable placeHolderPadding">
						</ul>
					</c:when>
					<c:otherwise>
						<ul class="connectedSortable placeHolderPadding">
							<c:forEach items="${webLinktype.webLinkList}" var="webLink" >
								<li attr="${webLink.link}" attrid="${webLink.webLinkId}">
									<span title="${webLink.name}">
										<c:choose>
										   <c:when test="${fn:length(webLink.name) > 16}">
										   	   <c:out value="${fn:substring(webLink.name, 0, 16)}..." /> 
										   </c:when>
										   <c:otherwise>
										       ${webLink.name}
										   </c:otherwise>
										</c:choose>
									</span>
								</li>
							</c:forEach>
						</ul>
				   </c:otherwise>
				</c:choose>
			</div>
		</div>
	</c:forEach>
</div>
<c:if test="${view == 0}">
	<div id="addType">+</div>
</c:if>
</body>
</html>