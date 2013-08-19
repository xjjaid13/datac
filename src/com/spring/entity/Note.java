package com.spring.entity;

public class Note extends BaseEntity{
	
	private Integer noteId;
	
	private String content;
	
	private Integer noteTypeId;
	
	
	public Integer getNoteId() {
		return noteId;
	}
	
	public String getContent() {
		return content;
	}
	
	public Integer getNoteTypeId() {
		return noteTypeId;
	}
	
	
	public void setNoteId(Integer noteId) {
		this.noteId = noteId;
	}
	
	public void setContent(String content) {
		this.content = content;
	}
	
	public void setNoteTypeId(Integer noteTypeId) {
		this.noteTypeId = noteTypeId;
	}
	
	public String toString(){
		return "Note";
	}
}
