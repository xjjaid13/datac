package com.spring.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.spring.service.impl.BaseServiceImpl;
import com.spring.dao.NoteMapperDao;
import com.spring.entity.Note;
import com.spring.service.NoteMapperService;

@Service("noteMapperService")
public class NoteMapperServiceImpl extends BaseServiceImpl<Note> implements NoteMapperService{

	@Autowired
	NoteMapperDao noteMapperDao;

}
