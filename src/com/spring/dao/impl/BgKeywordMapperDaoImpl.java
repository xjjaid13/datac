package com.spring.dao.impl;

import java.util.List;
import org.springframework.stereotype.Repository;
import com.spring.dao.BgKeywordMapperDao;
import com.spring.entity.BgKeyword;

@Repository
public class BgKeywordMapperDaoImpl extends BaseDaoImpl<BgKeyword> implements BgKeywordMapperDao {

	@Override
	public Integer selectByKeyword(BgKeyword bgKeyword) {
		return sqlSessionTemplate.selectOne("selectByKeyword", bgKeyword);
	}

	@Override
	public String selectGroupKeywords(BgKeyword bgKeyword) {
		return sqlSessionTemplate.selectOne("selectGroupKeywords", bgKeyword);
	}

	@Override
	public List<BgKeyword> selectAllKeyword(BgKeyword bgKeyword) {
		return sqlSessionTemplate.selectList("selectAllKeyword",bgKeyword);
	}
	
}
