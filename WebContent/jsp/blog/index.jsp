<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@include file="../../static/css-file.jsp" %>
<style>
	a, a:hover {
	    text-decoration: none;
	}
	ul, ol {
	    list-style: none outside none;
	}
	.wrapper {
	    margin: 0 auto;
	    max-width: 1280px;
	    position: relative;
	    width: 95%;
	}
	.main {
	    margin: 50px 0;
	    text-align: center;
	    width: 100%;
	}
	.content {
	    margin: 25px 0;
	    text-align: left;
	}
	.content-text {
	    margin: 0 0 15px;
	}
	.nav {
	    display: inline-block;
	    font-size: 14px;
	    font-weight: 900;
	    position: relative;
	    width : 200px;
	}
	.nav-item {
	    float: left;
	    position: relative;
	}
	.nav-item>a,.nav-item .nav-submenu .nav-submenu-item>a{
		background-color:white;
	    border-bottom: 1px solid wheat;
	    display: block;
	    height: 50px;
	    padding: 15px;
	    transition: all 0.2s ease-in-out 0s;
	}
	.nav-item > a:hover {
	    background: none repeat scroll 0 0 #e5e5e5;
	}
	.nav-item:hover .nav-submenu {
	    display: block;
	}
	.nav-submenu {
	    display: none;
	    left: 0;
	    position: absolute;
	    width: 180px;
	}
	.nav-submenu-item>a {
	    background: none repeat scroll 0 0 whitesmoke;
	    border-bottom: 1px solid white;
	    display: block;
	    padding: 15px;
	}
	.nav-submenu-item a:hover {
	    background: none repeat scroll 0 0 #e5e5e5;
	}
	.nav-click {
	    border-left: 1px solid wheat;
	    cursor: pointer;
	    display: none;
	    height: 49px;
	    position: absolute;
	    right: 0;
	    top: 0;
	    width: 50px;
	}
	.nav-click i {
	    background: url("../img/drop.svg") no-repeat scroll center center / 20px auto rgba(0, 0, 0, 0);
	    display: block;
	    height: 48px;
	    width: 48px;
	}
	.nav-rotate {
	    transform: rotate(180deg);
	}
	.nav-mobile {
    	display: block;
	}
	.nav-list {
	    display: block;
	    padding-left:0;
	    text-align: left;
	    overflow:auto;
	}
	.nav-item {
	    float: none;
	    width: 100%;
	}
	.nav-item > a {
	    padding: 15px;
	}
	.nav-click {
	    display: block;
	}
	.nav-mobile-open {
	    border-radius: 5px 5px 0 0;
	}
	.nav-item:hover .nav-submenu {
	    display: none;
	}
	.nav-submenu {
	    position: static;
	    width: 100%;
	    padding-left:0;
	    display: none;
	}
	.nav-btn{
		padding : 10px 0;
		width : 100px;
		background-color:white;
		border:1px solid wheat;
		display:block;
		float:left;
		text-align:center;
		color:#428bca;
	}
	.nav-item>.dropdown{
		float: right;
	    margin-right: 60px;
	    position: relative;
	    top:-33px;
	}
	
	.nav-item ul .dropdown{
		float: right;
	    margin-right: 10px;
	    position: relative;
	    top:-33px;
	}
	
</style>
<link rel="stylesheet" type="text/css" href="http://pontikis.github.io/jui_dropdown/v1.0.4/jquery.jui_dropdown.css"/>
<link rel="stylesheet" type="text/css" href="http://www.qingdou.me/r.php?url=http://baijs.nl/tinyscrollbar/"/>

<%@include file="../../static/js-file.jsp" %>
<script type="text/javascript" src="http://pontikis.github.io/jui_dropdown/v1.0.4/jquery.jui_dropdown.min.js"></script>
<script type="text/javascript" src="http://baijs.nl/tinyscrollbar/js/jquery.tinyscrollbar.js"></script>

<script>
	//DOM ready
	$(function() {
		
		// Add a <span> to every .nav-item that has a <ul> inside
		$('.nav-item').has('ul').prepend('<span class="nav-click"><i class="nav-arrow"></i></span>');
		
		// Click to reveal the nav
		$('.nav-mobile').click(function(){
			$('.nav-list').toggle();
		});
	
		// Dynamic binding to on 'click'
		$('.nav-list').on('click', '.nav-click', function(){
		
			// Toggle the nested nav
			$(this).siblings('.nav-submenu').toggle();
			
			// Toggle the arrow using CSS3 transforms
			$(this).children('.nav-arrow').toggleClass('nav-rotate');
			
		});
		
		$("#addParentTypeDiv" ).dialog({
			autoOpen: false,
			width : '400px',
			modal: true,
			buttons: {
				"保存": function() {
					var parentTypeName = $("#parentTypeName").val();
					if($.trim(parentTypeName) == ''){
						alert('类型不能为空');
						return false;
					}
					$(".nav-list").append('<li class="nav-item nav-li" attr=10><a>'+parentTypeName+'</a>'
							+ $("#dropdown-div").html()
							+'</li>');
					$( this ).dialog( "close" );
				},
				"取消": function() {
					$( this ).dialog( "close" );
				}
			}
		});
		
		$("#addParentType").click(function(){
			$("#addParentTypeDiv" ).dialog('open');
		});
		
		$("#addTypeDiv" ).dialog({
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
					var parentTypeSelect = $("#parentTypeSelect").val();
					var $li = $(".nav-item[attr="+parentTypeSelect+"]");
					if($.trim($li.find(">ul").attr("class")) == ''){
						$li.append('<ul class="nav-submenu"><li class="nav-submenu-item nav-li"><a>'+typeName+'</a>'
								+$("#dropdown-div").html()
								+'</li></ul>')
						   .prepend('<span class="nav-click"><i class="nav-arrow"></i></span>');
					}else{
						$li.find("ul").append('<li class="nav-submenu-item nav-li"><a>'+typeName+'</a>'
								+$("#dropdown-div").html()
								+'</li>');
					}
					
					$( this ).dialog( "close" );
				},
				"取消": function() {
					$( this ).dialog( "close" );
				}
			}
		});
		
		$("#addType").click(function(){
			var htmlConent = '';
			$(".nav-list>li").each(function(){
				var $this = $(this);
				var id = $this.attr("attr");
				var title = $this.find(">a").html();
				htmlConent += '<option value="'+id+'">'+title+'</option>';
				$("#parentTypeSelect").html(htmlConent);
			})
			$("#addTypeDiv" ).dialog('open');
		});
		
		$(document).on("click",".rename-type",function(){
			alert('rename');
		}).on("click",".delete-type",function(){
			var $this = $(this);
			var $ul = $this.closest(".nav-submenu");
			$this.closest(".nav-li").fadeOut().remove();
			if($ul.attr("class") != undefined && $ul.find(">li").size() == 0){
				$ul.closest(".nav-item").find(">span").fadeOut().remove();
				$ul.remove();
			}
		});
		jqUpdateSize();
		$(window).resize(jqUpdateSize);
	});
	function jqUpdateSize(){
	    var height = $(window).height()-50;
	    $(".nav-list").height(height);
	};
</script>
</head>
<body>
	<div id="dropdown-div" class="hide">
		<div class="dropdown">
			<span data-toggle="dropdown" class="ui-icon ui-icon-wrench"></span>
			<ul class="dropdown-menu" role="menu" aria-labelledby="dLabel">
				<li role="presentation"><a class="rename-type" tabindex="-1" role="menuitem">修改名称</a></li>
				<li class="divider" role="presentation"></li>
				<li role="presentation"><a class="delete-type" tabindex="-1" role="menuitem">删除类别</a></li>
			</ul>
		</div>
	</div>
	
	<div id="addParentTypeDiv" class="form-horizontal" title="新增父类">
		<div class="form-group  col-md-12">
			<label class="col-md-4 control-label">父类名称<font class="requiredFlag">*</font></label><input type="text" id="parentTypeName" class="col-md-8">
		</div>
	</div>
	<div id="addTypeDiv" class="form-horizontal" title="新增子类">
		<div class="form-group  col-md-12">
			<label class="col-md-4 control-label">子类名称<font class="requiredFlag">*</font></label><input type="text" id="typeName" class="col-md-8">
		</div>
		<div class="form-group  col-md-12">
			<label class="col-md-4 control-label">父类<font class="requiredFlag">*</font></label>
			<select id="parentTypeSelect" class="col-md-8 input-sm">
				
			</select>
		</div>
	</div>
	<%@include file="../../static/left-nav.jsp" %>
           
	<nav class="nav" style="margin-left:102px;">
		<span class="nav-btn" id="addParentType">新增父类</span>
		<span class="nav-btn" id="addType">新增子类</span>
		<div style="clear:both;height:0;"></div>
		<ul class="nav-list">
			<li attr="1" class="nav-item nav-li">
				<a href="?=home">Home</a>
				<div class="dropdown">
				    <span data-toggle="dropdown" class="ui-icon ui-icon-wrench"></span>
				    <ul class="dropdown-menu" role="menu" aria-labelledby="dLabel">
				    	<li role="presentation"><a class="rename-type" tabindex="-1" role="menuitem">alter</a></li>
				    	<li class="divider" role="presentation"></li>
		                <li role="presentation"><a class="delete-type" tabindex="-1" role="menuitem">delete</a></li>
				    </ul>
				</div>	
				<ul class="nav-submenu">
					<li class="nav-submenu-item nav-li">
						<a href="?=submenu-1">Submenu item 1111</a>
						<div class="dropdown">
						    <span data-toggle="dropdown" class="ui-icon ui-icon-wrench"></span>
						    <ul class="dropdown-menu" role="menu" aria-labelledby="dLabel">
						    	<li role="presentation"><a class="rename-type" tabindex="-1" role="menuitem">alter</a></li>
						    	<li class="divider" role="presentation"></li>
				                <li role="presentation"><a class="delete-type" tabindex="-1" role="menuitem">delete</a></li>
						    </ul>
						</div>
					</li>
					<li class="nav-submenu-item nav-li">
						<a href="?=submenu-2">Submenu item 2</a>
						<div class="dropdown">
						    <span data-toggle="dropdown" class="ui-icon ui-icon-wrench"></span>
						    <ul class="dropdown-menu" role="menu" aria-labelledby="dLabel">
						    	<li role="presentation"><a class="rename-type" tabindex="-1" role="menuitem">alter</a></li>
						    	<li class="divider" role="presentation"></li>
				                <li role="presentation"><a class="delete-type" tabindex="-1" role="menuitem">delete</a></li>
						    </ul>
						</div>
					</li>
				</ul>
			</li>
			<li attr="2" class="nav-item nav-li">
				<a href="?=about">About</a>
				<div class="dropdown">
				    <span data-toggle="dropdown" class="ui-icon ui-icon-wrench"></span>
				    <ul class="dropdown-menu" role="menu" aria-labelledby="dLabel">
				    	<li role="presentation"><a class="rename-type" tabindex="-1" role="menuitem">alter</a></li>
				    	<li class="divider" role="presentation"></li>
		                <li role="presentation"><a class="delete-type" tabindex="-1" role="menuitem">delete</a></li>
				    </ul>
				</div>
			</li>
			<li attr="3" class="nav-item nav-li">
				<a href="?=services">Services</a>
				<ul class="nav-submenu">
					<li class="nav-submenu-item nav-li">
						<a href="?=submenu-1">Submenu item 1</a>
					</li>
					<li class="nav-submenu-item nav-li">
						<a href="?=submenu-2">Submenu item 2</a>
					</li>
					<li class="nav-submenu-item nav-li">
						<a href="?=submenu-3">Submenu item 3</a>
					</li>
					<li class="nav-submenu-item nav-li">
						<a href="?=submenu-4">Submenu item 4</a>
					</li>
				</ul>
			</li>
			<li attr="4" class="nav-item nav-li">
				<a href="?=portfolio">Portfolio</a>
			</li>
			<li attr="5" class="nav-item">
				<a href="?=testimonials">Testimonials</a>
			</li>
			<li attr="6" class="nav-item">
				<a href="?=contact">Contact</a>
			</li>
		</ul>
	</nav>
</body>
</html>