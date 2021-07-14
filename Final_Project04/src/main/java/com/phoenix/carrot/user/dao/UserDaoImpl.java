package com.phoenix.carrot.user.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.phoenix.carrot.user.dto.UserDto;

@Repository
public class UserDaoImpl implements UserDao {


	@Autowired
	private SqlSessionTemplate sqlSession;
	
	
	
	
	@Override
	public UserDto login(UserDto dto) {
		UserDto res = null;
		
		try {
			res = sqlSession.selectOne(NAMESPACE+"login", dto);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			
		}
		return res;
	}




	@Override
	public int regist(UserDto dto) {
		// TODO Auto-generated method stub
		int res = 0;
		
		try {
			res = sqlSession.insert(NAMESPACE+"regist", dto);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		return res;
	}




	@Override
	public UserDto idcheck(String userid) {
		// TODO Auto-generated method stub
		
		UserDto res = null;
		
		try {
			res = sqlSession.selectOne(NAMESPACE+"idcheck", userid);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return res;
	}




	@Override
	public String find_id(String useremail) {
		// TODO Auto-generated method stub
		
		String res = null;
		
		try {
			res = sqlSession.selectOne(NAMESPACE+"find_id", useremail);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		

		return res;
	}




	@Override
	public int updatePw(UserDto dto) {
		int res = 0;
		
		try {
			res = sqlSession.update(NAMESPACE+"updatePw", dto);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		return res;
	}




	@Override
	public UserDto selectOneById(String userid) {
		// TODO Auto-generated method stub
		
		UserDto res = null;
		
		
		try {
			res = sqlSession.selectOne(NAMESPACE+"selectOneById", userid);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public UserDto selectOneByEmail(String useremail) {
		// TODO Auto-generated method stub
		
		UserDto res = null;
		
		try {
			res = sqlSession.selectOne(NAMESPACE+"selectOneByEmail", useremail);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		return res;
	}

}
