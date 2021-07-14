package com.phoenix.carrot.biz.sns;

import java.util.List;

import com.phoenix.carrot.dto.sns.EntireBoardDto;
import com.phoenix.carrot.user.dto.UserDto;

public interface SnsBoardBiz {
	
	public List<EntireBoardDto> snsBoardList();
	public EntireBoardDto snsBoardOne(int entireBoardSeq);
	public int snsBoardInsert(EntireBoardDto dto) throws Exception;
	public int snsBoardUpdate(EntireBoardDto dto);
	public void snsBoardDelete(int entireBoardSeq) throws Exception;
	
	//유저개인피드
	public List<EntireBoardDto> snsUserFeedList(String userId);
	//유저 개인피드에 유저 정보깔기
	public UserDto snsUserSelectOne(String userId);
	//유저 리스트 출력
	public List<UserDto> userList();
	//유저 아이디로 검색
	public List<UserDto> snsSearchUserById(String userid);
	//유저 이름으로 검색
	public List<UserDto> snsSearchUserByName(String username);
}
