package com.music.mute.board;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class BoardController {
	
	@Autowired
    private BoardService boardService;
	
	@RequestMapping(value = "/saveComment", method = RequestMethod.POST)
    public String saveComment(@ModelAttribute("boardVO") BoardVO boardVO, HttpSession session) {
//		// 세션에서 로그인 여부 확인
	    if (session.getAttribute("accessToken") == null || session.getAttribute("accessToken").toString().isEmpty()) {
	        // 로그인이 안 되어 있으면 메인 페이지로 리다이렉트
	        return "redirect:/main";
	    } 
		
		// 현재 로그인한 사용자의 'S_ID' 값을 가져와서 설정
	    String userId = (String) session.getAttribute("spotifyUserId");
		System.out.println("S_ID>>>>"+userId);
	    boardVO.setS_ID(userId);
		boardService.saveComment(boardVO);
        return "redirect:/main"; // 댓글 저장 후 메인 페이지로 리다이렉션
    }


}
