package com.spring.entity;

public class BgComment extends BaseEntity{
	
	private Integer bgCommentId;
	
	private Integer bgUserId;
	
	private String content;
	
	private Integer bgArticleId;
	
	
	public Integer getBgCommentId() {
		return bgCommentId;
	}
	
	public Integer getBgUserId() {
		return bgUserId;
	}
	
	public String getContent() {
		return content;
	}
	
	public Integer getBgArticleId() {
		return bgArticleId;
	}
	
	
	public void setBgCommentId(Integer bgCommentId) {
		this.bgCommentId = bgCommentId;
	}
	
	public void setBgUserId(Integer bgUserId) {
		this.bgUserId = bgUserId;
	}
	
	public void setContent(String content) {
		this.content = content;
	}
	
	public void setBgArticleId(Integer bgArticleId) {
		this.bgArticleId = bgArticleId;
	}
	
	public String toString(){
		return "BgComment";
	}
}
