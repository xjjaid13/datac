package com.spring.entity;

public class WebLink extends BaseEntity{
	
	private Integer webLinkId;
	
	private String name;
	
	private String link;
	
	private Integer webLinktypeId;
	
	private Integer bgUserId;
	
	private Integer hit;
	
	
	public Integer getWebLinkId() {
		return webLinkId;
	}
	
	public String getName() {
		return name;
	}
	
	public String getLink() {
		return link;
	}
	
	public Integer getWebLinktypeId() {
		return webLinktypeId;
	}
	
	public Integer getBgUserId() {
		return bgUserId;
	}
	
	public Integer getHit() {
		return hit;
	}
	
	
	public void setWebLinkId(Integer webLinkId) {
		this.webLinkId = webLinkId;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public void setLink(String link) {
		this.link = link;
	}
	
	public void setWebLinktypeId(Integer webLinktypeId) {
		this.webLinktypeId = webLinktypeId;
	}
	
	public void setBgUserId(Integer bgUserId) {
		this.bgUserId = bgUserId;
	}
	
	public void setHit(Integer hit) {
		this.hit = hit;
	}
	
	public String toString(){
		return "WebLink";
	}
}
