<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>便签</title>
<link href="${base}/css/common.css" rel="stylesheet" type="text/css"/>
<link href="${base}/js/xDialog-master/xDialog.css" rel="stylesheet" type="text/css"/>
<link href="${base}/js/sticky-info/sticky.css" rel="stylesheet" type="text/css"/>
<style>
    #noteContent{
        width : 90%;
        height : 150px;
        background-color : #a3b2b5;
    }
    .divBtn{
        background-color : #94A5B5;
        border-radius:5px;
        cursor : pointer;
    }
    .flowClass{
        padding : 10px;
        border : 1px solid grey;
        width : 200px;
        margin : 5px;
        background-color : #5692F5;
    }
    #timeTree div{
        //float : left;
    }
    #timeTree ul {
        margin : 0px;
    }
    #timeTree span {
        display : block;
        height : 25px;
        padding-top : 5px;
        cursor : pointer;
    }
    #timeTree span>a{
        color : white;
    }
    #timeTree span>a:hover{
        color : grey;
    }
</style>
</head>
<body>
<%@include file="../../static/headNew.jsp" %>
<div class="main">
    <div style="position:fixed;width:95%;height:300px;background-color:#5692F5;
        border-radius:5px;text-align:center;padding:15px;
        box-shadow:0 0 10px #06C;top:-268px;z-index:10;" id="noteContentDiv">
        <textarea style="width:100%;height:100%;margin:0px;padding:0px;" id="noteContent"></textarea>
        <div style="position:absolute;right:20px;bottom:-25px;height:30px;
            background-color:#5692F5;width:100px;border-radius:5px;line-height:30px;">
            <div id="addNoteBtn">新建笔记</div>
        </div>
    </div>
    <div class="container" style="height:500px;">
        <div id="container" class="span10" style="margin:0px;padding:0px;">
	        
        </div>
        <div class="span2" style="margin-left : 0px;">
        	<div id="toolDiv" style="width:150px;">
        		<div id="timeMenu" style="height:300px;">
		            <ul id="timeTree" style="background-color:#258ff2;text-align:center;margin:0px;margin-top:6px;">
		            
		            </ul>
	            </div>
	            <div id="searchDiv">
	            	<input type="text" style="" /><span style='width:'>查询</span>
	            </div>
        	</div>
        </div>
    </div>
    <div id="loading" class="container" style="position:fixed;bottom:60px;left:50%;display:none;">加载中......</div>
</div>
<div>
    
</div>
<%@include file="../../static/endNew.jsp" %>
<script src="${base}/js/levelMenu/levelMenu.js"></script>
<script src="${base}/js/sticky-info/sticky.js"></script>
<script src="${base}/js/masonry/jquery.masonry.js"></script>
<script src="${base}/js/masonry/js/jquery.infinitescroll.min.js"></script>
<script src="${base}/js/sticky/jquery.sticky.js"></script>
<script>
	var startPage = 0;
	var isLoad = false;
    $(function(){
    	$("#toolDiv").sticky({ topSpacing: 70, center:true, className:"hey" });
    	$("#timeTree span").live("click",function(event){
    		var $ul = $(this).parent().find(">ul");
    		if(!$ul.is(":hidden")){
    			$ul.slideUp("fast");
    			$ul.find("ul").hide();
    		}else{
    			$ul.slideDown("fast");
    		}
    	});
    	$("#test").click(function(event){
    		event.stopPropagation();
    	});
    	$("#addNoteBtn").hover(function(){
    		$(this).addClass("divBtn");
    		$("#noteContentDiv").css({"background-color":"#94A5B5"});
    	},function(){
    		$(this).removeClass("divBtn");
    		$("#noteContentDiv").css({"background-color":"#5692F5"});
    	}).click(function(){
    		var $noteContent = $("#noteContentDiv");
    		if($noteContent.css("top") == '60px'){
    			$.ajax({
                    url : '${base}/note/my-addNote',
                    data : 'content='+$("#noteContent").val(),
                    type : 'post',
                    dataType : 'json',
                    success : function(data){
                    	$.sticky(data.message);
                    	$("#container").append("<div class='flow flowClass'>"+$("#noteContent").val()+"</div>").masonry('reload');
                    }
                });
    			$("#noteContentDiv").animate({"top":"-268px"});
    		}else{
	    		$("#noteContentDiv").animate({"top":"60px"});
    		}
    	});
    	returnContent();
    	var $noteContent = $("#noteContentDiv");
    	$(document).click(function(e){
    		if($(e.target).closest("#noteContentDiv").length == 0 && $noteContent.css("top") == '60px'){
    			$("#noteContentDiv").animate({"top":"-268px"});
    		}
    	});
    	$("#timeTree").levelMenu({
    		dataSource : "${base}/note/test?1=1",
    		embedId : "timeTree"
    	});
    	
    	$(window).bind("scroll",function() {
    		if(!isLoad){
    			if ($(document).scrollTop() + $(window).height() > $(document).height() - 300) {
    				$("#loading").show();
        	    	returnContent('reload');
        	    }
    		}
    	});
    	    
    });
	function returnContent(type){
		isLoad = true;
		$.ajax({
			url : 'returnNoteContent.action',
			data : 'startPage='+startPage+'&recordNum=4',
			type : 'post',
			dataType : 'json',
			success : function(ajaxData){
				startPage++;
				var data = ajaxData.data;
				if(data.length == 0){
					$("#loading").html('未查询到记录');
					setTimeout(function(){
						$("#loading").fadeOut();
					},5000);
					return;
				}
				$("#loading").hide();
				var htmlContent = '';
				for(var i = 0; i < data.length; i++){
					var record = data[i];
					htmlContent += "<div class='flow flowClass'>"+record.content+"</div>";
				}
				$("#container").append(htmlContent);
				if(type == 'reload'){
					$("#container").masonry('reload');
				}else{
					$("#container").masonry({
			            itemSelector: '.flow',
			            columnWidth: 15
			        });
				}
				//$("#container").masonry( 'appended', htmlContent, true ); 
				isLoad = false;
			}
		});
	}    
</script>
</body>
</html>