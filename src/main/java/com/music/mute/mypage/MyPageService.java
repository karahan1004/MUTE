package com.music.mute.mypage;

import com.music.mute.login.MemberVO;

public interface MyPageService {
	
	public MemberVO mypageNickName(String userid);
	
	void updateNickname(MemberVO member);
	
	void deletePlaylist(String accessToken, String playlistId) throws Exception;
	
	void updatePlaylist(String accessToken, String playlistId, String editPlaylistName) throws Exception;
}
