package com.spring.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
    
}
