package com.phoenix.carrot.dao.sns;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.phoenix.carrot.dto.sns.EntireBoardDto;
import com.phoenix.carrot.user.dto.UserDto;

@Repository
public class SnsBoardDaoImpl implements SnsBoardDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public List<EntireBoardDto> snsBoardList() {
		
		List<EntireBoardDto> snsBoardList = new ArrayList<EntireBoardDto>();
		
		
		try {
			snsBoardList = sqlSession.selectList(NAMESPACE + "snsBoardList");
		} catch (Exception e) {
			e.printStackTrace();
		} 
		
		return snsBoardList;
	}

	@Override
	public EntireBoardDto snsBoardOne(int entireBoardSeq) {
		
		EntireBoardDto dto = null;
		
		try {
			dto = sqlSession.selectOne(NAMESPACE + "snsBoardOne", entireBoardSeq);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}
	

	@Override
	public int snsBoardInsert(EntireBoardDto dto) {
		int res = 0;
		
		try {
			res = sqlSession.insert(NAMESPACE + "snsBoardInsert", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public int snsBoardUpdate(EntireBoardDto dto) {
		
		int res = 0;
		
		try {
			res = sqlSession.update(NAMESPACE + "snsBoardUpdate", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return res;
	}

	@Override
	public int snsBoardDelete(int entireBoardSeq) {
		
		int res = 0;
		
		try {
			res = sqlSession.delete(NAMESPACE + "snsBoardDelete", entireBoardSeq);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public List<EntireBoardDto> snsUserFeedList(String userId) {
		
		List<EntireBoardDto> snsUserFeedList = new ArrayList<EntireBoardDto>();
	
		try {
			snsUserFeedList = sqlSession.selectList(NAMESPACE + "snsUserFeedList", userId);
		} catch (Exception e) {
			e.printStackTrace();
		} 
		
		return snsUserFeedList;
		
	}
	
	//유저 개인피드 깔기
	@Override
	public UserDto snsUserSelectOne(String userId) {
		UserDto userDto = null;
		
		try {
			userDto = sqlSession.selectOne(NAMESPACE + "snsUserSelectOne" , userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return userDto;
	}
	
	//유저 전체 리스트 출력
	@Override
	public List<UserDto> userList() {
		List<UserDto> userList = new ArrayList<UserDto>();
		
		
		try {
			userList = sqlSession.selectList(NAMESPACE + "userList");
		} catch (Exception e) {
			e.printStackTrace();
		} 
		
		return userList;
	}
	
	//유저 아이디로 검색
	@Override
	public List<UserDto> snsSearchUserById(String userid) {
		
		List<UserDto> snsUserListById = new ArrayList<UserDto>();
		
		try {
			snsUserListById = sqlSession.selectList(NAMESPACE + "snsSearchUserById", userid);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return snsUserListById;
	}
	
	//유저 네임으로 검색
	@Override
	public List<UserDto> snsSearchUserByName(String username) {
		List<UserDto> snsUserListByName = new ArrayList<UserDto>();
		
		try {
			snsUserListByName = sqlSession.selectList(NAMESPACE + "snsSearchUserByName", username);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return snsUserListByName;
	}
	




}
