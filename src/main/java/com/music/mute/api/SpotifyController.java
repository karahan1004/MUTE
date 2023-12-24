/*
package com.music.mute.api;

import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.music.mute.login.SpotifyService;

import se.michaelthelin.spotify.SpotifyApi;

@Controller
public class SpotifyController {

    @Autowired
    private SpotifyService spotifyService;

    @GetMapping("/login")
    public String spotifyLogin(Locale locale) {
        // 여기에 메소드 구현을 추가하세요.
        // 예를 들어, 해당 페이지의 템플릿 이름을 반환하거나 다른 작업을 수행할 수 있습니다.
        return "spotifyLogin"; // 이 부분은 실제로 사용하는 템플릿 이름으로 변경해야 합니다.
    }

    @GetMapping("/callback")
    public String handleCallback(@RequestParam("code") String code) {
        // 콜백에서 받은 코드를 사용하여 액세스 토큰을 얻고 SpotifyService를 통해 초기화
        String accessToken = spotifyService.requestAccessToken(code);
        SpotifyApi spotifyApi = new SpotifyApi.Builder()
                .setAccessToken(accessToken)
                .build();

        // 여기서 얻은 SpotifyApi를 사용하여 로직을 처리
        // ...

        // 로직 처리 후 홈 페이지로 리다이렉트 또는 다른 작업을 수행
        return "redirect:/home";
    }
}
*/
