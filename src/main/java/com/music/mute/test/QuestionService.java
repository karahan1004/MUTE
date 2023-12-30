package com.music.mute.test;

import java.util.List;

public interface QuestionService {
	
	public QuestionVO findQuestion(int i);
	
	public List<ChoiceVO> findAnswer(int i);
	
	

}
