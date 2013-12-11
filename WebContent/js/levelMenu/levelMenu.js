$(function($) {
	$.fn.extend({
		levelMenu : function(options){
            var defaults = {
                yearUrl : '',
                monthUrl : '',
                dayUrl : ''
            };
            var options =  $.extend(defaults, options);
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
                        content += "<ul style='background-color:#00CEEB'>";
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
                            content += "<ul style='background-color:#00C4EB'>";
                            
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
            		url : options.dayUrl,
            		data : {'year' : year, 'month' : month},
            		dataType : 'json',
            		success : function(data){
            			var data = data.data;
            			var content = '';
            			for(var i = 0; i < data.length; i++){
            				jsonSingle = data[i];
            				content += "<li class='expandMonth'>";
                            content += "<span><a>"+month+'-'+jsonSingle.dayDate+"日</a>(<a>"+jsonSingle.count+"</a>)</span>";
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