package com.music.mute.test;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class TestController {
	
	 @GetMapping("/test1")
	    public String showTestPage1(HttpSession session) {
		 int[] genres = new int[10];
		 session.setAttribute("musicGenres", genres);
			 /* setAttribute(String name, Object value):
			  * name은 데이터를 식별하는데 사용되는 이름value는 저장하려는 객체
			 */
	        return "test/test1";
	    }
	 
	 @GetMapping("/test2")
	    public String showTestPage2() { return "test/test2"; }
	 @GetMapping("/test3")
	    public String showTestPage3() { return "test/test3"; } 
	 
	         
	 /*@PostMapping("/update-genres")
	  * public String updateGenres(HttpSession session) {
	  * return "result_*";
		}
	  * 
	  * */   
	   

}///////////////////////////////////

