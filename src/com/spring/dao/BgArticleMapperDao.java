package com.spring.dao;

import java.util.List;

import com.spring.entity.BgArticle;

public interface BgArticleMapperDao extends BaseDao<BgArticle>{

	List<BgArticle> returnTitleEntity(BgArticle bgArticle);
	
}
