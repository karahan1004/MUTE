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
		 // 현재 로그인한 사용자의 'S_ID' 값을 가져와서 설정
	    String userId = (String) session.getAttribute("spotifyUserId");
		System.out.println("S_ID>>>>"+userId);
	    boardVO.setS_ID(userId);
		boardService.saveComment(boardVO);
        return "redirect:/main"; // 댓글 저장 후 메인 페이지로 리다이렉션
    }
	
//    // 댓글 목록 가져오는 메서드 추가: 댓글 목록을 가져와 모델에 추가
//	//댓글 목록을 세션에 추가하는 것은 일반적으로 권장되지 않습니다. 세션은 주로 사용자의 인증 및 상태 정보를 유지하기 위해 사용되며, 댓글 목록과 같은 비즈니스 데이터는 모델에 포함하여 JSP 페이지에서 편리하게 사용하는 것이 좋습니다.
//    @RequestMapping(value = "/main", method = RequestMethod.GET)
//    public String mainPage(HttpSession session, Model model) {
//        String userId = (String) session.getAttribute("spotifyUserId");
//        List<BoardVO> commentList = boardService.getCommentsByUserId(userId);
//        model.addAttribute("commentList", commentList);
//        return "/main";
//    }
//	
//	

}
