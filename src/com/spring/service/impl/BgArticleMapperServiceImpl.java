package com.spring.service.impl;

import java.util.List;
import java.util.Map;

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
	
	@Override
	public List<Map<String, Object>> selectYear(BgArticle t) {
		return bgArticleMapperDao.selectYear(t);
	}

	@Override
	public List<Map<String, Object>> selectMonth(BgArticle t) {
		return bgArticleMapperDao.selectMonth(t);
	}

	@Override
	public List<Map<String, Object>> selectDay(BgArticle t) {
		return bgArticleMapperDao.selectDay(t);
	}
	
}
