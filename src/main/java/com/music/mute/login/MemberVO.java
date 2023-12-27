package com.music.mute.login;

public class MemberVO {

	//회원 번호
	private int S_NUM;
	
	//유저의 Spotify ID
	private String S_ID;
		
	//유저가 설정한 닉네임 
	private String S_NAME;
	
	
	public int getS_NUM() {
		return S_NUM;
	}

	public void setS_NUM(int s_NUM) {
		S_NUM = s_NUM;
	}

	public String getS_ID() {
		return S_ID;
	}

	public void setS_ID(String s_ID) {
		S_ID = s_ID;
	}

	public String getS_NAME() {
		return S_NAME;
	}

	public void setS_NAME(String s_NAME) {
		S_NAME = s_NAME;
	}
	
	@Override
	public String toString() {
		return "MemberVO [S_NUM=" + S_NUM + ", S_ID=" + S_ID + ", S_NAME=" + S_NAME
				 + "]";
	}


	
}
