package test;

import java.lang.reflect.ParameterizedType;
import java.util.List;

import net.sf.json.JSONObject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.spring.dao.NoteMapperDao;
import com.spring.entity.BgArticle;
import com.spring.entity.BgUser;
import com.spring.entity.Note;
import com.spring.entity.WebLinktype;
import com.spring.service.BgArticleMapperService;
import com.spring.service.NoteMapperService;
import com.spring.service.WebLinktypeMapperService;
import com.util.Constant;
import com.util.DataHandle;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:spring-servlet.xml")
public class Test1 {

	@Autowired
	WebLinktypeMapperService webLinktypeMapperService;
	
	@Autowired
	NoteMapperService noteMapperService;
	
	@Autowired
	BgArticleMapperService bgArticleMapperService;
	
	public void testToIndex() {
		Note note = new Note();
		note.setCondition("noteId = 141");
		List<Note> list = noteMapperService.selectList(note);
		System.out.println(".........................="+list.size());
	}
	
	@Test
	public void test(){
		BgArticle bgArticle = new BgArticle();
		bgArticle.setBgUserId(4);
		bgArticle.setPage(10);
		bgArticle.setStartPage(1);
		List<BgArticle> blogList = bgArticleMapperService.returnTitleEntity(bgArticle);
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("data", blogList);
		System.out.println("...."+jsonObject.toString());
	}
	
	public static void main(String[] args) {
		
	}
	
}
