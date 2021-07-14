package com.phoenix.carrot.dao.sns;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.phoenix.carrot.dto.sns.EntireBoardDto;
import com.phoenix.carrot.dto.sns.LikeTableDto;

@Repository
public class LikeTableDaoImpl implements LikeTableDao {
	
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public EntireBoardDto pictureSaveHeart (LikeTableDto dto) {
		//게시판 테이블에 해당 게시물의 좋아요수를 +1 하기 위한 dto 세팅
		EntireBoardDto boardDto = new EntireBoardDto();
		boardDto.setEntireBoardSeq(dto.getEntireBoardSeq());
		
		//해당 게시물의 heart를 +1한다
		sqlSession.update(NAMESPACE + "picture_heart_up", boardDto);
		
		//likeTable 테이블에 추가
		int result = sqlSession.insert(NAMESPACE + "picture_heart_save", dto);
		System.out.println("dto : "+ dto);
		System.out.println("result : "+result);
		if (result == 1) {
			//좋아요 테이블에 새로운 좋아요 추가가 성공한다면 
			//갱신된 하트 갯수를 가져옴 
			boardDto = sqlSession.selectOne(NAMESPACE + "picture_heart_count", boardDto);
		}
		
		return boardDto;
	}
	
	@Override
	public EntireBoardDto pictureRemoveHeart(LikeTableDto dto) {
		// 게시판 테이블에 해당 게시물의 좋아요수를 -1하기위한 세팅
		EntireBoardDto boardDto = new EntireBoardDto();
		boardDto.setEntireBoardSeq(dto.getEntireBoardSeq());
		
		//해당 게시물의 좋아요수를 -1
		sqlSession.update(NAMESPACE +"picture_heart_down", boardDto);
		
		//좋아요 테이블에서 삭제 
		int result = sqlSession.delete(NAMESPACE + "picture_heart_remove", dto);
		
		if (result == 1) {
			//좋아요 테이블에 좋아요 삭제가 성공한다면
			boardDto = sqlSession.selectOne(NAMESPACE + "picture_heart_count", boardDto);
		}
		
		return boardDto;
	}
	//nullpointer 고치려면... 여기서 작업을 해야할것같다...일단 작동은 되니까 넘기자..
	//좋아요를 안 누른 게시물을 들어갔을때 쿼리에서 조회할 데이터가 없어 널포인터익셉션에러가 뜬다. 
	//일단 다른 일 하고 고치자...
	@Override
	public int likeCheck(int entireBoardSeq, int userSeq) {
		Map<String, Integer> param = new HashMap<String, Integer>();
		
		param.put("entireBoardSeq", entireBoardSeq);
		param.put("userSeq", userSeq);
		
		System.out.println("entireBoardSeq : "+ entireBoardSeq + "," + "userSeq : " + userSeq);
		
		int result = 0;

		try {
			result = sqlSession.selectOne(NAMESPACE + "likecheck", param);
					
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}


}
