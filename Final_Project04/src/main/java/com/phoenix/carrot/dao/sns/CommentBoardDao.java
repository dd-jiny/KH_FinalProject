package com.phoenix.carrot.dao.sns;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.phoenix.carrot.dto.sns.CommentBoardDto;
import com.phoenix.carrot.dto.sns.EntireBoardDto;

public interface CommentBoardDao {
	
	String NAMESPACE = "commentboard.";
	
	public List<CommentBoardDto> getReplyList(Map<String, Object> paramMap); 
	public int regReply(Map<String, Object> paramMap);
	public int delReply(Map<String, Object> paramMap);
	public boolean updateReply(Map<String, Object> paramMap);
}
