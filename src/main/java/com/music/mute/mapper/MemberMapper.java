package com.music.mute.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.music.mute.login.MemberVO;

public interface MemberMapper {
	
	// 사용자의 spotify user id 와 임의의 닉네임 인서트
    void saveSpotifyUserId(MemberVO member);
    
    // 사용자의 닉네임을 업데이트
    void updateNickname(MemberVO member);
    
    // Spotify 사용자 ID로 회원 정보 가져오기
    MemberVO getMemberBySpotifyUserId(String userId);
    
    // 닉네임으로 회원 정보 가져오기
    MemberVO getMemberByNickname(String nickname);

    // 닉네임이 존재하는지 확인하는 쿼리 0이면 존재암함.
    int countNickname(String nickname);

    // Userid가 존재하는지 확인하는 쿼리 0이면 존재암함.
	int countUserid(String userid);
}
