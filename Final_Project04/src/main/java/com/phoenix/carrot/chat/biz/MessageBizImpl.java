package com.phoenix.carrot.chat.biz;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.phoenix.carrot.chat.dao.MessageDao;
import com.phoenix.carrot.chat.dto.MessageDto;

@Service
public class MessageBizImpl implements MessageBiz {

	@Autowired
	MessageDao dao;
	
	@Override
	public List<MessageDto> selectList(int chatroom_id) {
		// TODO Auto-generated method stub
		return dao.selectList(chatroom_id);
	}

	@Override
	public int insertMessage(MessageDto dto) {
		// TODO Auto-generated method stub
		return dao.insertMessage(dto);
	}

}
