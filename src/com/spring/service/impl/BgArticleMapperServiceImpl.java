package com.spring.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.dao.BgArticleMapperDao;
import com.spring.entity.BgArticle;
import com.spring.service.BgArticleMapperService;

@Service
public class BgArticleMapperServiceImpl extends BaseServiceImpl<BgArticle> implements BgArticleMapperService{

	@Autowired
	BgArticleMapperDao bgArticleMapperDao;

	@Override
	public List<BgArticle> returnTitleEntity(BgArticle t){
		return bgArticleMapperDao.returnTitleEntity(t);
	}
	
}
