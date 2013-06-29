package com.spring.dao;

import java.util.List;

import com.spring.entity.BgKeyword;

public interface BgKeywordMapperDao extends BaseDao<BgKeyword>{

	/** 根据关键字和用户名id查询关键字id */
	Integer selectByKeyword(BgKeyword bgKeyword);
	
	/** 根据userid查询关键字 */
	String selectGroupKeywords(BgKeyword bgKeyword);
	
	List<BgKeyword> selectAllKeyword(BgKeyword bgKeyword);
	
}
