package com.phoenix.carrot.model.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.RemoteEndpoint.Basic;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;

@Controller
@ServerEndpoint(value = "/echo.do")
public class WebSocketChat {

	private static final List<Session> sessionList = new ArrayList<Session>();
	private static final Logger logger = LoggerFactory.getLogger(WebSocketChat.class);

	public WebSocketChat() {
		System.out.println("웹소켓(서버) 객체생성");
	}

	@OnOpen
	public void onOpen(Session session) {
		logger.info("Open session id : " + session.getId());

		try {
			final Basic basic = session.getBasicRemote();
			basic.sendText("대화방에 연결되었습니다.");

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
		// sessionList 에 담아준다.
		sessionList.add(session);
	}

	/*
	 * 모든 사용자에게 메시지를 전달? 한명에게만 할건데?
	 * 
	 * @param self
	 * 
	 * @param sender
	 * 
	 * @param message
	 * 
	 */

	private void sendAllSessionToMessage(Session self, String sender, String message) {

		try {
			for (Session session : WebSocketChat.sessionList) {
				if (!self.getId().equals(session.getId())) {
					session.getBasicRemote().sendText(session.getId() + " : " + message);
				}
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
	}

	/*
	 * 내가 입력하는 메세지
	 * 
	 * @param message
	 * 
	 * @param session
	 */

	// 클라이언트에게 메세지가 들어왔을 때
	@OnMessage
	public void onMessage(String message, Session session) {

		String sender = message.split(",")[0];
		message = message.split(",")[1];

		logger.info("Message Form " + sender + " : " + message);

		try {
			final Basic basic = session.getBasicRemote();
			basic.sendText(sender+ " : " + message);
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		sendAllSessionToMessage(session, sender, message);

	}

	@OnError
	public void onError(Throwable e, Session session) {

	}

	@OnClose
	public void onClose(Session session) {
		logger.info("Session " + session.getId() + "has ended");
		sessionList.remove(session);
	}

}
