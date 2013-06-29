package com.spring.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.dao.WebLinktypeMapperDao;
import com.spring.entity.WebLinktype;
import com.spring.service.WebLinktypeMapperService;

@Service("webLinktypeMapperService")
public class WebLinktypeMapperServiceImpl extends BaseServiceImpl<WebLinktype> implements WebLinktypeMapperService{

    @Autowired
	private WebLinktypeMapperDao webLinktypeMapperDao;
	
	public List<WebLinktype> returnEntityList(WebLinktype webLinktype){
		return webLinktypeMapperDao.returnEntityList(webLinktype);
	}

}
