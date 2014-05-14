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
<link type="text/css" rel="stylesheet" href="${base}/css/weblinkNew.css" />
<script src="http://code.jquery.com/jquery-1.8.3.min.js"></script>
<script src="${base}/js/cookie/jquery.cookie.js"></script>
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
		
		$(".addType").click(function(){
			var $this = $(this);
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
								var index = (parseInt(typeSize) - 1);
								$this.before('<div class="panel-heading headShadow'+typeSize+' fl" attr="'+ index +'">'
										+'<div>'+typeName+'<a class="deleteType">×</a></div></div>');
								$(".panel").append("<div class='panel panel-content control"+index+" hide' attr='"+index+"'>"
										+"<ul class='connectedSortable placeHolderPadding'></ul></div>");
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
		
		$(document).on("click","#addUrl",function(){
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
							data : 'handleType=webLink&title='+urlName+'&url='+url+'&typeIndex='+tabIndex,
							type : 'post',
							dataType : 'json',
							success : function(ajaxData){
								var webLink = ajaxData.webLink;
								var content = '';
								content += '<li attr="'+url+'" >';
								content += '<span title="'+webLink.name+'">';
								if(webLink.name.length > 16){
									content += webLink.name.substring(0,16) + '...';
								}else{
									content += webLink.name;
								}
								content += '</span></li>';
								alert(tabIndex);
								$(".control"+tabIndex).find("ul").append(content);
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
			$.post("${base}/weblink/my-deleteWebLink",{urlIndex:urlIndex,typeIndex:typeIndex},function(){
				deleteLi.fadeOut().remove();
			});
			event.stopPropagation();
		}).on("click",".deleteType",function(){
			if(confirm("sure delete?")){
				var deleteDiv = $(this).closest(".panel");
				var typeIndex = deleteDiv.index();
				$.post("${base}/weblink/my-deleteWebLinktype",{typeIndex:typeIndex},function(){
					deleteDiv.slideUp().remove();
				});
			}
		}).on("mouseenter",".panel-heading",function(){
			$(this).find(".deleteType").show();
		}).on("mouseleave",".panel-heading",function(){
			$(this).find(".deleteType").hide();
		}).on( "mouseenter", ".panel .panel-content li", function() {
			$(this).addClass("active").append(deleteDiv);
		}).on( "mouseleave", ".panel .panel-content li", function() {
			$(this).removeClass("active").find(".deleteUrl").remove();
		}).on( "click", ".panel .panel-content li", function() {
			window.open($(this).attr("attr"));
		});;
		
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
<script>
	var tabIndex;
	$(function(){
		tabIndex = $.cookie('tabIndex');
		if(tabIndex == undefined){
			tabIndex = "0";
		}
		$(".control" + tabIndex).show();
		$(".headShadow" + tabIndex).addClass("thistab");
		$(document).on("click",".panel-heading",function(){
			$(".headShadow" + tabIndex).removeClass("thistab");
			$(".control" + tabIndex).hide();
			$(this).addClass("thistab");
			tabIndex = $(this).attr("attr");
			$(".control" + tabIndex).show();
			$.cookie('tabIndex',tabIndex,{
				expires : 7
			});
		});
	});
</script>
</head>
<body>
<c:if test="${view == 0}">
	<div id="deleteDiv" class="hide">
		<a class="deleteUrl"><img src="${base}/image/opt/remove.png"></a>
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
	<div class="panel">
		<ul class="head">
			<c:forEach items="${webLinktypeList}" var="webLinktype" varStatus="linkType" >
				<li class="panel-heading headShadow${linkType.index} fl" attr="${linkType.index}">
					<div>
						${webLinktype.name}
						<c:if test="${view == 0}">
							<a class="deleteType" style="position:absolute;right:0;">
								<img src="${base}/image/opt/remove.png">
							</a>
						</c:if>
					</div>
				</li>
			</c:forEach>
			<li class="fl addType"><img src="${base}/image/opt/add.png"></li>
		</ul>
		<c:forEach items="${webLinktypeList}" var="webLinktype" varStatus="linkType" >
			<div class="panel panel-content control${linkType.index} hide" attr='${linkType.index}' >
				<c:choose>
					<c:when test="${webLinktype.webLinkList == null || webLinktype.webLinkList[0].name == null}">
						<ul class="connectedSortable placeHolderPadding">
						</ul>
					</c:when>
					<c:otherwise>
						<ul class="connectedSortable placeHolderPadding">
							<c:forEach items="${webLinktype.webLinkList}" var="webLink" >
								<li attr="${webLink.link}" >
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
		</c:forEach>
	</div>
</div>
<c:if test="${view == 0}">
	<div id="addUrl"><img style="margin-top:7px;" src="${base}/image/opt/add.png"></div>
</c:if>
</body>
</html>