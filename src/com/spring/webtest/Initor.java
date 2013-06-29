package com.spring.webtest;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationEvent;
import org.springframework.context.ApplicationListener;
import org.springframework.stereotype.Component;

import com.spring.entity.BgKeyword;
import com.spring.entity.BgUser;
import com.spring.service.BgKeywordMapperService;
import com.spring.service.BgUserMapperService;
import com.util.Init;

@SuppressWarnings("rawtypes")
@Component
public class Initor implements ApplicationListener{

	@Autowired
	private BgKeywordMapperService bgKeywordMapperService;
	
	@Autowired
	private BgUserMapperService bgUserMapperService;
	
	@Override
	public void onApplicationEvent(ApplicationEvent arg0) {
		/** 将各用户的关键词存入java缓存中 */
		List<BgUser> userList = bgUserMapperService.selectList(new BgUser());
		
		for(int i = 0; userList != null && i < userList.size(); i++){
			BgUser bgUser = userList.get(i);
			BgKeyword bgKeyword = new BgKeyword();
			bgKeyword.setBgUserId(bgUser.getBgUserId());
			List<BgKeyword> keywordList = bgKeywordMapperService.selectAllKeyword(bgKeyword);
			HashMap<String,Integer> keyMap = new HashMap<String,Integer>();
			for(int j = 0 ; keywordList != null && j < keywordList.size() ; j++){
				bgKeyword = keywordList.get(j);
				keyMap.put(bgKeyword.getName(), bgKeyword.getBgKeywordId());
			}
			Init.keywordHm.put(bgUser.getBgUserId(), keyMap);
		}
	}

}
