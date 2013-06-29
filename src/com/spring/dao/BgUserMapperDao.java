package com.spring.dao;

import com.spring.entity.BgUser;

public interface BgUserMapperDao extends BaseDao<BgUser>{

	public BgUser returnEntityByUserName(BgUser bgUser);
	
}
