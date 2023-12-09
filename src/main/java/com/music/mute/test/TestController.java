package com.music.mute.test;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class TestController {
	 @GetMapping("/test")
	    public String showPlaylistPage() {
	        return "test"; 
	    }

}

