package com.phoenix.carrot.dao.sns;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.phoenix.carrot.dto.sns.EntireBoardDto;
import com.phoenix.carrot.dto.sns.LikeTableDto;

public interface LikeTableDao {
	
	String NAMESPACE = "liketable.";
	
	public EntireBoardDto pictureSaveHeart (LikeTableDto dto);
	
	public EntireBoardDto pictureRemoveHeart(LikeTableDto dto);
	
	//좋아요 여부 확인
	public int likeCheck(int entireBoardSeq, int userSeq);
	

}
