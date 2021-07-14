package com.phoenix.carrot.admin.biz;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.phoenix.carrot.admin.dao.AdminProductDao;
import com.phoenix.carrot.admin.dao.NoticeBoardDao;
import com.phoenix.carrot.dto.sns.EntireBoardDto;

@Service
public class NoticeBoardBizImpl implements NoticeBoardBiz {

	@Autowired
	private NoticeBoardDao dao;
	
	@Override
	public List<EntireBoardDto> noticeBoardList() {
		// TODO Auto-generated method stub
		return dao.noticeBoardList();
	}

	@Override
	public EntireBoardDto noticeBoardOne(int entireBoardSeq) {
		// TODO Auto-generated method stub
		return dao.noticeBoardOne(entireBoardSeq);
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
