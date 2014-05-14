package com.spring.action;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.apache.commons.httpclient.DefaultHttpMethodRetryHandler;
import org.apache.commons.httpclient.Header;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.commons.httpclient.params.HttpMethodParams;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;
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
import com.util.DataHandle;
import com.util.InitServlet;

@Controller
@RequestMapping("weblink")
public class WebLinkController {

	@Autowired
	WebLinktypeMapperService webLinktypeMapperService;
	
	@Autowired
	WebLinkMapperService webLinkMapperService;
	
	@RequestMapping("my/{userId}")
	public String returnMyWebLink(Model model,@PathVariable int userId){
		WebLinktype webLinktype = new WebLinktype();
		webLinktype.setUserId(userId);
		List<WebLinktype> webLinkTypeList = webLinktypeMapperService.returnEntityList(webLinktype);
		
		model.addAttribute("webLinkTypeList", webLinkTypeList);
		return "weblink/myIndex";
	}
	
	@RequestMapping("view/{userId}")
	public String returnWebLink(Model model,@PathVariable int userId){
		WebLinktype webLinktype = new WebLinktype();
		webLinktype.setUserId(userId);
		List<WebLinktype> webLinkTypeList = webLinktypeMapperService.returnEntityList(webLinktype);
		
		model.addAttribute("webLinkTypeList", webLinkTypeList);
		return "weblink/view";
	}
	
	@RequestMapping("my-updateWebLink")
	public void doUpdateWebLink(HttpServletRequest request,HttpServletResponse response,HttpSession session) throws IOException{
		User user = (User) session.getAttribute(Constant.USER);
		String webLinkContent = request.getParameter("webLinkContent");
		int webLinkId = DataHandle.returnValueInt(request, "webLinkId");
		
		WebLink webLink = fetchFromRemote(webLinkContent);
		webLink.setWebLinkId(webLinkId);
		webLink.setUserId(user.getUserId());
		webLinkMapperService.update(webLink);
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("webLink", webLink);
		response.getWriter().write(jsonObject.toString());
	}
	
	@RequestMapping("my-addWebLink")
	public void doAddWebLink(HttpServletRequest request,HttpServletResponse response,HttpSession session) throws IOException{
		User user = (User) session.getAttribute(Constant.USER);
		String webLinkContent = DataHandle.returnValue(request, "webLinkContent");
		int webLinktypeId = DataHandle.returnValueInt(request, "webLinktypeId");
		WebLink webLink = fetchFromRemote(webLinkContent);
		webLink.setUserId(user.getUserId());
		webLink.setWebLinktypeId(webLinktypeId);
		webLinkMapperService.insert(webLink);
		int webLinkId = webLinkMapperService.maxId(webLink);
		webLink.setWebLinkId(webLinkId);
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("webLink", webLink);
		response.getWriter().write(jsonObject.toString());
	}
	
	@RequestMapping("test")
	public String test(){
		return "test";
	}
	
	/**
	 * 从远程网页获得需要的信息
	 * @param webLinkContent
	 * @return
	 * @throws IOException
	 */
	public WebLink fetchFromRemote(String webLinkContent) throws IOException{
		WebLink webLink = new WebLink();
		if(webLinkContent.indexOf("http:") == -1){
			webLinkContent = "http://" + webLinkContent; 
		}
		Document doc = Jsoup.connect(webLinkContent).get();
		//网页标题
		Elements titleElements = doc.select("title");
		String title = titleElements.html();
		webLink.setName(title);
		//网页描述
		Elements descriptionElements = doc.select("meta[name=description]");
		String description = descriptionElements.attr("content");
		if("".equals(DataHandle.handleValue(description))){
			description = title;
		}
		webLink.setDescription(description);
		Pattern pattern = Pattern.compile("^(.*?)\\.(.*?)\\.");
		Matcher matcher = pattern.matcher(webLinkContent);
		if(matcher.find()){
			String host = "http://www." + matcher.group(2) + ".com";
			webLink.setHost(host);
			//一般网页默认icon
			String defaultIcon = host + "/favicon.ico";
			try{
			    GetMethod method = new GetMethod(defaultIcon);
			    method.getParams().setParameter(HttpMethodParams.RETRY_HANDLER, 
			    		new DefaultHttpMethodRetryHandler(3, false));
			    //是否是icon,如果不是icon,去页面内容中查找
			    Header[] HeaderArray = method.getResponseHeaders("Content-Type");
			    if(HeaderArray.length > 0 && HeaderArray[0].toString().indexOf("image/x-icon") == -1){
		    		Elements iconElements = doc.select("link[rel=shortcut icon]");
					webLink.setIcon(iconElements.attr("href"));
		    	}else{
					webLink.setIcon(defaultIcon);
		    	}
			}catch(Exception e){
				Elements iconElements = doc.select("link[rel=shortcut icon]");
				webLink.setIcon(iconElements.attr("href"));
			}
			
		}
		webLink.setLink(webLinkContent);
		return webLink;
	}
	
	@RequestMapping("my-addWebLinktype")
	public void doAddNewLinkType(HttpServletRequest request,HttpServletResponse response,HttpSession session) throws IOException{
		User user = (User) session.getAttribute(Constant.USER);
		WebLinktype webLinktype = new WebLinktype();
		webLinktype.setName("自定义");
		webLinktype.setUserId(user.getUserId());
		webLinktypeMapperService.insert(webLinktype);
		int maxId = webLinktypeMapperService.maxId(webLinktype);
		webLinktype.setWebLinktypeId(maxId);
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("webLinktype", webLinktype);
		response.getWriter().write(jsonObject.toString());
	}
	
	@RequestMapping("my-updateWebLinktype")
	public void doUpdateWebLinkType(HttpServletRequest request,HttpServletResponse response,HttpSession session) throws IOException{
		int webLinktypeId = DataHandle.returnValueInt(request, "webLinktypeId");
		String name = DataHandle.returnValue(request, "name");
		WebLinktype webLinktype = new WebLinktype();
		webLinktype.setWebLinktypeId(webLinktypeId);
		webLinktype = webLinktypeMapperService.select(webLinktype);
		webLinktype.setName(name);
		webLinktypeMapperService.update(webLinktype);
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("result", "success");
		response.getWriter().write(jsonObject.toString());
	}
	
	@RequestMapping("my-deleteWebLinktype")
	public void deleteLineType(HttpServletRequest request,HttpServletResponse response,HttpSession session) throws IOException{
		User user = (User) session.getAttribute(Constant.USER);
		LinkedList<WebLinktype> linkedListType = InitServlet.webLinkTypeMap.get(user.getUserId()+"");
	    //int webLinktypeId = DataHandle.returnValueInt(request, "webLinktypeId");
	    int typeIndex = DataHandle.returnValueInt(request, "typeIndex");
	    linkedListType.remove(typeIndex);
//	    WebLinktype webLinktype = new WebLinktype();
//	    webLinktype.setWebLinktypeId(webLinktypeId);
//	    webLinktypeMapperService.deleteWebLinkType(webLinktype);
	    JSONObject jsonObject = new JSONObject();
		jsonObject.put("result", "success");
		response.getWriter().write(jsonObject.toString());
	}
	
	@RequestMapping("my-deleteWebLink")
    public void myDeleteWebLink(HttpServletRequest request,HttpServletResponse response,HttpSession session) throws IOException{
		User user = (User) session.getAttribute(Constant.USER);
		LinkedList<WebLinktype> linkedListType = InitServlet.webLinkTypeMap.get(user.getUserId()+"");
        //int webLinkId = DataHandle.returnValueInt(request, "webLinkId");
        int urlIndex = DataHandle.returnValueInt(request, "urlIndex");
	    int typeIndex = DataHandle.returnValueInt(request, "typeIndex");
	    linkedListType.get(typeIndex).getWebLinkList().remove(urlIndex);
//        WebLink webLink = new WebLink();
//        webLink.setWebLinkId(webLinkId);
//        webLinkMapperService.delete(webLink);
        response.getWriter().write("success");
    }
	
	@RequestMapping("index/{userId}")
	public String doIndex(@PathVariable int userId,Model model,HttpServletRequest request){
		LinkedList<WebLinktype> webLinktypeList = InitServlet.webLinkTypeMap.get(userId+"");
		String view = DataHandle.returnValue(request, "view");
		model.addAttribute("webLinktypeList", webLinktypeList);
		model.addAttribute("view", view);
		return "weblink2/index";
	}
	
	@RequestMapping("addWebLinkData")
	public void addWebLinkData(HttpServletRequest request,HttpServletResponse response,HttpSession session) throws IOException{
		User user = (User) session.getAttribute(Constant.USER);
		String handleType = request.getParameter("handleType");
		String title = DataHandle.returnValue(request, "title");
		LinkedList<WebLinktype> linkedListType = InitServlet.webLinkTypeMap.get(user.getUserId()+"");
		JSONObject jsonObject = new JSONObject();
		if("webLinktype".equals(handleType)){
			WebLinktype webLinktype = new WebLinktype();
			webLinktype.setName(title);
			webLinktype.setUserId(user.getUserId());
			webLinktypeMapperService.insert(webLinktype);
			linkedListType.add(webLinktype);
			jsonObject.put("webLinktype", webLinktype);
		}else if("webLink".equals(handleType)){
			String url = DataHandle.returnValue(request, "url");
			int typeIndex = DataHandle.returnValueInt(request, "typeIndex");
			WebLinktype webLinktype = linkedListType.get(typeIndex);
			WebLink webLink = new WebLink();
			webLink.setLink(url);
			webLink.setName(title);
			//WebLink webLink = fetchFromRemote(url);
			webLink.setUserId(user.getUserId());
			webLink.setWebLinktypeId(webLinktype.getWebLinktypeId());
			webLinkMapperService.insert(webLink);
			LinkedList<WebLink> webLinkList = webLinktype.getWebLinkList();
			if(webLinkList == null){
				webLinkList = new LinkedList<WebLink>();
				webLinkList.add(webLink);
				webLinktype.setWebLinkList(webLinkList);
			}else{
				webLinkList.add(webLink);
			}
			jsonObject.put("webLink", webLink);
		}
		jsonObject.put("result", "success");
		response.getWriter().write(jsonObject.toString());
	}
	
	@RequestMapping("updateWebLinkData")
	public void updateWebLinkData(HttpServletRequest request,HttpServletResponse response,HttpSession session) throws IOException{
		User user = (User) session.getAttribute(Constant.USER);
		String handleType = request.getParameter("handleType");
		int fromIndex = DataHandle.returnValueInt(request, "fromIndex");
		int toIndex = DataHandle.returnValueInt(request, "toIndex");
		LinkedList<WebLinktype> linkedListType = InitServlet.webLinkTypeMap.get(user.getUserId()+"");
		if("webLinktype".equals(handleType)){
			WebLinktype fromWebLinktype = linkedListType.get(fromIndex); 
			linkedListType.remove(fromIndex);
			linkedListType.add(toIndex, fromWebLinktype);
		}else if("webLink".equals(handleType)){
			int typeIndex = DataHandle.returnValueInt(request, "typeIndex");
			int oringType = DataHandle.returnValueInt(request, "oringType");
			WebLinktype webLinktype = linkedListType.get(typeIndex);
			webLinktype.setChange(true);
			WebLinktype oringWebLinktype = linkedListType.get(oringType);
			oringWebLinktype.setChange(true);
			LinkedList<WebLink> webLinkLinkedList = oringWebLinktype.getWebLinkList();
			WebLink webLink = webLinkLinkedList.get(fromIndex);
			if(typeIndex != oringType){
				webLink.setWebLinktypeId(typeIndex);
			}
			webLinkLinkedList.remove(fromIndex);
			if(toIndex == -1){
				webLinktype.getWebLinkList().add(webLink);
			}else{
				webLinktype.getWebLinkList().add(toIndex, webLink);
			}
		}
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("result", "success");
		response.getWriter().write(jsonObject.toString());
	}
	
	
	public static void main(String[] args) throws IOException {
		WebLink webLink = new WebLinkController().fetchFromRemote("www.baidu.com");
		
	}

	
}
