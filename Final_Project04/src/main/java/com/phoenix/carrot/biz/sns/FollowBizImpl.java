package com.phoenix.carrot.biz.sns;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.phoenix.carrot.dao.sns.FollowDao;
import com.phoenix.carrot.dto.sns.FollowDto;

@Service
public class FollowBizImpl implements FollowBiz {
	
	@Autowired
	public FollowDao followDao;
	
	//팔로우하기 
	@Override
	public void insertFollow(FollowDto followdto) throws Exception {
		followDao.insertFollow(followdto);
	}
	
	//팔로우 수 
	@Override
	public int followCount(String follower_ID) throws Exception {

		return followDao.followCount(follower_ID);
	}
	
	//특정 사용자를 팔로우한 사용자 조회
	@Override
	public List<FollowDto> selectFollow(String follower_ID) throws Exception {
		// TODO Auto-generated method stub
		return followDao.selectFollow(follower_ID);
	}
	
	@Override
	public int checkFollow(String following_ID, String follower_ID) throws Exception {
		return 0;
	}
	
	//팔로우 취소
	@Override
	public void deleteFollow(String following_ID, String follower_ID) throws Exception {
		followDao.deleteFollow(following_ID, follower_ID);
	}
	
	//내가 팔로우 한 사용자들 조회
	@Override
	public List<FollowDto> myFollow(String following_ID) throws Exception {
		return followDao.myFollow(following_ID);
	}



}
