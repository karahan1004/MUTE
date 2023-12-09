package com.music.mute.test;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class TestController {
	
	 @GetMapping("/test1")
	    public String TestPage() {
	        return "test/test1"; 
	    }

}

