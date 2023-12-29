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

	    public List<BoardVO> getCommentsByUserId(String userId) {
	        return boardMapper.getCommentsByUserId(userId);
	    }

}
