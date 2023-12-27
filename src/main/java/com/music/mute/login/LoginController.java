
package com.music.mute.login;

import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.music.mute.mapper.MemberMapper;

@Controller
public class LoginController {

	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);

	@Inject
	private SpotifyService spotifyService;
	
	@Autowired
    private MemberDAO memberDAO;
	
	@Autowired
    private MemberMapper memberMapper; 
	
	@Autowired
    private SqlSession sqlSession;  // MyBatis의 SqlSession을 주입받습니다.


	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String home(Locale locale) {
		logger.info("Welcome home! The client locale is {}.", locale);

		return "/login";
	}

	@RequestMapping("/main")
	public String loginProcess(@RequestParam(required = false) String code, HttpSession session, Model model) {
		//@RequestParam("가져올 데이터의 이름") [데이터타입] [가져온데이터를 담을 변수]

		String accessToken=null;
		
		if (code != null) {
			System.out.println("code>>>" + code);
			 accessToken = spotifyService.requestAccessToken(code);
			System.out.println("accessToken: " + accessToken);
			session.setAttribute("accessToken", accessToken);
		

		
		// Get Spotify user ID using the access token
	    String userId = spotifyService.getSpotifyUserId(accessToken);
	    System.out.println("Spotify userId: " + userId);
	    
	    // Spotify 사용자 ID가 데이터베이스에 있는지 확인
	    MemberVO existingMember = sqlSession.selectOne("com.multi.mapper.MemberMapper.getMemberByNickname", userId);

	    if (existingMember == null ||"UNDECIDED".equals(existingMember.getS_NAME())) {
	        // Spotify 사용자 ID가 데이터베이스에 없으면 getId.jsp로 리다이렉트
	        return "redirect:/getId";
	    }
	    
	    // 세션에 Spotify 사용자 ID 저장 또는 필요한 대로 사용
	    session.setAttribute("spotifyUserId", userId);

	    // JSP를 위해 Spotify 사용자 ID를 모델에 추가
	    model.addAttribute("spotifyUserId", userId);
	    
	    
        // Save Spotify user ID in the database 유저 아이디를 디비에 받아와야 함.. 께속 오류난다!!!!
	    MemberVO member = new MemberVO();
	    member.setS_ID(userId);
		sqlSession.insert("com.multi.mapper.MemberMapper.saveSpotifyUserId", member);

		}else {
			 accessToken = (String)session.getAttribute("accessToken");
			 if(accessToken==null) {
				 System.out.println("로그인을 하지않았습니다!!");
			 }
		}
        return "main";
	}
	
	@RequestMapping("/getId")
    public String showNicknameForm() {
        return "getId";
    }
	


    @RequestMapping(value = "/updateNickname", method = RequestMethod.POST)
    public String updateNickname(@RequestParam String S_NAME, HttpSession session, Model model) {
        String userId = (String) session.getAttribute("spotifyUserId");

     // 닉네임 업데이트 쿼리 실행
        MemberVO member = new MemberVO();
        member.setS_ID(userId);
        member.setS_NAME(S_NAME);
        memberMapper.updateNickname(member);

        // 예시: 사용 가능한 닉네임인 경우 업데이트 후 main 페이지로 리다이렉트
        return "/main";
    }
    
    
    //닉네임 중복 체크
    @RequestMapping("/nicknameCheck")
    @ResponseBody
    public Map<String, Object> nickNameCheck(String nickname) {
    	Map<String, Object> result = new HashMap<>();
        
        // 닉네임 중복 확인 로직 (예시: 닉네임이 사용 가능하면 true, 중복이면 false를 반환)
        boolean isAvailable = !isNicknameExists(nickname);
        
        result.put("available", isAvailable);
        return result;
    }
    

    // 닉네임이 이미 존재하는지 확인하는 메소드 (예시)
    private boolean isNicknameExists(String nickname) {
        // MyBatis를 사용하여 디비 조회
        int count = sqlSession.selectOne("com.multi.mapper.MemberMapper.countNickname", nickname);

        // count가 0이면 닉네임이 존재하지 않음, 1 이상이면 닉네임이 이미 존재함
        return count > 0;
    }
    
    // checkAndSubmit 함수에 해당하는 부분
//    @RequestMapping("/checkAndSubmit")
//    public String checkAndSubmit(@RequestParam String S_NAME, HttpSession session, Model model) {
//        // 사용자가 입력한 값을 가져와서 업데이트
//        String S_NAME = "사용자가 입력한 값"; // 여기에 실제로 사용자가 입력한 값을 가져오는 로직을 추가
//
//        // 업데이트할 값을 모델에 추가 (여기서는 예시로 직접 값을 설정)
//        model.addAttribute("S_NAME", S_NAME);
//
//        // 업데이트 실행
//        updateNickname(S_NAME, session, model);
//
//        return "redirect:/main";
//    }

}
