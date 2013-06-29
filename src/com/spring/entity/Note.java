package com.spring.entity;

public class Note extends BaseEntity{
	
	private Integer noteID;
	
	private String content;
	
	
	public Integer getNoteID() {
		return noteID;
	}
	
	public String getContent() {
		return content;
	}
	
	
	public void setNoteID(Integer noteID) {
		this.noteID = noteID;
	}
	
	public void setContent(String content) {
		this.content = content;
	}
	
	public String toString(){
		return "Note";
	}
}
