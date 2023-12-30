package com.music.mute.board;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.music.mute.mapper.BoardMapper;

@Service
public class BoardService {

	 @Autowired
	    private BoardMapper boardMapper;

	    public void saveComment(BoardVO boardVO) {
	    	boardMapper.saveComment(boardVO);
	    }

	    public List<BoardVO> getComments() {
	    	 // 댓글을 조회하는 로직을 여기에 구현
	        List<BoardVO> commentList = boardMapper.getComments();
	        return commentList;
	    }
	    
	    public int getReviewCount() {
	        return boardMapper.getReviewCount();
	    }

}
