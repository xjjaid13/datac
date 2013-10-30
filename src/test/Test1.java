package test;

import java.lang.reflect.ParameterizedType;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.spring.dao.NoteMapperDao;
import com.spring.entity.Note;
import com.spring.entity.WebLinktype;
import com.spring.service.NoteMapperService;
import com.spring.service.WebLinktypeMapperService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:spring-servlet.xml")
public class Test1 {

	@Autowired
	WebLinktypeMapperService webLinktypeMapperService;
	
	@Autowired
	NoteMapperService noteMapperService;
	
	@Test
	public void testToIndex() {
		Note note = new Note();
		note.setCondition("noteId = 141");
		List<Note> list = noteMapperService.selectList(note);
		System.out.println(".........................="+list.size());
	}
	
}
