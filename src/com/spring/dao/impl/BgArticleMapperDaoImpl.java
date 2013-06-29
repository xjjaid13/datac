package com.spring.dao.impl;

import java.util.List;
import org.springframework.stereotype.Repository;
import com.spring.dao.BgArticleMapperDao;
import com.spring.entity.BgArticle;

@Repository
public class BgArticleMapperDaoImpl extends BaseDaoImpl<BgArticle> implements BgArticleMapperDao {

	@Override
	public List<BgArticle> returnTitleEntity(BgArticle bgArticle) {
		return sqlSessionTemplate.selectList("returnTitleListEntity", bgArticle);
	}
	
}
