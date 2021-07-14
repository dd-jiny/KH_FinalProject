package com.phoenix.carrot.dao.sns;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.phoenix.carrot.dto.sns.FollowDto;

@Repository
public class FollowDaoImpl implements FollowDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	//팔로우 하기 
	@Override
	public void insertFollow(FollowDto followdto) throws Exception {
		sqlSession.insert(NAMESPACE + "insertFollow", followdto);
		
	}
	
	//팔로우 수
	@Override
	public int followCount(String follower_ID) throws Exception {
		
		return sqlSession.selectOne(NAMESPACE + "followCount", follower_ID);
	}
	
	//팔로우 한 사용자 조회
	@Override
	public List<FollowDto> selectFollow(String follower_ID) throws Exception {
		
		return sqlSession.selectList(NAMESPACE + "followList", follower_ID);
	}
	
	//팔로우취소
	@Override
	public void deleteFollow(String following_ID, String follower_ID) throws Exception {
		Map<String, String> map = new HashMap<>();
		
		map.put("following_ID", following_ID);
		map.put("follower_ID", follower_ID);
		System.out.println("map :" + map);
		sqlSession.delete(NAMESPACE + "followDelete", map);
		
	}
	
	//내가 팔로우 한 사용자들 조회 
	@Override
	public List<FollowDto> myFollow(String following_ID) throws Exception {
		
		return sqlSession.selectList(NAMESPACE + "myFollow" , following_ID);
	}

	@Override
	public int checkFollow(String following_ID, String follower_ID) throws Exception {
		Map<String, String> map = new HashMap<>();
		map.put("following_ID", following_ID);
		map.put("follower_ID", follower_ID);
		System.out.println("map : "+map);
		return sqlSession.selectOne(NAMESPACE + "checkFollow",map);
	}

}
