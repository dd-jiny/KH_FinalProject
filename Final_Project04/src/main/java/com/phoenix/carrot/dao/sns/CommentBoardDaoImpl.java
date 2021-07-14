package com.phoenix.carrot.dao.sns;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.phoenix.carrot.dto.sns.CommentBoardDto;
import com.phoenix.carrot.dto.sns.EntireBoardDto;

@Repository
public class CommentBoardDaoImpl implements CommentBoardDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public List<CommentBoardDto> getReplyList(Map<String, Object> paramMap) {
		
		List<CommentBoardDto> getReplyList = new ArrayList<CommentBoardDto>();
		
		try {
			getReplyList = sqlSession.selectList(NAMESPACE + "board_replyList", paramMap);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return getReplyList;
	}

	@Override
	public int regReply(Map<String, Object> paramMap) {
		System.out.println("paramMap2 : "+ paramMap);	
		return sqlSession.insert(NAMESPACE + "insertBoardReply", paramMap);
	}

	@Override
	public int delReply(Map<String, Object> paramMap) {
		
		return sqlSession.delete(NAMESPACE + "deleteBoardReply", paramMap);
	}

	@Override
	public boolean updateReply(Map<String, Object> paramMap) {
		int result = sqlSession.update("updateReply", paramMap);
		
		if(result > 0) {
			return true;
		} else {
			return false;
		}
	}
	
	/*
	@Override
	public List<CommentBoardDto> getReplyList(Map<String, Object> paramMap) {
	
		return sqlSession.selectList(NAMESPACE + "board_replyList", paramMap);
	}
	*/
	
}
