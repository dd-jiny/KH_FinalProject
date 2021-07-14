package com.phoenix.carrot.biz.sns;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.phoenix.carrot.dao.sns.LikeTableDao;
import com.phoenix.carrot.dto.sns.EntireBoardDto;
import com.phoenix.carrot.dto.sns.LikeTableDto;

@Service
public class LikeTableBizImpl implements LikeTableBiz {
	
	private Logger logger = LoggerFactory.getLogger(LikeTableBizImpl.class);
	
	@Autowired
	private LikeTableDao dao;

	@Override
	public EntireBoardDto pictureSaveHeart(LikeTableDto dto) {

		return dao.pictureSaveHeart(dto);
	}

	@Override
	public EntireBoardDto pictureRemoveHeart(LikeTableDto dto) {

		return dao.pictureRemoveHeart(dto);
	}

	@Override
	public int likeCheck(int entireBoardSeq, int userSeq) {
		
		return dao.likeCheck(entireBoardSeq, userSeq);
	}




}
