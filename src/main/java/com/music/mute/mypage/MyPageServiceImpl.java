package com.music.mute.mypage;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.music.mute.login.MemberVO;
import com.music.mute.mapper.MemberMapper;
@Service
public class MyPageServiceImpl implements MyPageService {
	@Inject
	private MemberMapper memberMapper;
	
	@Override
	public MemberVO mypageNickName(String userid) {
		return memberMapper.getMemberBySpotifyUserId(userid);
	}

	@Override
	public void updateNickname(MemberVO member) {
		memberMapper.updateNickname(member);

	}

}
