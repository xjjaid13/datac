package com.spring.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.dao.BgUserMapperDao;
import com.spring.entity.BgUser;
import com.spring.service.BgUserMapperService;

@Service
public class BgUserMapperServiceImpl extends BaseServiceImpl<BgUser> implements BgUserMapperService{

	@Autowired
	BgUserMapperDao bgUserMapperDao;
	
	@Override
	public BgUser returnEntityByUserName(BgUser bgUser) {
		return bgUserMapperDao.returnEntityByUserName(bgUser);
	}

}
