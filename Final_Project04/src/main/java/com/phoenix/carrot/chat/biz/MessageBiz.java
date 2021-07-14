package com.phoenix.carrot.chat.biz;

import java.util.List;

import com.phoenix.carrot.chat.dto.MessageDto;

public interface MessageBiz {
	
	public List<MessageDto> selectList(int chatroom_id);
	
	public int insertMessage(MessageDto dto);

}
