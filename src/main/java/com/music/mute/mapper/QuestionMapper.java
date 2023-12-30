package com.music.mute.mapper;

import com.music.mute.test.ChoiceVO;
import com.music.mute.test.QuestionVO;

public interface QuestionMapper {

	QuestionVO getQuestionByNumber(int i);
	
	ChoiceVO getChoiceByNumber(int i);
}
