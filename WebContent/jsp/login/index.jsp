<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en"><head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<title>登陆</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="Responsive HTML template for Your company">
<link rel="shortcut icon" type="image/x-icon" href="http://localhost:8080/datac/image/littleCat.ico" media="screen" />
<!-- Le styles -->
<link href="${base}/css/bootstrap.css" rel="stylesheet">
<link href="${base}/js/bootstrap/css/bootstrap-responsive.css" rel="stylesheet">

<link rel="stylesheet" href="${base}/css/typica-login.css">

<!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>
  <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->

<!-- Le favicon -->
<link rel="shortcut icon" href="http://wbpreview.com/previews/WB0F56883/favicon.ico">

</head>

  <body>

    <div class="navbar navbar-fixed-top">
      <div class="navbar-inner" style="background-color: #1d1f23;height:60px;" >
        <div class="container">
          <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </a>
          <a href="#"><img src="${base}/image/angryCat.png" style="height:50px;margin-top:5px;margin-left:165px;" alt="Typica - Bootstrap Awesome Template!"></a>
        </div>
      </div>
    </div>

    <div class="container">

        <div id="login-wraper">
            <form class="form login-form">
            	
                <div class="body">
                    <label>用户名</label>
                    <input id="username" name="username" type="text">
                    
                    <label>密码</label>
                    <input id="password" name="password" type="password">
                </div>
            
                <div class="footer">
                    <label class="checkbox inline">
                        <input id="inlineCheckbox1" value="option1" type="checkbox"> 自动登陆
                    </label>
                                
                    <button id="login" type="button" class="btn btn-success">登陆</button>
                </div>
            
            </form>
        </div>

    </div>

    <footer class="white navbar-fixed-bottom" style="background-color: #1d1f23;">
    <div style="display:none;">
	    <script type="text/javascript">
			var _bdhmProtocol = (("https:" == document.location.protocol) ? " https://" : " http://");
			document.write(unescape("%3Cscript src='" + _bdhmProtocol + "hm.baidu.com/h.js%3F7fdfa1251091dd89d11ed424596e2a32' type='text/javascript'%3E%3C/script%3E"));
		</script>
	</div>
      没有账号? 联系<a style="color:white;">xjjaid13@163.com</a>
    </footer>
</body>
<script src="${base}/js/jquery-1.8.3.js"></script>
<script src="${base}/js/bootstrap/js/bootstrap.js"></script>
<script src="${base}/js/backstretch/jquery.backstretch.min.js"></script>

<script>
$("body").backstretch("${base}/image/bg.jpg");
 	$(function(){
 		
		$("#login").click(function(){
			$.ajax({
				url : '${base}/login/login-post',
				data : 'username='+$("#username").val()+"&password="+$("#password").val(),
				dataType  : 'html',
				type : 'POST',
				success : function(data){
					data = $.trim(data);
					if(data == 'error'){
						alert("username or password error");
					}else{
						location.href = "${base}/blog/"+data;
					}
				}
			});
		});
 	});
 </script>
</html>