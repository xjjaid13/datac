package com.spring.entity;

import java.util.LinkedList;

public class WebLinktype extends BaseEntity{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private Integer webLinktypeId;
	
	private String name;
	
	private Integer userId;
	
	private boolean isChange;
	
	private LinkedList<WebLink> webLinkList;
	
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

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public LinkedList<WebLink> getWebLinkList() {
		return webLinkList;
	}

	public void setWebLinkList(LinkedList<WebLink> webLinkList) {
		this.webLinkList = webLinkList;
	}

	public boolean isChange() {
		return isChange;
	}

	public void setChange(boolean isChange) {
		this.isChange = isChange;
	}

}
