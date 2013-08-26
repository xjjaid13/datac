package com.spring.entity;

public class Note extends BaseEntity{
	
	private Integer noteId;
	
	private String content;
	
	private Integer noteTypeId;
	
	private String createDate;
	
	private Integer bgUserId;
	
	
	public Integer getNoteId() {
		return noteId;
	}
	
	public String getContent() {
		return content;
	}
	
	public Integer getNoteTypeId() {
		return noteTypeId;
	}
	
	public String getCreateDate() {
		return createDate;
	}
	
	public Integer getBgUserId() {
		return bgUserId;
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
	
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	
	public void setBgUserId(Integer bgUserId) {
		this.bgUserId = bgUserId;
	}
	
	public String toString(){
		return "Note";
	}
}
