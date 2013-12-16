package com.spring.entity;

public class User extends BaseEntity{
	
	
	private String username;
	
	private String password;
	
	private String style;
	
	private Integer userId;

	public String getUsername() {
		return username;
	}
	
	public String getPassword() {
		return password;
	}
	

	
	public void setUsername(String username) {
		this.username = username;
	}
	
	public void setPassword(String password) {
		this.password = password;
	}
	
	public String toString(){
		return "User";
	}

	public String getStyle() {
		return style;
	}

	public void setStyle(String style) {
		this.style = style;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}
}
