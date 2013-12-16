package test;

import java.util.List;

import net.sf.json.JSONObject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.spring.entity.Blog;
import com.spring.entity.Note;
import com.spring.service.BlogMapperService;
import com.spring.service.NoteMapperService;
import com.spring.service.WebLinktypeMapperService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:spring-servlet.xml")
public class Test1 {

	@Autowired
	WebLinktypeMapperService webLinktypeMapperService;
	
	@Autowired
	NoteMapperService noteMapperService;
	
	@Autowired
	BlogMapperService blogMapperService;
	
	public void testToIndex() {
		Note note = new Note();
		note.setCondition("noteId = 141");
		List<Note> list = noteMapperService.selectList(note);
		System.out.println(".........................="+list.size());
	}
	
	@Test
	public void test(){
		Blog blog = new Blog();
		blog.setUserId(4);
		blog.setPage(10);
		blog.setStartPage(1);
		List<Blog> blogList = blogMapperService.returnTitleEntity(blog);
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("data", blogList);
		System.out.println("...."+jsonObject.toString());
	}
	
	public static void main(String[] args) {
		
	}
	
}
