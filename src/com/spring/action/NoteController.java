package com.spring.action;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.entity.Note;

@Controller
@RequestMapping("note")
public class NoteController {

    @RequestMapping("{userID}")
    public String toIndex(){
        return "note/index";
    }
    
    @RequestMapping("addNote")
    public void addNote(HttpServletRequest request){
        System.out.println(request.getParameter("test"));
    }
    
}
