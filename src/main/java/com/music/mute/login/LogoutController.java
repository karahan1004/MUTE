package com.music.mute.login;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class LogoutController {
	@GetMapping("/logout")
    public String logout(HttpServletRequest request) {
        // 현재 세션을 가져옵니다.
        HttpSession session = request.getSession(false);
        
        // 세션이 존재하면 세션을 무효화합니다.
        if (session != null) {
            session.invalidate();
        }

        // 로그아웃 후 홈페이지 또는 다른 페이지로 리다이렉트합니다.
        return "main"; 
    }
}