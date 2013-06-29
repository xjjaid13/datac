package com.spring.dao.impl;

import org.springframework.stereotype.Repository;
import com.spring.dao.BgUserMapperDao;
import com.spring.entity.BgUser;

@Repository
public class BgUserMapperDaoImpl extends BaseDaoImpl<BgUser> implements BgUserMapperDao {

	@Override
	public BgUser returnEntityByUserName(BgUser bgUser) {
		return (BgUser)sqlSessionTemplate.selectOne("returnUserEntityByUserName", bgUser);
	}
	
}
