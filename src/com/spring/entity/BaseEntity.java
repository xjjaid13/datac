package com.spring.entity;

public class BaseEntity {

	private int startPage = 0;
	
	private int page = 10;
	
	private String ids;
	
	private String condition;

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		if(startPage > 0){
			startPage = (startPage - 1) * page;
		}
		this.startPage = startPage;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public String getIds() {
		return ids;
	}

	public void setIds(String ids) {
		this.ids = ids;
	}

    public String getCondition() {
        return condition;
    }

    public void setCondition(String condition) {
        this.condition = condition;
    }
	
}
