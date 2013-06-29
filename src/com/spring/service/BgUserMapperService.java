package com.spring.service;

import com.spring.entity.BgUser;

public interface BgUserMapperService extends BaseService<BgUser>{

	public BgUser returnEntityByUserName(BgUser bgUser);
	
}
