package com.spring.entity;

import java.util.List;

public class WebLinktype extends BaseEntity{
	
	private Integer webLinktypeId;
	
	private String name;
	
	private Integer bgUserId;
	
	private List<WebLink> webLinkList;
	
	public Integer getWebLinktypeId() {
		return webLinktypeId;
	}
	
	public String getName() {
		return name;
	}
	
	public Integer getBgUserId() {
		return bgUserId;
	}
	
	
	public void setWebLinktypeId(Integer webLinktypeId) {
		this.webLinktypeId = webLinktypeId;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public void setBgUserId(Integer bgUserId) {
		this.bgUserId = bgUserId;
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
	
}
