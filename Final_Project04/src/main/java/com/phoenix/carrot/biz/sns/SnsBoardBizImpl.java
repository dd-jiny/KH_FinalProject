package com.phoenix.carrot.biz.sns;

import java.util.List;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.phoenix.carrot.dao.sns.SnsBoardDao;
import com.phoenix.carrot.dto.sns.EntireBoardDto;
import com.phoenix.carrot.user.dto.UserDto;

@Service
public class SnsBoardBizImpl implements SnsBoardBiz {
	
	private Logger logger = LoggerFactory.getLogger(SnsBoardBizImpl.class);
	
	/*
	@Autowired
	private BoardFileDao fileDao;
	*/
	@Autowired
	private SnsBoardDao dao;
	
	@Override
	public List<EntireBoardDto> snsBoardList() {
		
		return dao.snsBoardList();
	}

	@Override
	public EntireBoardDto snsBoardOne(int entireBoardSeq) {
		
		return dao.snsBoardOne(entireBoardSeq);
	}
	
	
	@Override
	public int snsBoardInsert(EntireBoardDto dto) throws Exception{
		
		return dao.snsBoardInsert(dto);
	}

	@Override
	public int snsBoardUpdate(EntireBoardDto dto) {
		
		return dao.snsBoardUpdate(dto);
	}
	
	@Override
	public void snsBoardDelete(int entireBoardSeq) throws Exception {
	
        dao.snsBoardDelete(entireBoardSeq);
	}
	
	//유저개인피드
	@Override
	public List<EntireBoardDto> snsUserFeedList(String userId) {
	
		return dao.snsUserFeedList(userId);
	}
	
	//유저 정보깔기 
	@Override
	public UserDto snsUserSelectOne(String userId) {

		return dao.snsUserSelectOne(userId);
	}
	@Override
	public List<UserDto> userList() {
		
		return dao.userList();
	}

	@Override
	public List<UserDto> snsSearchUserById(String userid) {
		
		return dao.snsSearchUserById(userid);
	}

	@Override
	public List<UserDto> snsSearchUserByName(String username) {
		
		return dao.snsSearchUserByName(username);
	}
	

}
