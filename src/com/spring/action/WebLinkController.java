package com.spring.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.entity.User;
import com.spring.entity.WebLink;
import com.spring.entity.WebLinktype;
import com.spring.service.WebLinkMapperService;
import com.spring.service.WebLinktypeMapperService;
import com.util.Constant;

@Controller
@RequestMapping("weblink")
public class WebLinkController {

	@Autowired
	WebLinktypeMapperService webLinktypeMapperService;
	
	@Autowired
	WebLinkMapperService webLinkMapperService;
	
	@RequestMapping("/{userId}")
	public String returnWebLink(Model model,@PathVariable int userId){
		WebLinktype webLinktype = new WebLinktype();
		webLinktype.setUserId(userId);
		List<WebLinktype> webLinkTypeList = webLinktypeMapperService.returnEntityList(webLinktype);
		
		model.addAttribute("webLinkTypeList", webLinkTypeList);
		return "weblink/index";
	}
	
	@RequestMapping("addNewLink")
	public void doAddNewLink(HttpServletRequest request,HttpServletResponse response,HttpSession session) throws IOException{
		User user = (User) session.getAttribute(Constant.USER);
		String linkName = request.getParameter("linkName");
		String link = request.getParameter("link");
		String type = request.getParameter("type");
		WebLink webLink = new WebLink();
		webLink.setName(linkName);
		webLink.setLink(link);
		webLink.setUserId(user.getUserId());
		webLink.setWebLinktypeId(Integer.parseInt(type));
		webLinkMapperService.insert(webLink);
		int maxID = webLinkMapperService.maxId(webLink);
		response.getWriter().write(maxID);
	}
	
	@RequestMapping("addNewLinkType")
	public void doAddNewLinkType(HttpServletRequest request,HttpServletResponse response,HttpSession session) throws IOException{
		User user = (User) session.getAttribute(Constant.USER);
		String linkType = request.getParameter("linkType");
		WebLinktype webLinktype = new WebLinktype();
		webLinktype.setName(linkType);
		webLinktype.setUserId(user.getUserId());
		webLinktypeMapperService.insert(webLinktype);
		int maxId = webLinktypeMapperService.maxId(webLinktype);
		response.getWriter().write(maxId);
	}
	
	@RequestMapping("deleteLinkType")
	public void deleteLineType(HttpServletRequest request,HttpServletResponse response,HttpSession session) throws IOException{
	    String webLinktypeId = request.getParameter("webLinktypeId");
	    WebLinktype webLinktype = new WebLinktype();
	    webLinktype.setIds(webLinktypeId);
	    webLinktypeMapperService.deleteByIds(webLinktype);
	    response.getWriter().write("success");
	}
	
	@RequestMapping("deleteLink")
    public void deleteLine(HttpServletRequest request,HttpServletResponse response,HttpSession session) throws IOException{
        String webLinkId = request.getParameter("webLinkId");
        WebLink webLink = new WebLink();
        webLink.setIds(webLinkId);
        webLinkMapperService.deleteByIds(webLink);
        response.getWriter().write("success");
    }
	
}
