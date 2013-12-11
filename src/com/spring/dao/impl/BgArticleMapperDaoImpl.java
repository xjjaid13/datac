package com.spring.dao.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.spring.dao.BgArticleMapperDao;
import com.spring.entity.BgArticle;

@Repository
public class BgArticleMapperDaoImpl extends BaseDaoImpl<BgArticle> implements BgArticleMapperDao {

	@Override
	public List<BgArticle> returnTitleEntity(BgArticle bgArticle) {
		return sqlSessionTemplate.selectList("returnTitleListEntity", bgArticle);
	}
	
	@Override
	public List<Map<String,Object>> selectYear(BgArticle bgArticle) {
		return super.sqlSessionTemplate.selectList("selectBlogYear", bgArticle);
	}

	@Override
	public List<Map<String, Object>> selectMonth(BgArticle bgArticle) {
		return super.sqlSessionTemplate.selectList("selectBlogMonth", bgArticle);
	}

	@Override
	public List<Map<String, Object>> selectDay(BgArticle bgArticle) {
		return super.sqlSessionTemplate.selectList("selectBlogDay", bgArticle);
	}
	
}
