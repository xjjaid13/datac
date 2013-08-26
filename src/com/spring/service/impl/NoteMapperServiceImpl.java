package com.spring.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.service.impl.BaseServiceImpl;
import com.spring.dao.NoteMapperDao;
import com.spring.entity.Note;
import com.spring.service.NoteMapperService;

@Service
@Transactional
public class NoteMapperServiceImpl extends BaseServiceImpl<Note> implements NoteMapperService{

	@Autowired
	NoteMapperDao noteMapperDao;

}
