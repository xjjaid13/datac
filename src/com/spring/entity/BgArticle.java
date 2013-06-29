package com.spring.entity;

public class BgArticle extends BaseEntity{
	
	private Integer bgArticleId;
	
	private String title;
	
	private String content;
	
	private String createDate;
	
	private Integer hit;
	
	private Integer bgUserId;
	
	private String shortContent;
	
	private Integer commentnum;
	
	private Integer articleType;
	
	private String keywords;
	
	
	public Integer getBgArticleId() {
		return bgArticleId;
	}
	
	public String getTitle() {
		return title;
	}
	
	
	public String getCreateDate() {
		return createDate;
	}
	
	public Integer getHit() {
		return hit;
	}
	
	public Integer getBgUserId() {
		return bgUserId;
	}
	
	public String getShortContent() {
		return shortContent;
	}
	
	public Integer getCommentnum() {
		return commentnum;
	}
	
	public Integer getArticleType() {
		return articleType;
	}
	
	public String getKeywords() {
		return keywords;
	}
	
	
	public void setBgArticleId(Integer bgArticleId) {
		this.bgArticleId = bgArticleId;
	}
	
	public void setTitle(String title) {
		this.title = title;
	}
	
	
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	
	public void setHit(Integer hit) {
		this.hit = hit;
	}
	
	public void setBgUserId(Integer bgUserId) {
		this.bgUserId = bgUserId;
	}
	
	public void setShortContent(String shortContent) {
		this.shortContent = shortContent;
	}
	
	public void setCommentnum(Integer commentnum) {
		this.commentnum = commentnum;
	}
	
	public void setArticleType(Integer articleType) {
		this.articleType = articleType;
	}
	
	public void setKeywords(String keywords) {
		this.keywords = keywords;
	}
	
	public String toString(){
		return "BgArticle";
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
}
