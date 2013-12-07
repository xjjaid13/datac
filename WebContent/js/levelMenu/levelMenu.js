var recordWrap = '<div id="recordWrap">' + 
	'<div id="toolDiv">' +
		'<div id="timeMenu">' +
	        '<ul id="timeTree">' +
	        '</ul>' +
	    '</div>' + 
	    '<div id="recordDiv">' + 
	    	'<div>' + 
	        	'<div>总记录<a id="recordSum">0</a>条.</div>' +
	        	'<div>页数<a id="page">1</a>/<a id="pageSum">1</a>.</div>' + 
	        	'<div>每页显示<a id="recordNum">20</a>条.</div>' +
	        	'<div id="loading" class="container" style="display:none;">加载中......</div>' +
	    	'</div>' +
	    '</div>' +
	'</div>' +
'</div>';

var scrollTime;

$(function($) {
	$.fn.extend({
		levelMenu : function(options){
			$(this).html(recordWrap);
            var defaults = {
                yearUrl : '',
                monthUrl : '',
                dayUrl : ''
            };
            var options =  $.extend(defaults, options);
            onContent.onInitLoad();
            $.ajax({
            	url : options.yearUrl,
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
            var delayReturnData = null;
        	$("#page").mousewheel(function(event, delta, deltaX, deltaY) {
        		var pageSumValue = parseInt($("#pageSum").html());
        		var pageValue = parseInt($(this).html());
        		if(delta < 0){
        			if(pageValue > 1){
            			$(this).html(pageValue - 1);
            			clearTimeout(delayReturnData);
            			delayReturnData = setTimeout(onContent.onInitLoad(),2000);
        			}
        		}else{
        			if(pageValue < pageSumValue){
            			$(this).html(pageValue + 1);
            			clearTimeout(delayReturnData);
            			delayReturnData = setTimeout(onContent.onInitLoad(),2000);
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
            			delayReturnData = setTimeout(onContent.onInitLoad(),1000);
        			}
        		}else{
        			if(recordNumValue < 50){
        				$(this).html(recordNumValue + 10);
        				$("#page").html(1);
        				clearTimeout(delayReturnData);
            			delayReturnData = setTimeout(onContent.onInitLoad(),1000);
        			}
        		}
        		event.preventDefault();
        	});
        	$(window).bind("scroll",function() {
        		clearTimeout(scrollTime);
        		if(!onContent.isLoad && (parseInt($("#page").html()) < parseInt($("#pageSum").html()))){
        			if ($(document).scrollTop() + $(window).height() > $(document).height() - 300) {
    		    		scrollTime = setTimeout(function(){
    		    			$("#page").html(parseInt($("#page").html())+1);
    		    			onContent.onReload();
    		    		},100);
        			}
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
            		url : options.monthUrl,
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
            		url : options.monthUrl,
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
            $("#timeTree span").live("click",function(event){
        		var $ul = $(this).parent().find(">ul");
        		if(!$ul.is(":hidden")){
        			$ul.slideUp("fast");
        			$ul.find("ul").hide();
        		}else{
        			$ul.slideDown("fast");
        		}
        	});
		}
	});

});
