$(function($) {
	$.fn.extend({
		levelMenu : function(options){
			/** config */  
            var defaults = { 
                dataSource : '',
                embedId : ''
            };
            var options =  $.extend(defaults, options);
            $.ajax({
            	url : options.dataSource,
            	dataType : 'json',
            	success : function(data){
            		data = data.data;
            		var html = jointHtml(data,0);
            		$("#"+options.embedId).html(html);
            	}
            });
		}
	
	});
	colorArr = ['grey','red','black','pink','yellow'];
	function jointHtml(json,colorNum){
        var content = "";
        for(var i = 0; i < json.length; i++){
            var jsonSingle = json[i];
            content += "<li>";
            content += "<span>"+jsonSingle.display+"(<a>"+jsonSingle.num+"</a>)</span>";
            content += "<ul style='background-color:"+colorArr[colorNum]+"'>";
            if(jsonSingle.data != undefined){
            	colorNum++;
                content += jointHtml(jsonSingle.data,colorNum);
            }
            content += "</ul>";
            content += "</li>";
        }
        return content;
    }
});