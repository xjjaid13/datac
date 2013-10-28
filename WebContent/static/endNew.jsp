<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script src="${base}/js/jquery-1.8.3.min.js"></script>
<script src="${base}/js/bootstrap/js/bootstrap.min.js"></script>
<script src="${base}/js/backstretch/jquery.backstretch.min.js"></script>
<script>
	$.backstretch("${base}/image/bg.jpg",{duration: 3000, fade: 750});
	$(function(){
		$(".dropdown-toggle").mouseover(function(){
			$(this).parent().addClass("open");
		});
		$("#userInfo").mouseleave(function(){
			$(this).parent().removeClass("open");
		});
		
	});
</script>
<div class="footer">
    <div class="container">
        <div class="row">
            <script type="text/javascript">
                //var _bdhmProtocol = (("https:" == document.location.protocol) ? " https://" : " http://");
                //document.write(unescape("%3Cscript src='" + _bdhmProtocol + "hm.baidu.com/h.js%3F7fdfa1251091dd89d11ed424596e2a32' type='text/javascript'%3E%3C/script%3E"));
            </script>
        </div>
    </div>
</div>