package com.spring.dao;

import java.util.List;
import java.util.Map;

import com.spring.entity.BgArticle;

public interface BgArticleMapperDao extends BaseDao<BgArticle>{

	List<BgArticle> returnTitleEntity(BgArticle bgArticle);
	
	public List<Map<String,Object>> selectYear(BgArticle bgArticle);
	
	public List<Map<String,Object>> selectMonth(BgArticle bgArticle);
	
	public List<Map<String,Object>> selectDay(BgArticle bgArticle);
	
}
