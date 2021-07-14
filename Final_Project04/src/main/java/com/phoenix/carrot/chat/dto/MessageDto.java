package com.phoenix.carrot.chat.dto;

import java.util.Date;

public class MessageDto {
	

	private int message_id;
	private String message_sender;
	private String message_receiver;
	private String message_content;
	private Date message_regdate;
	private int chatroom_id;
	public MessageDto() {
	
	}
	public MessageDto(int message_id, String message_sender, String message_receiver, String message_content,
			Date message_regdate, int chatroom_id) {
		super();
		this.message_id = message_id;
		this.message_sender = message_sender;
		this.message_receiver = message_receiver;
		this.message_content = message_content;
		this.message_regdate = message_regdate;
		this.chatroom_id = chatroom_id;
	}
	public int getMessage_id() {
		return message_id;
	}
	public void setMessage_id(int message_id) {
		this.message_id = message_id;
	}
	public String getMessage_sender() {
		return message_sender;
	}
	public void setMessage_sender(String message_sender) {
		this.message_sender = message_sender;
	}
	public String getMessage_receiver() {
		return message_receiver;
	}
	public void setMessage_receiver(String message_receiver) {
		this.message_receiver = message_receiver;
	}
	public String getMessage_content() {
		return message_content;
	}
	public void setMessage_content(String message_content) {
		this.message_content = message_content;
	}
	public Date getMessage_regdate() {
		return message_regdate;
	}
	public void setMessage_regdate(Date message_regdate) {
		this.message_regdate = message_regdate;
	}
	public int getChatroom_id() {
		return chatroom_id;
	}
	public void setChatroom_id(int chatroom_id) {
		this.chatroom_id = chatroom_id;
	}
	

}
