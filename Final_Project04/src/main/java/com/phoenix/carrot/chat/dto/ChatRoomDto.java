package com.phoenix.carrot.chat.dto;

import java.util.Date;

public class ChatRoomDto {

	private int chatroom_id;
	private String chatroom_buyer;
	private String chatroom_seller;
	private String chatroom_title;
	private Date chatroom_regdate;
	public ChatRoomDto() {
		
	
	}
	public ChatRoomDto(int chatroom_id, String chatroom_buyer, String chatroom_seller, String chatroom_title,
			Date chatroom_regdate) {
		super();
		this.chatroom_id = chatroom_id;
		this.chatroom_buyer = chatroom_buyer;
		this.chatroom_seller = chatroom_seller;
		this.chatroom_title = chatroom_title;
		this.chatroom_regdate = chatroom_regdate;
	}
	public int getChatroom_id() {
		return chatroom_id;
	}
	public void setChatroom_id(int chatroom_id) {
		this.chatroom_id = chatroom_id;
	}
	public String getChatroom_buyer() {
		return chatroom_buyer;
	}
	public void setChatroom_buyer(String chatroom_buyer) {
		this.chatroom_buyer = chatroom_buyer;
	}
	public String getChatroom_seller() {
		return chatroom_seller;
	}
	public void setChatroom_seller(String chatroom_seller) {
		this.chatroom_seller = chatroom_seller;
	}
	public String getChatroom_title() {
		return chatroom_title;
	}
	public void setChatroom_title(String chatroom_title) {
		this.chatroom_title = chatroom_title;
	}
	public Date getChatroom_regdate() {
		return chatroom_regdate;
	}
	public void setChatroom_regdate(Date chatroom_regdate) {
		this.chatroom_regdate = chatroom_regdate;
	}
	
		
	
}
