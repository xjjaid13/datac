package com.spring.entity;

public class BgUser extends BaseEntity{
	
	private Integer bgUserId;
	
	private String username;
	
	private String password;
	
	
	public Integer getBgUserId() {
		return bgUserId;
	}
	
	public String getUsername() {
		return username;
	}
	
	public String getPassword() {
		return password;
	}
	
	
	public void setBgUserId(Integer bgUserId) {
		this.bgUserId = bgUserId;
	}
	
	public void setUsername(String username) {
		this.username = username;
	}
	
	public void setPassword(String password) {
		this.password = password;
	}
	
	public String toString(){
		return "BgUser";
	}
}
