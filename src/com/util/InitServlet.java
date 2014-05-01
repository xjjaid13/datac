package com.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.Servlet;
import javax.servlet.ServletConfig;
import javax.servlet.http.HttpServlet;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Repository;

import com.spring.entity.User;
import com.spring.entity.WebLinktype;
import com.spring.service.UserMapperService;
import com.spring.service.WebLinktypeMapperService;

@Repository
public class InitServlet extends HttpServlet implements Servlet{

	private static final long serialVersionUID = 1L;
	
	public static Map<String,LinkedList<WebLinktype>> webLinkTypeMap = new HashMap<String, LinkedList<WebLinktype>>();

	public void init(ServletConfig servletConfig){
		String realPath = servletConfig.getServletContext().getRealPath("")+"/";
		/** 初始化配置文件 */
		new Init().init(realPath);
		initWebLinkData();
	}
	
	public void initWebLinkData(){
		ApplicationContext context = new ClassPathXmlApplicationContext(
				new String[] { "springmvc.xml" });
		WebLinktypeMapperService webLinktypeMapperService = (WebLinktypeMapperService) context.getBean("webLinktypeMapperService");
		UserMapperService userMapperService = (UserMapperService) context.getBean("userMapperService");
		List<User> userList = userMapperService.selectList(new User());
		if(userList != null && userList.size() > 0){
			for(User user : userList){
				WebLinktype webLinktype = new WebLinktype();
				webLinktype.setUserId(user.getUserId());
				int countWebLinktype = webLinktypeMapperService.count(webLinktype);
				if(countWebLinktype > 0){
					LinkedList<WebLinktype> linkedListType = new LinkedList<WebLinktype>();
					List<WebLinktype> webLinkTypeList = webLinktypeMapperService.returnEntityList(webLinktype);
					linkedListType.addAll(webLinkTypeList);
					webLinkTypeMap.put(user.getUserId() + "", linkedListType);
				}
			}
		}
	}
	
}
