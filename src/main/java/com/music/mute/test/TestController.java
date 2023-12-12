package com.music.mute.test;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class TestController {
	
	 @GetMapping("/test1")
	    public String TestPage() {
	        return "test/test1"; 
	    }
	 
	 @GetMapping("/test2")
	    public String TestPage2() {
	        return "test/test2"; 
	    }
	 @GetMapping("/test3")
	    public String TestPage3() {
	        return "test/test3"; 
	    }
	 @GetMapping("/test4")
	    public String TestPage4() {
	        return "test/test4"; 
	    }
	 @GetMapping("/test5")
	    public String TestPage5() {
	        return "test/test5"; 
	    }
	   

}

