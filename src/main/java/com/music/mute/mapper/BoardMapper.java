package com.music.mute.mapper;

import java.util.List;

import com.music.mute.board.BoardVO;

public interface BoardMapper {
	 // 댓글 저장
    void saveComment(BoardVO boardVO);

    // 댓글 가져오기
    List<BoardVO> getComments();
    
    int getReviewCount();

}


