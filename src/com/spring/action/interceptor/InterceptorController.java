package com.spring.action.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.util.Constant;

public class InterceptorController implements HandlerInterceptor{
	
	public void afterCompletion(HttpServletRequest arg0,
			HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {
	    
	}

	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1,
			Object arg2, ModelAndView arg3) throws Exception {
	    
	}

	public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
			Object obj) throws Exception {
		request.getSession().setAttribute(Constant.BASE, request.getContextPath());
//		BgUser bgUser = new BgUser();
//		bgUser.setId(4);
//		bgUser.setUsername("xjj");
//		request.getSession().setAttribute(Constant.USER, bgUser);
		return true;
	}
	
}
