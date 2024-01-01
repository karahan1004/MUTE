package com.music.mute.mypage;

import java.util.concurrent.CompletableFuture;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.music.mute.login.MemberVO;

import lombok.extern.log4j.Log4j;
import se.michaelthelin.spotify.SpotifyApi;
import se.michaelthelin.spotify.exceptions.detailed.UnauthorizedException;
import se.michaelthelin.spotify.model_objects.specification.Paging;
import se.michaelthelin.spotify.model_objects.specification.PlaylistSimplified;
import se.michaelthelin.spotify.requests.data.follow.UnfollowPlaylistRequest;
import se.michaelthelin.spotify.requests.data.playlists.ChangePlaylistsDetailsRequest;
import se.michaelthelin.spotify.requests.data.playlists.GetListOfCurrentUsersPlaylistsRequest;

@Controller
@Log4j
public class MyPageController {
	
	@Autowired
	private SpotifyApi spotifyApi;
	
	@Autowired
	private MyPageService mypageService;
	
	 private final MyPageService myPageService;

	    @Autowired
	    public MyPageController(MyPageService myPageService) {
	        this.myPageService = myPageService;}
	
	@GetMapping("/mypage")
	public String getUserPlaylists(Model model, HttpSession session) {
		// 사용자의 Access Token을 세션에서 가져옴
		String accessToken = (String) session.getAttribute("accessToken");
		String userid=(String)session.getAttribute("spotifyUserId");
		MemberVO user=mypageService.mypageNickName(userid);
		if (accessToken != null && user!=null) {
			try {
				spotifyApi.setAccessToken(accessToken);
				final GetListOfCurrentUsersPlaylistsRequest playlistsRequest = spotifyApi
						.getListOfCurrentUsersPlaylists().build();
				final CompletableFuture<Paging<PlaylistSimplified>> playlistsFuture = playlistsRequest.executeAsync();
				PlaylistSimplified[] playlists = playlistsFuture.join().getItems();
				log.info("playlists="+playlists);
				model.addAttribute("playlists", playlists);
				model.addAttribute("nickName",user.getS_NAME());
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else{
			// Access Token이 없는 경우, 로그인 페이지로 리다이렉트 또는 에러 처리
			return "redirect:/login";
		}
		return "/mypage";
	}//getUserPlaylists-----------------------------------------
	    
	//mypage 플리 이름 수정 ==> Ambiguous mapping에러 발생, apiplaylist 랑 이름 겹쳐서 변경함
	 @PostMapping("/updatePlaylistmy")
	    public String updatePlaylist(Model model, HttpSession session, @RequestParam String playlistId, @RequestParam String editPlaylistName) {
	        String accessToken = (String) session.getAttribute("accessToken");
	        try {
	            myPageService.updatePlaylist(accessToken, playlistId, editPlaylistName);
	            model.addAttribute("message", "Playlist updated successfully");
	        } catch (UnauthorizedException e) {
	            return "redirect:/login";
	        } catch (Exception e) {
	            e.printStackTrace();
	            model.addAttribute("error", "Error updating playlist");
	        }

	        return "redirect:/mypage";
	    }//updatePlaylist------------------------------------------
	
	 @DeleteMapping("/deletePlaylistmy")
	    public ResponseEntity<String> deletePlaylist(@RequestParam String playlistId, HttpSession session) {
	        String accessToken = (String) session.getAttribute("accessToken");
	        try {
	            myPageService.deletePlaylist(accessToken, playlistId);
	            return ResponseEntity.ok("Playlist delete successfully");
	        } catch (UnauthorizedException e) {
	            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("User not authenticated");
	        } catch (Exception e) {
	            e.printStackTrace();
	            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error deleting playlist");
	        }
	}//deletePlaylist---------------------------------------------
	
	@RequestMapping(value = "/updateNickNameJson", method = RequestMethod.POST)
	@ResponseBody
    public ModelMap updateNickname(@RequestParam String nickName, HttpSession session, Model model) {
        String userId = (String) session.getAttribute("spotifyUserId");

     // 닉네임 업데이트 쿼리 실행
        MemberVO member = new MemberVO();
        member.setS_ID(userId);
        member.setS_NAME(nickName);
        mypageService.updateNickname(member);
        ModelMap map=new ModelMap();
        map.put("result", "success");
        return map;
    }//updateNickname----------------------------------------------
}