package com.music.mute.board;

public class BoardVO {
	
	//댓글 필드 
	private int RV_NUM;
    private String RV_CONTENT;

    // 외래키 필드
    private int S_NUM;
    private String S_ID;
    private String S_NAME;
	
	public int getRV_NUM() {
		return RV_NUM;
	}
	public void setRV_NUM(int rV_NUM) {
		RV_NUM = rV_NUM;
	}
	public String getRV_CONTENT() {
		return RV_CONTENT;
	}
	public void setRV_CONTENT(String rV_CONTENT) {
		RV_CONTENT = rV_CONTENT;
	}
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
	    return "BoardVO{" +
	            "RV_NUM=" + RV_NUM +
	            ", RV_CONTENT='" + RV_CONTENT + '\'' +
	            ", S_NUM=" + S_NUM +
	            ", S_ID='" + S_ID + '\'' +
	            ", S_NAME='" + S_NAME + '\'' +
	            '}';
	}


	
}
