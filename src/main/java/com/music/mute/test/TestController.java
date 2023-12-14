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
			  * name은 데이터를 식별하는데 사용되는 이름이며, value는 저장하려는 객체입니다.
			  * 한글 주석 깨짐... 다른 프로젝트도 마찬가지
			  * 안녕하세요
			 */
	        return "test/test1";
	    }
	 
	 @GetMapping("/test2")
	    public String showTestPage2() { return "test/test2"; }
	 @GetMapping("/test3")
	    public String showTestPage3() { return "test/test3"; } 
	 @GetMapping("/test4")
	    public String showTestPage4() { return "test/test4"; }
	 @GetMapping("/test5")
	    public String showTestPage5() { return "test/test5"; }
	         
	 /*@PostMapping(""/submit-data"")
	  * public String submit-data() {
	  * return "";
		}
	  * 
	  * */   
	   

}///////////////////////////////////

