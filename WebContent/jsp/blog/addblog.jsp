<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新增博客</title>
<link href="${base}/css/common.css" rel="stylesheet" type="text/css"/>
<style>
	.main{
		margin-left : 40px;
		margin-right : 40px;
		border : 1px solid grey;
		border-radius : 3px 3px 3px 3px;
	}
	.menu_ul{
		padding-left : 0px;
	}
	.title_div{
		padding-bottom : 20px;
	}
	.menu_ul .addBlog{
		background-color : grey;
	}
	.btnCode {
		background:transparent url(${base}/image/code.gif) no-repeat 16px 16px;
		background-position:2px 2px;
	}
</style>
</head>
<body>

	<%@include file="../../static/headNew.jsp" %>
	
	<div class="main">
		
			<div class="row-fluid" style="padding-top:20px;">
				<div class="span1"></div>
				<div class="span10">
				
				<div class="title_div">
					<select id="article_type" style="width:70px;">
						<option value="0">原创</option>
						<option value="1">转载</option>
						<option value="2">翻译</option>
					</select>
					标题  ：<input type="text" id="title" class="input_class">
				</div>
				<div class="title_div">
					<textarea id="content" name="content" rows="22" cols="80" style="width: 100%"></textarea>
				</div>
				<div>添加文章关键字： <input type="text" class="input_class" name="keyword" id="keyword"></div>
				<div><input type="button" id="blog_post" style="margin-top:10px;" class="btn" value="发布" ></div>
				</div>
			</div>
	</div>
	
	<%@include file="../../static/endNew.jsp" %>

</body>
<script type="text/javascript" src="${base}/js/xheditor-1.2.1/xheditor-1.2.1.min.js"></script>
<script type="text/javascript" src="${base}/js/xheditor-1.2.1/xheditor_lang/zh-cn.js"></script>
<script>
	var plugins={
		Code:{c:'btnCode',t:'插入代码',h:1,e:function(){
			var _this=this;
			var htmlCode='<div><select id="xheCodeType"><option value="html">HTML/XML</option><option value="js">Javascript</option><option value="css">CSS</option><option value="php">PHP</option><option value="java">Java</option><option value="py">Python</option><option value="pl">Perl</option><option value="rb">Ruby</option><option value="cs">C#</option><option value="c">C++/C</option><option value="vb">VB/ASP</option><option value="">其它</option></select></div><div><textarea id="xheCodeValue" wrap="soft" spellcheck="false" style="width:300px;height:100px;" /></div><div style="text-align:right;"><input type="button" id="xheSave" value="确定" /></div>';			var jCode=$(htmlCode),jType=$('#xheCodeType',jCode),jValue=$('#xheCodeValue',jCode),jSave=$('#xheSave',jCode);
			jSave.click(function(){
				_this.loadBookmark();
				_this.pasteHTML('<pre class="brush:'+jType.val()+';">\r\n'+jValue.val()+'\r\n</pre>');
				_this.hidePanel();
				return false;	
			});
			_this.saveBookmark();
			_this.showDialog(jCode);
		}}
	},emots={
		msn:{name:'MSN',count:40,width:22,height:22,line:8},
		pidgin:{name:'Pidgin',width:22,height:25,line:8,list:{smile:'微笑',cute:'可爱',wink:'眨眼',laugh:'大笑',victory:'胜利',sad:'伤心',cry:'哭泣',angry:'生气',shout:'大骂',curse:'诅咒',devil:'魔鬼',blush:'害羞',tongue:'吐舌头',envy:'羡慕',cool:'耍酷',kiss:'吻',shocked:'惊讶',sweat:'汗',sick:'生病',bye:'再见',tired:'累',sleepy:'睡了',question:'疑问',rose:'玫瑰',gift:'礼物',coffee:'咖啡',music:'音乐',soccer:'足球',good:'赞同',bad:'反对',love:'心',brokenheart:'伤心'}},
		ipb:{name:'IPB',width:20,height:25,line:8,list:{smile:'微笑',joyful:'开心',laugh:'笑',biglaugh:'大笑',w00t:'欢呼',wub:'欢喜',depres:'沮丧',sad:'悲伤',cry:'哭泣',angry:'生气',devil:'魔鬼',blush:'脸红',kiss:'吻',surprised:'惊讶',wondering:'疑惑',unsure:'不确定',tongue:'吐舌头',cool:'耍酷',blink:'眨眼',whistling:'吹口哨',glare:'轻视',pinch:'捏',sideways:'侧身',sleep:'睡了',sick:'生病',ninja:'忍者',bandit:'强盗',police:'警察',angel:'天使',magician:'魔法师',alien:'外星人',heart:'心动'}}
	};
    xhEditor = $('#content').xheditor({plugins:plugins,tools:'full',showBlocktag:false,forcePtag:false,emots:emots,emotMark:true,shortcuts:{}});
    function html_encode(str){   
        var s = "";
        if (str.length == 0) return "";   
        s = str.replace(/&/g, "&amp;");   
        s = s.replace(/</g, "&lt;");   
        s = s.replace(/>/g, "&gt;");   
        //s = s.replace(/ /g, "&nbsp;");   
        //s = s.replace(/\'/g, "&#39;");   
        s = s.replace(/\"/g, "&quot;");   
        //s = s.replace(/\n/g, "<br>");   
        return s;   
    }   
    $(document).ready(function() {
      //$("#content").cleditor({width : 1000 , height : 400});
      $("#blog_post").click(function(){
    	  var title = $("#title").val();
    	  var content = xhEditor.getSource();
    	  var article_type = $("#article_type").html();
    	  var keyword = $("#keyword").val();
    	  if(title == "" || $.trim(content) == "<br>"){
    		  alert("请输入标题或者内容");
    	  }else{
    		  $.post('${base}/blog/my-addblog-post',{ title: title,keyword : keyword, content: content,article_type : article_type }, function(data) {
    			  location.href = "${base}/blog/${user.bgUserId}";
    		  });
    	  }
      });
      $(".secondary_navigation").hide();
	  $("#second_blog").show();
  });
  
</script>
</html>