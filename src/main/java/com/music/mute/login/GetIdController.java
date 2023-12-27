package com.music.mute.login;

import java.util.Locale;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class GetIdController {


	private static final Logger logger = LoggerFactory.getLogger(GetIdController.class);

	@Inject
	private SpotifyService spotifyService;

	@RequestMapping(value = "/getId", method = RequestMethod.GET)
	public String home(Locale locale) {
		logger.info("Welcome home! The client locale is {}.", locale);

		return "/getId";
	}
}