package com.music.mute.result;

import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class ResultController {
	
	private static final Logger logger = LoggerFactory.getLogger(ResultController.class);
	
	@RequestMapping(value = "/result_ballad", method = RequestMethod.GET)
	public String result_ballad(Locale locale) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		return "/result_ballad";
	}
	
	@RequestMapping(value = "/result_classic", method = RequestMethod.GET)
	public String result_classic(Locale locale) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		return "/result_classic";
	}
	
	@RequestMapping(value = "/result_dance", method = RequestMethod.GET)
	public String result_dance(Locale locale) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		return "/result_dance";
	}
	
	@RequestMapping(value = "/result_disco", method = RequestMethod.GET)
	public String result_disco(Locale locale) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		return "/result_disco";
	}
	
}