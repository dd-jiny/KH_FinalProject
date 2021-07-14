package com.phoenix.carrot.admin.dao;

import java.util.ArrayList;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.phoenix.carrot.dto.sns.EntireBoardDto;

@Repository
public class NoticeBoardDaoImpl implements NoticeBoardDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public List<EntireBoardDto> noticeBoardList() {
		// TODO Auto-generated method stub
		
		List<EntireBoardDto> list = new ArrayList<EntireBoardDto>();
		
		try {
			list = sqlSession.selectList(NAMESPACE+"selectList");
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public EntireBoardDto noticeBoardOne(int entireBoardSeq) {
		// TODO Auto-generated method stub
		
		EntireBoardDto dto = null;
		
		
		try {
			dto = sqlSession.selectOne(NAMESPACE+"selectOne", entireBoardSeq);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public int noticeBoardInsert(EntireBoardDto dto) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int noticeBoardUpdate(EntireBoardDto dto) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int noticeBoardDelete(int entireBoardSeq) {
		// TODO Auto-generated method stub
		return 0;
	}
	
}
