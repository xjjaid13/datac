package com.spring.entity;

public class BgKeyword extends BaseEntity{
	
	private Integer bgKeywordId;
	
	private String name;
	
	private Integer bgUserId;
	
	
	public Integer getBgKeywordId() {
		return bgKeywordId;
	}
	
	public String getName() {
		return name;
	}
	
	public Integer getBgUserId() {
		return bgUserId;
	}
	
	
	public void setBgKeywordId(Integer bgKeywordId) {
		this.bgKeywordId = bgKeywordId;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public void setBgUserId(Integer bgUserId) {
		this.bgUserId = bgUserId;
	}
	
	public String toString(){
		return "BgKeyword";
	}
}
