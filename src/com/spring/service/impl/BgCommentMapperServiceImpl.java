package com.spring.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.spring.service.impl.BaseServiceImpl;
import com.spring.dao.BgCommentMapperDao;
import com.spring.entity.BgComment;
import com.spring.service.BgCommentMapperService;

@Service("bgCommentMapperService")
public class BgCommentMapperServiceImpl extends BaseServiceImpl<BgComment> implements BgCommentMapperService{

	@Autowired
	BgCommentMapperDao bgCommentMapperDao;

}
