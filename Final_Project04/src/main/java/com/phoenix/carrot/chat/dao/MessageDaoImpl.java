package com.phoenix.carrot.chat.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.phoenix.carrot.chat.dto.MessageDto;

@Repository
public class MessageDaoImpl implements MessageDao {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<MessageDto> selectList(int chatroom_id) {
		// TODO Auto-generated method stub
		
		List<MessageDto> res = null;
		
		try {
			res = sqlSession.selectList(NAMESPACE+"selectmessageList", chatroom_id);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return res;
	}

	@Override
	public int insertMessage(MessageDto dto) {
		// TODO Auto-generated method stub
		
		int res = 0;
		
		try {
			res = sqlSession.insert(NAMESPACE+"insertMessage", dto);
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return res;
	}

}
