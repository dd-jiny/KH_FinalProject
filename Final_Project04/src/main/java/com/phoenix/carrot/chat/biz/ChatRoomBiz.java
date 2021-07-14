package com.phoenix.carrot.chat.biz;

import java.util.List;

import com.phoenix.carrot.chat.dto.ChatRoomDto;

public interface ChatRoomBiz {

	
	public int createChatRoom(ChatRoomDto dto);
	
	public ChatRoomDto selectOne(ChatRoomDto dto);
	
	
	
}
