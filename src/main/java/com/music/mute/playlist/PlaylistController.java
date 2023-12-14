package com.music.mute.playlist;

import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


@Controller
public class PlaylistController {
private static final Logger logger = LoggerFactory.getLogger(PlaylistController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */

	//기본예제, 추후 수정 예정
	@RequestMapping(value = "/playlist", method = RequestMethod.GET)
	public String home(Locale locale) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		
		return "/playlist";
	}
}
