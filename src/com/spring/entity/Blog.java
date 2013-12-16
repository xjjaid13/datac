package com.spring.entity;

public class Blog extends BaseEntity{
	
	private Integer blogId;
	
	private String title;
	
	private String content;
	
	private String createDate;
	
	private Integer hit;
	
	private Integer userId;
	
	private String shortContent;
	
	private Integer commentnum;
	
	private Integer blogType;
	
	private String keywords;
	
	public String getTitle() {
		return title;
	}
	
	public String getCreateDate() {
		return createDate;
	}
	
	public Integer getHit() {
		return hit;
	}
	
	public String getShortContent() {
		return shortContent;
	}
	
	public Integer getCommentnum() {
		return commentnum;
	}
	
	public String getKeywords() {
		return keywords;
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
	
	public void setShortContent(String shortContent) {
		this.shortContent = shortContent;
	}
	
	public void setCommentnum(Integer commentnum) {
		this.commentnum = commentnum;
	}
	
	public void setKeywords(String keywords) {
		this.keywords = keywords;
	}
	
	public String toString(){
		return "Blog";
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}


	public Integer getBlogId() {
		return blogId;
	}


	public void setBlogId(Integer blogId) {
		this.blogId = blogId;
	}


	public Integer getUserId() {
		return userId;
	}


	public void setUserId(Integer userId) {
		this.userId = userId;
	}


	public Integer getBlogType() {
		return blogType;
	}


	public void setBlogType(Integer blogType) {
		this.blogType = blogType;
	}
}
