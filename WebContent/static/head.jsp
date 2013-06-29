<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />  
</head>
<style>
	
</style>
<script>
	$(function(){
		$("#login").bind("click",function(){
			if($("#login_div").is(':visible')){
				$("#login_div").animate({top:-320},function(){
					$(this).hide();
					$("#username").val("");
					$("#password").val("");
				});
			}else{
				$("#login_div").show().animate({top:50});
			}
		})
		$("#login_btn").click(function(){
			$("#errinfo").html("");
			var username = $.trim($("#username").val());
			var password = $.trim($("#password").val());
			if(username == '' || password == ''){
				$("#errinfo").html("账号或密码为空!");
				return false;
			}
			$.ajax({
				url : '${base}/login/login-post',
				type : 'post',
				dataType: "text",
				data : 'username='+username+"&password="+password,
				success : function(data){
					data = $.trim(data);
					if(data != 'error'){
						$("#login_div").animate({top:-320},function(){
							$(this).hide();
							$("#username").val("");
							$("#password").val("");
						});
						$("#login").hide();
						$("#person_info").show().html(username);
						$("#errinfo").html("");
						bindHover();
					}else{
						$("#errinfo").html("账号或密码错误!");
					}
				}
			});
		})
		$.ajax({
			url : '${base}/login/login-info',
			dataType: "text",
			success : function(data){
				if(data != 'nolog'){
					$("#login").hide();
					$("#person_info").show().html(data);
					bindHover();
				}
			}
		});
	});
	function bindHover(){
		$("#blog_hover").hover(function(){
			$(".secondary_navigation").hide();
			$("#second_blog").show();
		});
		$("#img_hover").hover(function(){
			$(".secondary_navigation").hide();
			$("#second_img").show();
		});
		$("#index").hover(function(){
			$(".secondary_navigation").hide();
			$("#second").show();
		});
		$("#person_info").hover(function(){
			$(".secondary_navigation").hide();
			$("#second_info").show();
		});
	}
</script>
<div id="header" class="menu">
	<div id="header_padding" class="mti_font_element">
		<span id="index" class="secondary_navigation_trigger mti_font_element">首页</span>
		<a id="blog_hover" href="${base}/blog/index" class="mti_font_element">博客</a>
		<a id="img_hover" href="/designers" class="mti_font_element">图片</a> 
		<a id="navigation_contact" href="/contact" class="mti_font_element">contact</a>
		<div id="cart_info" class="mti_font_element">
			<a href="#" id="login" class="mti_font_element">登陆</a>
			<a href="#" id="person_info" style="display:none;" class="mti_font_element"></a>
		</div>
	</div>
</div>

<div class="second_menu" style="width: 100%; height: 60px;">
	<div id="second" class="secondary_navigation  menu">
		<div id="secondary_navigation_padding" class="secondary_navigation_padding">
			<a href="/collection/field_approved" class="mti_font_element">我的首页</a>
			<a href="/collection/field_approved" class="mti_font_element">我的首页</a>
			<a href="/collection/field_approved" class="mti_font_element">我的首页</a>
			<a href="/collection/field_approved" class="mti_font_element">我的首页</a>
			<a href="/collection/field_approved" class="mti_font_element">我的首页</a>
			<a href="/collection/field_approved" class="mti_font_element">我的首页</a>
		</div>
	</div>
	
	<div id="second_blog" class="secondary_navigation  menu" style="display:none;">
		<div id="secondary_navigation_padding" class="secondary_navigation_padding">
			<a href="${base}/blog/my-blog" class="mti_font_element">我的博客</a>
			<a href="${base}/blog/my-addblog" class="mti_font_element">新增博客</a>
			<a href="${base}/blog/my-blogList" class="mti_font_element">博客列表</a>
		</div>
	</div>
	
	<div id="second_img" class="secondary_navigation  menu" style="display:none;">
		<div id="secondary_navigation_padding" class="secondary_navigation_padding">
			<a href="/collection/collection_i" class="mti_font_element">111</a>
			<a href="/collection/field_approved" class="mti_font_element">222</a>
			<a href="/shop" class="mti_font_element">sasasa</a>
		</div>
	</div>
	
	<div id="second_info" class="secondary_navigation  menu" style="display:none;float:right;">
		<div id="secondary_navigation_padding" class="secondary_navigation_padding">
			<a href="/collection/collection_i" class="mti_font_element">111</a>
			<a href="/collection/field_approved" class="mti_font_element">222</a>
			<a href="${base}/login/login-out" class="mti_font_element">注销</a>
		</div>
	</div>
</div>


<div id="login_div">
	<div>用户名: <input type="text" name="username" id="username" class="input_class_login"></div>
	<div>密　码: <input type="password" name="password" id="password" class="input_class_login"></div>
	<div style="padding-left : 50px;"><input type="button" name="login_btn" id="login_btn" class="btn_class" value="登　陆"><span id="errinfo"></span></div>
</div>


