package com.spring.entity;

import java.util.List;

public class WebLinktype extends BaseEntity{
	
	private Integer webLinktypeId;
	
	private String name;
	
	private Integer userId;
	
	private List<WebLink> webLinkList;
	
	public Integer getWebLinktypeId() {
		return webLinktypeId;
	}
	
	public String getName() {
		return name;
	}
	
	public void setWebLinktypeId(Integer webLinktypeId) {
		this.webLinktypeId = webLinktypeId;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public String toString(){
		return "WebLinktype";
	}

	public List<WebLink> getWebLinkList() {
		return webLinkList;
	}

	public void setWebLinkList(List<WebLink> webLinkList) {
		this.webLinkList = webLinkList;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	
}
