package com.spring.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.entity.RssType;
import com.spring.entity.User;
import com.spring.service.RssTypeMapperService;
import com.util.Constant;
import com.util.DataHandle;

@Controller
@RequestMapping("rss")
public class RssController {

	@Autowired	
	RssTypeMapperService rssTypeMapperService;
	
	@RequestMapping("my")
	public String doIndex(){
		return "rss/index";
	}
	
	@RequestMapping("myAddRssType")
	public void doMyAddRssType(HttpSession session,HttpServletRequest request,HttpServletResponse response){
		User user = (User) session.getAttribute(Constant.USER);
		String typeName = DataHandle.returnValue(request, "typeName");
		RssType rssType = new RssType();
		rssType.setTypeName(typeName);
		rssType.setUserId(user.getUserId());
		rssTypeMapperService.insert(rssType);
		JSONObject jsonObject = new JSONObject();
	}
	
	@RequestMapping("returnTree")
	public void doBlogList(HttpServletResponse response,HttpServletRequest request) throws IOException{
		String content = "";
		String id = request.getParameter("id");
		if("#".equals(id)){
			content += "[{ \"id\" : \"ajson1\", \"parent\" : \"#\", \"text\" : \"Simple root node\" },";
			content += "{ \"id\" : \"ajson2\", \"parent\" : \"#\", \"text\" : \"Root node 2\",\"children\" : true }]";
			response.getWriter().write(content.toString());
		}else{
			content += "[{ \"id\" : \"ajson21\", \"parent\" : \""+id+"\", \"text\" : \"Simple root node\" },";
			content += "{ \"id\" : \"ajson22\", \"parent\" : \""+id+"\", \"text\" : \"Root node 2\" }]";
			response.getWriter().write(content.toString());
		}
	}
	
}
