package com.spring.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.entity.BgArticle;
import com.spring.entity.BgKeyword;
import com.spring.entity.BgUser;
import com.spring.service.BgArticleMapperService;
import com.spring.service.BgKeywordMapperService;
import com.util.Constant;
import com.util.DataHandle;
import com.util.HtmlHandle;
import com.util.Init;
import com.util.TimeHandle;

@Controller
@RequestMapping("blog")
public class BlogController {

	@Autowired
	private BgArticleMapperService bgArticleMapperService;

	@Autowired
	private BgKeywordMapperService bgKeywordMapperService;

	/**
	 * 博客首页
	 * */
//	@RequestMapping("index")
//	public String doIndex(Model model, HttpServletRequest request,
//			HttpSession session) {
//		BgArticle bgArticle = new BgArticle();
//		int page = DataHandle.returnValueInt(request, "page");
//		if (page == 0) {
//			page = 0;
//		} else {
//			page = page - 1;
//		}
//		String keyword = DataHandle.returnValue(request, "keyword");
//		bgArticle.setStartpage(page * Constant.BLOGPAGE);
//		bgArticle.setPage(Constant.BLOGPAGE);
//		List<BgArticle> blogList = bgArticleMapperService.selectList(bgArticle);
//		int countArticle = bgArticleMapperService.count(bgArticle);
//		model.addAttribute("blogList", blogList);
//		model.addAttribute("page", page);
//		model.addAttribute("keyword", keyword);
//		model.addAttribute("countArticle", countArticle);
//		return "blog/index";
//	}

//	/**
//	 * 我的博客
//	 * */
//	@RequestMapping("my-blog")
//	public String doMyBlog(HttpSession session, Model model,
//			HttpServletRequest request) {
//		BgUser bgUser = (BgUser) session.getAttribute(Constant.USER);
//		BgArticle bgArticle = new BgArticle();
//		int page = DataHandle.returnValueInt(request, "page");
//		if (page == 0) {
//			page = 0;
//		} else {
//			page = page - 1;
//		}
//		String keyword = DataHandle.returnValue(request, "keyword");
//		if (!"".equals(keyword)) {
//			Integer KeywordId = Init.keywordHm.get(bgUser.getBgUserId() + "").get(keyword);
//			bgArticle.setKeywords("," + KeywordId + ",");
//		}
//		bgArticle.setBgUserId(bgUser.getBgUserId());
//		bgArticle.setStartPage(page * Constant.BLOGPAGE);
//		bgArticle.setPage(Constant.BLOGPAGE);
//		List<BgArticle> blogList = bgArticleMapperService.selectList(bgArticle);
//		int countArticle = bgArticleMapperService.count(bgArticle);
//		model.addAttribute("blogList", blogList);
//		model.addAttribute("page", page);
//		model.addAttribute("keyword", keyword);
//		model.addAttribute("countArticle", countArticle);
//		return "blog/index";
//	}

	/**
	 * 我的博客(new)
	 * */
	@RequestMapping("{userid}")
	public String doMyBlogNew(HttpSession session, Model model,
			HttpServletRequest request,@PathVariable int userid) {
		BgUser bgUser = (BgUser) session.getAttribute(Constant.USER);
		boolean isOperator = false;
		/** 只有该博客的用户才能操作该博客 */
		if(bgUser != null && bgUser.getBgUserId() == userid){
			isOperator = true;
		}
		BgArticle bgArticle = new BgArticle();
		int page = DataHandle.returnValueInt(request, "page");
		if (page == 0) {
			page = 0;
		} else {
			page = page - 1;
		}
		String keyword = DataHandle.returnValue(request, "keyword");
		if (!"".equals(keyword)) {
			Integer KeywordId = Init.keywordHm.get(userid).get(keyword);
			bgArticle.setKeywords("," + KeywordId + ",");
		}
		bgArticle.setBgUserId(userid);
		bgArticle.setStartPage(page * Constant.BLOGPAGE);
		bgArticle.setPage(Constant.BLOGPAGE);
		List<BgArticle> blogList = bgArticleMapperService.selectList(bgArticle);
		int countArticle = bgArticleMapperService.count(bgArticle);
		model.addAttribute("blogList", blogList);
		model.addAttribute("userid", userid);
		model.addAttribute("page", page);
		model.addAttribute("keyword", keyword);
		model.addAttribute("countArticle", countArticle);
		model.addAttribute("isOperator",isOperator);
		return "blog/index";
	}

	/**
	 * 增加博客
	 * */
	@RequestMapping("my-addblog")
	public String doAddBlog() {
		return "blog/addblog";
	}

	@RequestMapping("my-blogList")
	public String doBlogList() {
		return "blog/blog-list";
	}

	@RequestMapping("my-blogListist")
	public void doBlogListAjax(HttpServletRequest request,
			HttpServletResponse response, HttpSession session)
			throws IOException {
		BgUser htUser = (BgUser) session.getAttribute(Constant.USER);
		int page = DataHandle.returnValueInt(request, "page");
		int rp = DataHandle.returnValueInt(request, "rp");
		BgArticle bgArticle = new BgArticle();
		bgArticle.setBgUserId(htUser.getBgUserId());
		bgArticle.setPage(rp);
		bgArticle.setStartPage(page);
		List<BgArticle> blogList = bgArticleMapperService
				.returnTitleEntity(bgArticle);
		List<BgArticle> blogListNew = new ArrayList<BgArticle>();
		for (BgArticle bgArticle1 : blogList) {
			String opearator = "<span attr="
					+ bgArticle1.getBgArticleId()
					+ "><a class='alterArticle' href=\"#\">修改</a><a class='delArticle' href=\"#\">删除</a></span>";
			bgArticle1.setIds(opearator);
			blogListNew.add(bgArticle1);
		}
		int count = bgArticleMapperService.count(bgArticle);
		Map<Object, Object> map = new HashMap<Object, Object>();
		map.put("rows", blogList);
		map.put("total", count);
		map.put("page", page);
		JSONObject jsonObject = JSONObject.fromObject(map);
		response.setContentType("text/html;charset=UTF-8");
		response.getWriter().write(jsonObject.toString());
	}

	/**
	 * 提交博客内容
	 * */
	@RequestMapping("my-addblog-post")
	public void doAddblogPost(HttpServletRequest request,
			HttpServletResponse response, HttpSession httpSession)
			throws IOException {
		String title = DataHandle.returnValue(request, "title");
		String content = DataHandle.handleValue(request.getParameter("content"));
		int articleType = DataHandle.returnValueInt(request, "article_type");
		String keyword = DataHandle.returnValue(request, "keyword");
		BgUser bgUser = new BgUser();
		bgUser = (BgUser) httpSession.getAttribute(Constant.USER);
		String short_content = "";
		short_content = HtmlHandle.filterTextToHTML(content);
		short_content = HtmlHandle.Html2Text(short_content);
		if (short_content.length() > 150) {
			short_content = short_content.substring(0, 150) + "...";
		}
		String keywordIds = insertKeywords(bgUser.getBgUserId(), keyword);
		BgArticle bgArticle = new BgArticle();
		bgArticle.setContent(content);
		bgArticle.setCreateDate(TimeHandle.currentTime());
		bgArticle.setShortContent(short_content);
		bgArticle.setTitle(title);
		bgArticle.setArticleType(articleType);
		bgArticle.setBgUserId(bgUser.getBgUserId());
		bgArticle.setKeywords(keywordIds);
		bgArticleMapperService.insert(bgArticle);
		response.getWriter().print("success");
	}

	/**
	 * 插入文章关键字,返回ids
	 * */
	public String insertKeywords(int userId, String keyword) {
		StringBuffer keywordIds = new StringBuffer(",");
		if (!keyword.isEmpty()) {
			String[] keywordSpl = keyword.split(" ");
			for (int i = 0; keywordSpl != null && i < keywordSpl.length; i++) {
				String keywordSingle = DataHandle.handleValue(keywordSpl[i]);
				if (keywordSingle == "") {
					continue;
				} else {
					BgKeyword bgKeyword = new BgKeyword();
					bgKeyword.setName(keywordSingle);
					bgKeyword.setBgUserId(userId);
					Integer isExistId = bgKeywordMapperService
							.selectByKeyword(bgKeyword);
					/** 如果已经 存在关键字,则将关键字id加入，否则插入关键字记录后插入 */
					if (isExistId == null) {
						bgKeywordMapperService.insert(bgKeyword);
						keywordIds.append(bgKeywordMapperService.maxId(bgKeyword) + ",");
					} else {
						keywordIds.append(isExistId + ",");
					}
				}
			}
		}
		return keywordIds.toString();
	}

	/**
	 * 单个博客文章页面
	 * */
	@RequestMapping("article/{article_id}")
	public String doArticle(@PathVariable int article_id, Model model) {
		BgArticle bgArticle = new BgArticle();
		bgArticle.setBgArticleId(article_id);
		bgArticle = bgArticleMapperService.select(bgArticle);
//		bgArticle
//				.setContent(HtmlHandle.filterTextToHTML(bgArticle.getContent().toString()));
		model.addAttribute("article", bgArticle);
		return "blog/article";
	}

	/**
	 * 删除文章
	 * */
	@RequestMapping("del-article")
	public void doDelArticle(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		String ids = DataHandle.returnValue(request, "ids");
		BgArticle bgArticle = new BgArticle();
		bgArticle.setIds(ids);
		bgArticleMapperService.deleteByIds(bgArticle);
		response.getWriter().write("success");
	}

	/**
	 * 更新文章
	 * */
	@RequestMapping("my-updateArticle/{article_id}")
	public String doMyArticle(@PathVariable int article_id, Model model) {
		BgArticle bgArticle = new BgArticle();
		bgArticle.setBgArticleId(article_id);
		bgArticle = bgArticleMapperService.select(bgArticle);
		String keywords = bgArticle.getKeywords();
		if(!keywords.isEmpty()){
			if(",".equals(keywords)){
				keywords = "";
			}else{
				keywords = bgArticle.getKeywords().substring(1,
						bgArticle.getKeywords().length() - 1);
				BgKeyword bgKeyword = new BgKeyword();
				bgKeyword.setIds(keywords);
				keywords = bgKeywordMapperService.selectGroupKeywords(bgKeyword);
				keywords = keywords.replaceAll(",", " ");
				bgArticle.setKeywords(keywords);
			}
		}
		model.addAttribute("article", bgArticle);
		return "blog/my-updateArticle";
	}

	@RequestMapping("my-updateblog-post")
	public void doMyUpdateblogPost(HttpServletRequest request,
			HttpServletResponse response, HttpSession session)
			throws IOException {
		int article_id = DataHandle.returnValueInt(request, "bgArticleId");
		String title = DataHandle.returnValue(request, "title");
		String content = DataHandle.returnValue(request, "content");
		String keyword = DataHandle.returnValue(request, "keyword");
		BgUser htUser = (BgUser) session.getAttribute(Constant.USER);
		String keywordIds = insertKeywords(htUser.getBgUserId(), keyword);
		BgArticle bgArticle = new BgArticle();
		bgArticle.setBgArticleId(article_id);
		bgArticle.setTitle(title);
		bgArticle.setBgUserId(htUser.getBgUserId());
		bgArticle.setContent(content);
		bgArticle.setKeywords(keywordIds);
		bgArticleMapperService.update(bgArticle);
		response.getWriter().write("success");

	}

	public static void main(String[] args) {
		
	}

}
