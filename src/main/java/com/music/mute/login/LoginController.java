
package com.music.mute.login;

import java.util.Locale;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class LoginController {

	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);

	@Inject
	private SpotifyService spotifyService;

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String home(Locale locale) {
		logger.info("Welcome home! The client locale is {}.", locale);

		return "/login";
	}

	@RequestMapping("/main")
	public String loginProcess(@RequestParam(required = false) String code, HttpSession session) {
		//@RequestParam("가져올 데이터의 이름") [데이터타입] [가져온데이터를 담을 변수]

		String accessToken=null;
		if (code != null) {
			System.out.println("code>>>" + code);
			 accessToken = spotifyService.requestAccessToken(code);
			System.out.println("accessToken: " + accessToken);
			session.setAttribute("accessToken", accessToken);
		}else {
			 accessToken = (String)session.getAttribute("accessToken");
			 if(accessToken==null) {
				 System.out.println("로그인을 하지않았습니다!!");
			 }
		}

		return "main";
	}

}
