package com.music.mute.mypage;

import com.music.mute.login.MemberVO;

public interface MyPageService {
	
	public MemberVO mypageNickName(String userid);
	
	
	void updateNickname(MemberVO member);

}
