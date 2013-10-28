package com.spring.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.entity.BgUser;
import com.spring.entity.Note;
import com.spring.service.NoteMapperService;
import com.util.Constant;
import com.util.DataHandle;
import com.util.TimeHandle;

@Controller
@RequestMapping("note")
public class NoteController {

    @Autowired
    NoteMapperService noteMapperService;
    
    @RequestMapping("{bgUserId}")
    public String toIndex(@PathVariable int bgUserId,Model model){
        Note note = new Note();
        note.setBgUserId(bgUserId);
        List<Note> noteList = noteMapperService.selectList(note);
        model.addAttribute("noteList", noteList);
        return "note/index";
    }
    
    @RequestMapping("my-addNote")
    public void addNote(HttpServletRequest request,HttpServletResponse response,HttpSession session) throws IOException{
        BgUser bgUser = (BgUser) session.getAttribute(Constant.USER);
        String content = DataHandle.returnValue(request, "content");
        Note note = new Note();
        note.setContent(content);
        note.setCreateDate(TimeHandle.currentTime());
        note.setBgUserId(bgUser.getBgUserId());
        noteMapperService.insert(note);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("result", "success");
        jsonObject.put("message", "新增成功");
        response.getWriter().write(jsonObject.toString());
    }
    
    @RequestMapping("returnNoteContent")
    public void returnNoteContent(HttpServletRequest request,HttpServletResponse response,HttpSession session) throws IOException, InterruptedException{
    	int startPage = DataHandle.returnValueInt(request, "startPage");
    	int recordNum = DataHandle.returnValueInt(request, "recordNum");
    	String searchKey = DataHandle.returnValue(request, "searchKey");
    	String timeValue = DataHandle.returnValue(request, "timeValue");
    	// 1 年 2月  3日
    	String condition = " 1 = 1 ";
    	int timeType = DataHandle.returnValueInt(request, "timeType");
    	if(timeType == 1){
    		condition += " and createDate >= " + timeValue + "-01-01 00:00:00 and createDate <= " + timeValue + "-12-31 23:59:59";
    	}else if(timeType == 2){
    		condition += " and createDate >= " + timeValue + "-01 00:00:00 and createDate <= " + timeValue + "-31 23:59:59";
    	}else if(timeType == 3){
    		condition += " and createDate >= " + timeValue + " 00:00:00 and createDate <= " + timeValue + " 23:59:59";
    	}
        Note note = new Note();
        note.setCondition(condition);
        note.setStartPage(startPage);
        note.setPage(recordNum);
        List<Note> list = noteMapperService.selectList(note);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("data", list);
        response.getWriter().write(jsonObject.toString());
    }
    
    @RequestMapping("test")
    public void test(HttpServletRequest request,HttpServletResponse response,HttpSession session) throws IOException{
        JSONArray listDay = new JSONArray();
        JSONObject jsonObjectDay = new JSONObject();
        jsonObjectDay.put("display", "2日");
        jsonObjectDay.put("num", "3");
        listDay.add(jsonObjectDay);
        
        JSONArray listWeek = new JSONArray();
        JSONObject jsonObjectWeek = new JSONObject();
        jsonObjectWeek.put("display", "2周");
        jsonObjectWeek.put("num", "3");
        jsonObjectWeek.put("data", listDay);
        listWeek.add(jsonObjectWeek);
        
        JSONArray listMonth = new JSONArray();
        JSONObject jsonObjectMonth = new JSONObject();
        jsonObjectMonth.put("display", "2月");
        jsonObjectMonth.put("num", "3");
        jsonObjectMonth.put("data", listWeek);
        listMonth.add(jsonObjectMonth);
        
        JSONArray listYear = new JSONArray();
        JSONObject jsonObjectYear = new JSONObject();
        jsonObjectYear.put("display", "2000年");
        jsonObjectYear.put("num", "3");
        jsonObjectYear.put("data", listMonth);
        listYear.add(jsonObjectYear);
        
        JSONObject object = new JSONObject();
        object.put("data", listYear);
        String jsonString = JSONObject.fromObject(object).toString();
        response.getWriter().write(JSONObject.fromObject(object).toString());
    }
    
    public static void main(String[] args) {
        
    }
    
}
