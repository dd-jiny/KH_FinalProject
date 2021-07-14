package com.phoenix.carrot.chat.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.phoenix.carrot.chat.dto.ChatRoomDto;

@Repository
public class ChatRoomDaoImpl implements ChatRoomDao {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public int createChatRoom(ChatRoomDto dto) {
		// TODO Auto-generated method stub
		
		int res = 0;
		
		try {
			res = sqlSession.insert(NAMESPACE+"createChatRoom", dto);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			System.out.println("채팅방 개설에 실패하였습니다.");
		}
	
		return res;
	}

	@Override
	public ChatRoomDto selectOne(ChatRoomDto dto) {
		// TODO Auto-generated method stub
		
		ChatRoomDto res = null;
		
		try {
			res = sqlSession.selectOne(NAMESPACE+"selectOne", dto);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return res;
	}

	

}
