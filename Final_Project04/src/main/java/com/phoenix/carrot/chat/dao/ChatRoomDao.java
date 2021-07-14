package com.phoenix.carrot.chat.dao;

import java.util.List;

import com.phoenix.carrot.chat.dto.ChatRoomDto;

public interface ChatRoomDao {
	
	String NAMESPACE = "ChatRoom.";
	
	public int createChatRoom(ChatRoomDto dto);
	
	public ChatRoomDto selectOne(ChatRoomDto dto);
	
	
}
