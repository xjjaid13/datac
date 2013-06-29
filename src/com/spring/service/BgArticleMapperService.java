package com.spring.service;

import java.util.List;

import com.spring.entity.BgArticle;

public interface BgArticleMapperService extends BaseService<BgArticle>{

	public List<BgArticle> returnTitleEntity(BgArticle bgArticle);
	
}
