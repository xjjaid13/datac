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
<link rel="stylesheet" href="http://jquery-ui-bootstrap.github.io/jquery-ui-bootstrap/css/custom-theme/jquery-ui-1.10.3.custom.css">
<link rel="stylesheet" href="http://jquery-ui-bootstrap.github.io/jquery-ui-bootstrap/assets/css/bootstrap.min.css">
<link rel="stylesheet" href="http://cdn.bootcss.com/font-awesome/3.0.2/css/font-awesome.min.css">

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
<script src="http://jquery-ui-bootstrap.github.io/jquery-ui-bootstrap/assets/js/vendor/bootstrap.js"></script>
<script>
	$(function(){
		var startIndex = 0;
		var oringType = 0;
		
		$("#nav>ul").sortable();
		
		$(".nav-panel").sortable({
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
		
		$("#addUrlTypeDiv" ).dialog({
			autoOpen: false,
			width : '400px',
			modal: true,
			buttons: {
				"保存": function() {
					var typeName = $("#typeName").val();
					if($.trim(typeName) == ''){
						alert('类型不能为空');
						return false;
					}
					
					var typeSize = $(".panel").size();
					var index = (parseInt(typeSize) - 1);
					var htmlContent = '<li class="nav-grid headShadow${linkType.index}" attr="${linkType.index}" style="padding-left:70px;">';
					htmlContent += '<span style="left:10px;">'+typeName+'</span>';
					htmlContent += '<ul class="connectedSortable nav-panel">';
					htmlContent += '<ul></li>';
					
					$("#nav-ul").append(htmlContent);
					$( this ).dialog( "close" );
					/*var $thisDialog = $(this);
					$.ajax({
						url : '${base}/weblink/addWebLinkData',
						data : 'handleType=webLinktype&title='+typeName,
						type : 'post',
						dataType : 'json',
						success : function(ajaxData){
							var typeSize = $(".panel").size();
							var index = (parseInt(typeSize) - 1);
							$this.before('<div class="nav-grid headShadow'+typeSize+' fl" attr="'+ index +'">'
									+'<div>'+typeName+'<a class="deleteType">×</a></div></div>');
							$(".panel").append("<div class='panel panel-content control"+index+" hide' attr='"+index+"'>"
									+"<ul class='connectedSortable placeHolderPadding'></ul></div>");
							$thisDialog.dialog( "close" );
						}
					});
					*/
				},
				"取消": function() {
					$( this ).dialog( "close" );
				}
			}
		});
		
		$("#addUrlType").click(function(){
			$("#addUrlTypeDiv" ).dialog('open');
		});
		
		$("#addUrlDiv" ).dialog({
			autoOpen: false,
			width : '400px',
			modal: true,
			buttons: {
				"保存": function() {
					var url = $("#url").val();
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
		
		$("#addUrl").click(function(){
			var selectContent = '';
			$(".nav-grid>span").each(function(){
				var $this = $(this);
				selectContent += '<option>'+$this.html()+'</option>';
			});
			$("#urlType").html(selectContent);
			$("#addUrlDiv").dialog('open');
		});
		
		$(document).on( "mouseenter", ".panel-content", function() {
			$(this).addClass("active");
		}).on( "mouseleave", ".panel-content", function() {
			$(this).removeClass("active");
		});
		
	});
</script>
<c:if test="${view != 0}">
<script>
	$(function(){
		$(document).on( "click", ".panel-content", function(event) {
			window.open($(this).attr("attr"));
		});
	});
</script>
</c:if>

</head>
<body>
<div id="addUrlDiv" class="form-horizontal" title="新增链接">
	<div class="form-group  col-md-12">
		<label class="col-md-4 control-label">选择类型<font class="requiredFlag">*</font></label><select id="urlType" class="col-md-8 input-sm"></select>
	</div>
	<div class="form-group  col-md-12">
		<label class="col-md-4 control-label">输入url<font class="requiredFlag">*</font></label><input id="url" type="text" class="col-md-8">
	</div>
	<div class="form-group  col-md-12">
		<label class="col-md-4 control-label">输入标题</label><input type="text" id="urlName" class="col-md-8">
	</div>
</div>
<div id="addUrlTypeDiv" class="form-horizontal" title="新增类型">
	<div class="form-group  col-md-12">
		<label class="col-md-4 control-label">类型名称<font class="requiredFlag">*</font></label><input type="text" id="typeName" class="col-md-8">
	</div>
</div>

<div id="nav" style="width:735px;">
	<ul id="nav-ul">
		<li class="nav-grid">
			<a class="fr">编辑</a>
			<a class="fr" id="addUrl" style="margin-right:5px;">新增</a>
			<a class="fr" id="addUrlType" style="margin-right:5px;">新增类型</a>
		</li>
		<c:forEach items="${webLinktypeList}" var="webLinktype" varStatus="linkType" >
			<li class="nav-grid headShadow${linkType.index}" attr="${linkType.index}" style="padding-left:70px;">
				<span style="left:10px;">${webLinktype.name}</span>
				<c:choose>
					<c:when test="${webLinktype.webLinkList == null || webLinktype.webLinkList[0].name == null}">
						<ul class="connectedSortable nav-panel">
						
						</ul>
					</c:when>
					<c:otherwise>
						<ul class="connectedSortable nav-panel">
							<c:forEach items="${webLinktype.webLinkList}" var="webLink" >
								<li class="panel-content" attr="${webLink.link}" >
									<img class="iconClass" src="${webLink.icon}" />
									<span title="${webLink.name}">
										<c:choose>
										   <c:when test="${fn:length(webLink.name) > 12}">
										   	   <c:out value="${fn:substring(webLink.name, 0, 12)}..." /> 
										   </c:when>
										   <c:otherwise>
										       ${webLink.name}
										   </c:otherwise>
										</c:choose>
									</span>
									<button type="button" class="btn btn-default fr" style="padding:2px 4px;"><span class="ui-icon ui-icon-close"></span></button>
								</li>
							</c:forEach>
						</ul>
				   </c:otherwise>
				</c:choose>
				<ul style="clear:both;height:0;"></ul>
			</li>
		</c:forEach>
	</ul>
</div>
</body>
</html>