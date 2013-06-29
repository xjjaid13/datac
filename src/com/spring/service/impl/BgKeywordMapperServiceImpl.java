package com.spring.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.dao.BgKeywordMapperDao;
import com.spring.entity.BgKeyword;
import com.spring.service.BgKeywordMapperService;

@Service
public class BgKeywordMapperServiceImpl extends BaseServiceImpl<BgKeyword> implements BgKeywordMapperService{

	@Autowired
	BgKeywordMapperDao bgKeywordMapperDao;
	
	@Override
	public Integer selectByKeyword(BgKeyword bgKeyword) {
		return bgKeywordMapperDao.selectByKeyword(bgKeyword);
	}

	@Override
	public String selectGroupKeywords(BgKeyword bgKeyword) {
		return bgKeywordMapperDao.selectGroupKeywords(bgKeyword);
	}
	
	public List<BgKeyword> selectAllKeyword(BgKeyword bgKeyword){
		return bgKeywordMapperDao.selectAllKeyword(bgKeyword);
	}

}
