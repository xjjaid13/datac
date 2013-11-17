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
<link href="${base}/js/contextMenu/src/jquery.contextMenu.css" rel="stylesheet" type="text/css"/>
<style>
    #content{
        width : 90%;
        height : 150px;
        background-color : #a3b2b5;
    }
    .divBtn{
        background-color : #8DD1FF;
        border-radius:5px;
        cursor : pointer;
    }
    .flowClass{
        padding : 10px;
        margin : 5px;
        background-color : #5692F5;
        word-break : break-all;
        border-radius:5px;
        box-shadow:0px 0px 10px #258ff2;
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
<body style="overflow-x:hidden;">
<%@include file="../../static/headNew.jsp" %>
<div class="main">
    <div style="position:fixed;width:60%;height:300px;background-color:#8DD1FF;
        border-radius:5px;text-align:center;padding:5px;
        box-shadow:0 0 10px #06C;top:-248px;z-index:10;right:10px;" id="noteContentDiv">
        <textarea style="width:99%;height:265px;margin:0px;padding:0px;" id="content" ></textarea>
        <div style="position:absolute;right:20px;bottom:-25px;height:30px;
            background-color:#5692F5;width:100px;border-radius:5px;line-height:30px;">
            <div id="addNoteBtn">新建笔记</div>
        </div>
    </div>
    <div class="container" style="height:500px;">
        <div id="container" class="span10" style="margin:0px;padding:0px;">
        
        </div>
        <div class="span2" style="margin-left : 0px;">
        	<div id="toolDiv" style="width:200px;">
        		<div id="timeMenu" style="border-radius:5px;padding:10px;box-shadow:0px 0px 10px #258ff2;">
		            <ul id="timeTree" style="background-color:#258ff2;text-align:center;margin:0px;margin-top:6px;">
		            
		            </ul>
	            </div>
	            <div style="background-color:#258FF2;border-radius:5px;padding:10px;box-shadow:0px 0px 10px #258ff2;">
	            	<div>总记录<a id="recordSum">0</a>条.</div>
	            	<div>页数<a id="page">1</a>/<a id="pageSum">1</a>.</div>
	            	<div>每页显示<a id="recordNum">20</a>条.</div>
	            	<div id="loading" class="container" style="display:none;">加载中......</div>
	            </div>
	            <!-- <div id="searchDiv">
	            	<input type="text" style="width:150px" /><span style='width:50px;height:30px;background-color:#258ff2;'>查询</span>
	            </div>
	            -->
	            
        	</div>
        </div>
    </div>
</div>
<div>
    
</div>
<%@include file="../../static/endNew.jsp" %>
<script src="${base}/js/levelMenu/levelMenu.js"></script>
<script src="${base}/js/sticky-info/sticky.js"></script>
<script src="${base}/js/masonry/jquery.masonry.js"></script>
<script src="${base}/js/masonry/js/jquery.infinitescroll.min.js"></script>
<script src="${base}/js/sticky/jquery.sticky.js"></script>
<script src="${base}/js/mousewheel/jquery.mousewheel.js"></script>
<script type="text/javascript" src="${base}/js/xheditor-1.2.1/xheditor-1.2.1.min.js"></script>
<script type="text/javascript" src="${base}/js/xheditor-1.2.1/xheditor_lang/zh-cn.js"></script>
<script type="text/javascript" src="${base}/js/xheditor-1.2.1/xheditor.js"></script>
<script type="text/javascript" src="${base}/js/contextMenu/src/jquery.contextMenu.js"></script>
<script>
	editor.addShortcuts('ctrl+enter',toggleEnter);
	var startPage = 0;
	var isLoad = false;
	var scrollTime;
    $(function(){
        $.ajax({
        	url : '${base}/note/returnTreeYear',
        	dataType : 'json',
        	success : function(data){
        		var data = data.data;
       			var content = '';
        		for(var i = 0; i < data.length; i++){
        			jsonSingle = data[i];
        			content += "<li class='expandYear'>";
                    content += "<span><a class='year'>"+jsonSingle.yearDate+"</a>(<a>"+jsonSingle.count+"</a>)</span>";
                    content += "<ul style='background-color:#339cf5'>";
                    
                    content += "</ul>";
                    content += "</li>";
        		}
        		$("#timeTree").html(content);
        	}
        });
        $(".expandYear").live("click",function(){
        	var $this = $(this);
        	var $ul = $this.find("ul");
        	if($ul.attr('status') == 'show'){
        		$ul.slideUp();
        		$ul.attr('status','off');
        		return false;
        	}
        	var year = $(this).find('.year').html();
        	$.ajax({
        		url : '${base}/note/returnTreeMonth',
        		data : {'year' : year},
        		dataType : 'json',
        		success : function(data){
        			var data = data.data;
        			var content = '';
        			for(var i = 0; i < data.length; i++){
        				jsonSingle = data[i];
        				content += "<li class='expandMonth'>";
                        content += "<span><a class='month'>"+jsonSingle.monthDate+"</a>月(<a>"+jsonSingle.count+"</a>)</span>";
                        content += "<ul style='background-color:#63b3f6'>";
                        
                        content += "</ul>";
                        content += "</li>";
        			}
        			$ul.html(content).slideDown();
        			$ul.attr('status','show');
        		}
        	})
        });
        $(".expandMonth").live("click",function(event){
        	var $this = $(this);
        	var $ul = $this.find("ul");
        	if($ul.attr('status') == 'show'){
        		$ul.slideUp();
        		$ul.attr('status','off');
        		return false;
        	}
        	var year = $(this).closest('.expandYear').find('.year').html();
        	var month = $(this).find('.month').html();
        	$.ajax({
        		url : '${base}/note/returnTreeDay',
        		data : {'year' : year, 'month' : month},
        		dataType : 'json',
        		success : function(data){
        			var data = data.data;
        			var content = '';
        			for(var i = 0; i < data.length; i++){
        				jsonSingle = data[i];
        				content += "<li class='expandMonth'>";
                        content += "<span><a>"+year+'-'+month+'-'+jsonSingle.dayDate+"</a>(<a>"+jsonSingle.count+"</a>)</span>";
                        content += "</li>";
        			}
        			$ul.html(content).slideDown();
        			$ul.attr('status','show');
        		}
        	});
        	event.stopPropagation();
        });
    	$.contextMenu({
   	        selector: '.flowClass', 
   	        callback: function(key, options) {
   	        	var noteId = $(this).attr("attr");
   	            if(key == 'edit'){
   	            	returnNote(noteId);
   	            }else if(key == 'delete'){
   	            	answer=window.confirm('确认删除?');
   	            	if(answer == true){
	   	            	deleteNote(noteId);
   	            	}
   	            }
   	        },
   	        items: {
   	        	"edit": {name: "编辑", rIcon: "edit"},
   	            "delete": {name: "删除", rIcon: "delete"},
   	            "sep1": "---------",
   	            "quit": {name: "退出", icon: "quit"}
   	        }
   	    });
   	    
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
    		$("#noteContentDiv").css({"background-color":"#8DD1FF"});
    	},function(){
    		$(this).removeClass("divBtn");
    		$("#noteContentDiv").css({"background-color":"#5692F5"});
    	}).click(function(){
    		toggleEnter();
    	});
    	returnContent();
    	var $noteContent = $("#noteContentDiv");
    	$(document).click(function(e){
    		if($(e.target).closest("#noteContentDiv").length == 0 && $noteContent.css("top") == '60px'){
    			editor.setSource('');
    			$("#noteContentDiv").animate({"top":"-248px"});
    		}
    	});
    	
    	$(window).bind("scroll",function() {
    		clearTimeout(scrollTime);
    		if(!isLoad && (parseInt($("#page").html()) < parseInt($("#pageSum").html()))){
    			if ($(document).scrollTop() + $(window).height() > $(document).height() - 300) {
		    		scrollTime = setTimeout(function(){
		                returnContent('reload');
		    		},100);
    			}
    		}
    	});
    	var delayReturnData = null;
    	$("#page").mousewheel(function(event, delta, deltaX, deltaY) {
    		var pageSumValue = parseInt($("#pageSum").html());
    		var pageValue = parseInt($(this).html());
    		if(delta < 0){
    			if(pageValue > 1){
	    			$(this).html(pageValue - 1);
	    			clearTimeout(delayReturnData);
	    			delayReturnData = setTimeout(returnContent,2000);
    			}
    		}else{
    			if(pageValue < pageSumValue){
	    			$(this).html(pageValue + 1);
	    			clearTimeout(delayReturnData);
	    			delayReturnData = setTimeout(returnContent,2000);
    			}
    		}
    		event.preventDefault();
    	});
    	$("#recordNum").mousewheel(function(event, delta, deltaX, deltaY) {
    		var recordNumValue = parseInt($(this).html());
    		if(delta < 0){
    			if(recordNumValue > 10){
    				$(this).html(recordNumValue - 10);
    				$("#page").html(1);
    				clearTimeout(delayReturnData);
	    			delayReturnData = setTimeout(returnContent,1000);
    			}
    		}else{
    			if(recordNumValue < 50){
    				$(this).html(recordNumValue + 10);
    				$("#page").html(1);
    				clearTimeout(delayReturnData);
	    			delayReturnData = setTimeout(returnContent,1000);
    			}
    		}
    		event.preventDefault();
    	});
    	$("body").keydown(function(e){
    		ctrlEnter(e,toggleEnter);
    	});
    	
    });
	function returnContent(type){
		clearTimeout(scrollTime);
		$("#loading").show();
		isLoad = true;
		var page = parseInt($("#page").html());
		var recordNum = parseInt($("#recordNum").html());
		if(page >= recordNum){
			return false;
		}
		if(type == 'reload'){
			page++;
		}
		$.ajax({
			url : 'returnNoteContent.action',
			data : 'startPage='+page+'&recordNum='+recordNum,
			type : 'post',
			dataType : 'json',
			success : function(ajaxData){
				if(type == 'reload'){
					$("#page").html(page);
				}
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
					htmlContent += "<div class='flow flowClass' attr='"+record.noteId+"'>"+record.content+"</div>";
				}
				if(type == 'reload'){
					$("#container").append(htmlContent);
					$("#container").masonry('reload');
				}else{
					$("#container").html(htmlContent);
					$("#container").masonry({
			            itemSelector: '.flow',
			            columnWidth: 15
			        });
					$("#container").masonry('reload');
				}
				$("#recordSum").html(ajaxData.recordSum);
				$("#pageSum").html(ajaxData.pageSum);
				//$("#container").masonry( 'appended', htmlContent, true ); 
				isLoad = false;
			}
		});
	}    
	function isKeyTrigger(e,keyCode){
	    var argv = isKeyTrigger.arguments;
	    var argc = isKeyTrigger.arguments.length;
	    var bCtrl = false;
	    if(argc > 2){
	        bCtrl = argv[2];
	    }
	    var bAlt = false;
	    if(argc > 3){
	        bAlt = argv[3];
	    }
	    var nav4 = window.Event ? true : false;
	    if(typeof e == 'undefined') {
	        e = event;
	    }
	    if( bCtrl && 
	        !((typeof e.ctrlKey != 'undefined') ? 
	            e.ctrlKey : e.modifiers & Event.CONTROL_MASK > 0)){
	        return false;
	    }
	    if( bAlt && 
	        !((typeof e.altKey != 'undefined') ? 
	            e.altKey : e.modifiers & Event.ALT_MASK > 0)){
	        return false;
	    }
	    var whichCode = 0;
	    if (nav4) whichCode = e.which;
	    else if (e.type == "keypress" || e.type == "keydown")
	        whichCode = e.keyCode;
	    else whichCode = e.button;

	    return (whichCode == keyCode);
	}

	function ctrlEnter(e,fuc){
	    var ie =navigator.appName=="Microsoft Internet Explorer"?true:false; 
	    if(ie){
	        if(event.ctrlKey && window.event.keyCode==13){fuc(e);}
	    }else{
	        if(isKeyTrigger(e,13,true)){fuc();}
	    }
	}
	
	function toggleEnter(){
		var $noteContent = $("#noteContentDiv");
		if($noteContent.css("top") == '60px'){
			var noteId = $("#content").attr("attr");
			alert(noteId);
			if(noteId == '' || noteId == undefined){
				addNoteContentSubmit();
			}else{
				updateNoteContentSubmit(noteId);
			}
			noteContentDivUp();
		}else{
			noteContentDivDown();
		}
	}
	
	function noteContentDivUp(){
		$("#noteContentDiv").css({"top":"-248px"});
		editor.setSource('');
		editor.blur();
	}
	
	function noteContentDivDown(){
		editor.focus();
		$("#noteContentDiv").css({"top":"60px"});
	}
	
	function addNoteContentSubmit(){
		$.ajax({
            url : '${base}/note/my-addNote',
            data : {'content':editor.getSource()},
            type : 'post',
            dataType : 'json',
            success : function(data){
            	$("#page").html(1);
            	tipMessage(data.message);
            	returnContent();
            }
        });
	}
	
	function updateNoteContentSubmit(noteId){
		$.ajax({
            url : '${base}/note/my-updateNote',
            data : {'content':editor.getSource(),'noteId':noteId},
            type : 'post',
            dataType : 'json',
            success : function(data){
            	$("#page").html(1);
            	tipMessage(data.message);
            	returnContent();
            }
        });
	}
	
	function returnNote(noteId){
		$.ajax({
			url : '${base}/note/returnNote',
			data : {'noteId' : noteId},
			type : 'post',
			dataType : 'json',
			success : function(data){
				$("#content").attr("attr",noteId);
				editor.setSource(data.data.content);
				noteContentDivDown();
			}
		});
	}
	
	function deleteNote(noteId){
		$.ajax({
			url : '${base}/note/my-deleteNote',
			data : {'noteId' : noteId},
			type : 'post',
			dataType : 'json',
			success : function(data){
				tipMessage(data.message);
				returnContent();
			}
		});
	}
	
	function tipMessage(message){
		$.stickyInfo(message);
	}
	
</script>
</body>
</html>