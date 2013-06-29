package test;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.FileSystemXmlApplicationContext;

import com.spring.entity.WebLinktype;
import com.spring.service.WebLinktypeMapperService;


public class Test {

    @org.junit.Test
    public void test(){
        ApplicationContext context = new FileSystemXmlApplicationContext("WebContent/WEB-INF/spring-servlet.xml");
        WebLinktypeMapperService webLinktypeMapperService = (WebLinktypeMapperService) context.getBean("webLinktypeMapperService");
        int i = webLinktypeMapperService.count(new WebLinktype());
        System.out.print(i);
    }
    
}
