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
		
		return "result/result_ballad";
	}
	
	@RequestMapping(value = "/result_classic", method = RequestMethod.GET)
	public String result_classic(Locale locale) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		return "result/result_classic";
	}
	
	@RequestMapping(value = "/result_dance", method = RequestMethod.GET)
	public String result_dance(Locale locale) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		return "result/result_dance";
	}
	
	@RequestMapping(value = "/result_disco", method = RequestMethod.GET)
	public String result_disco(Locale locale) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		return "result/result_disco";
	}
	
	@RequestMapping(value = "/result_hiphop", method = RequestMethod.GET)
	public String result_hiphop(Locale locale) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		return "result/result_hiphop";
	}
	
	@RequestMapping(value = "/result_indie", method = RequestMethod.GET)
	public String result_indie(Locale locale) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		return "result/result_indie";
	}
	
	@RequestMapping(value = "/result_jazz", method = RequestMethod.GET)
	public String result_jazz(Locale locale) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		return "result/result_jazz";
	}
	
	@RequestMapping(value = "/result_rnb", method = RequestMethod.GET)
	public String result_rnb(Locale locale) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		return "result/result_rnb";
	}
	
	@RequestMapping(value = "/result_rock", method = RequestMethod.GET)
	public String result_rock(Locale locale) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		return "result/result_rock";
	}
	
	@RequestMapping(value = "/result_trot", method = RequestMethod.GET)
	public String result_trot(Locale locale) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		return "result/result_trot";
	}
}