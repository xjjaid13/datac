package com.spring.action;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.apache.commons.httpclient.DefaultHttpMethodRetryHandler;
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
	
	@RequestMapping("my-updateWebLink")
	public void doUpdateWebLink(HttpServletRequest request,HttpServletResponse response,HttpSession session) throws IOException{
		User user = (User) session.getAttribute(Constant.USER);
		String webLinkContent = request.getParameter("webLinkContent");
		int webLinkId = DataHandle.returnValueInt(request, "webLinkId");
		
		WebLink webLink = new WebLink();
		if(webLinkContent.indexOf("http:") == -1){
			webLinkContent = "http://" + webLinkContent; 
		}
		Document doc = Jsoup.connect(webLinkContent).get();
		//网页标题
		Elements titleElements = doc.select("title");
		String title = titleElements.html();
		webLink.setName(title);
		webLink.setUserId(user.getUserId());
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
			    if(method.getResponseHeaders("Content-Type")[0].toString().indexOf("image/x-icon") == -1){
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
		//fetch link title
		webLink.setWebLinkId(webLinkId);
		webLinkMapperService.update(webLink);
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("host", webLink.getHost());
		jsonObject.put("name", webLink.getName());
		jsonObject.put("description", webLink.getDescription());
		jsonObject.put("icon", webLink.getIcon());
		jsonObject.put("link", webLink.getLink());
		response.getWriter().write(jsonObject.toString());
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
	
	public static void main(String[] args) throws IOException {
		String url = "http://www.baidu.com/favicon.ico";
		HttpClient client = new HttpClient();

	    // Create a method instance.
	    GetMethod method = new GetMethod(url);
	    
	    // Provide custom retry handler is necessary
	    method.getParams().setParameter(HttpMethodParams.RETRY_HANDLER, 
	    		new DefaultHttpMethodRetryHandler(3, false));

	    try {
	      // Execute the method.
	      int statusCode = client.executeMethod(method);

	      if (statusCode != HttpStatus.SC_OK) {
	        System.err.println("Method failed: " + method.getStatusLine());
	      }
	      System.out.println("....="+method.getResponseHeaders("Content-Type")[0].toString().indexOf("image/x-icon"));

	      // Read the response body.
	      byte[] responseBody = method.getResponseBody();

	      // Deal with the response.
	      // Use caution: ensure correct character encoding and is not binary data
	      //System.out.println(new String(responseBody));

	    } catch (HttpException e) {
	      System.err.println("Fatal protocol violation: " + e.getMessage());
	      e.printStackTrace();
	    } catch (IOException e) {
	      System.err.println("Fatal transport error: " + e.getMessage());
	      e.printStackTrace();
	    } finally {
	      // Release the connection.
	      method.releaseConnection();
	    }  
	}
	
}
