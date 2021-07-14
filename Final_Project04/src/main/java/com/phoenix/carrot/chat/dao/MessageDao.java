package com.phoenix.carrot.chat.dao;

import java.util.List;

import com.phoenix.carrot.chat.dto.MessageDto;

public interface MessageDao {
	
	
	String NAMESPACE = "Messgae.";
	
	public List<MessageDto> selectList(int chatroom_id);
	
	public int insertMessage(MessageDto dto);

}
