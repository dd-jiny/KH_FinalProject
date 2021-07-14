package com.phoenix.carrot.biz.sns;

import java.util.List;

import com.phoenix.carrot.dto.sns.FollowDto;

public interface FollowBiz {
	
	//팔로우 하기 
	public void insertFollow(FollowDto followdto) throws Exception;
	//팔로우 수
	public int followCount(String follower_ID) throws Exception;
	//팔로우 한 사용자 조회
	public List<FollowDto> selectFollow(String follower_ID) throws Exception;
	//팔로우체크
	public int checkFollow(String following_ID, String follower_ID) throws Exception;
	//팔로우 취소
	public void deleteFollow(String following_ID, String follower_ID) throws Exception;
	//내가 팔로우 한 사용자들 조회
	public List<FollowDto> myFollow(String following_ID) throws Exception;
	

}
