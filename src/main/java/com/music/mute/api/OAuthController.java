package com.music.mute.api;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class OAuthController {

    private final SpotifyOAuthService spotifyOAuthService;

    @Autowired
    public OAuthController(SpotifyOAuthService spotifyOAuthService) {
        this.spotifyOAuthService = spotifyOAuthService;
    }

    @RequestMapping("/spotify/login")
    public String login() {
        String redirectUrl = spotifyOAuthService.buildAuthorizationUrl();
        return "redirect:" + redirectUrl;
    }


    @RequestMapping("/callback")
    @ResponseBody
    public String callback(@RequestParam("code") String code, Model model) {
        try {
            String accessToken = spotifyOAuthService.requestAccessToken(code);
            return "Success! Access Token: " + accessToken;
        } catch (Exception e) {
            System.out.println("Error in callback: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("error", "음악 추천을 가져오는 중에 오류가 발생했습니다.");
            return "/errorPage";
        }
    }


}
