package com.phoenix.carrot.admin.dao;

import java.util.List;

import com.phoenix.carrot.dto.sns.EntireBoardDto;

public interface NoticeBoardDao {

	String NAMESPACE = "noticeboard.";
	
	public List<EntireBoardDto> noticeBoardList();
	public EntireBoardDto noticeBoardOne(int entireBoardSeq);
	public int noticeBoardInsert(EntireBoardDto dto);
	public int noticeBoardUpdate(EntireBoardDto dto);
	public int noticeBoardDelete(int entireBoardSeq);
	

}
