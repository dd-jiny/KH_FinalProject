package com.phoenix.carrot.biz.sns;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.phoenix.carrot.dao.sns.CommentBoardDao;
import com.phoenix.carrot.dto.sns.CommentBoardDto;
import com.phoenix.carrot.dto.sns.EntireBoardDto;

@Service
public class CommentBoardBizImpl implements CommentBoardBiz {
	
	@Autowired
	private CommentBoardDao commentDao;

	@Override
	public List<CommentBoardDto> getReplyList(Map<String, Object> paramMap) {
		
		List<CommentBoardDto> boardReplyList = commentDao.getReplyList(paramMap);
		
		//sql에서 계층을 나누는 쿼리가 어려우니..
		//부모
		List<CommentBoardDto> boardReplyListParent = new ArrayList<CommentBoardDto>();
		//자식
		List<CommentBoardDto> boardReplyListChild = new ArrayList<CommentBoardDto>();
		//통합
		List<CommentBoardDto> newBoardReplyList = new ArrayList<CommentBoardDto>();
		
		//1.부모 자식 분리
		for(CommentBoardDto commentDto : boardReplyList) {
			if(commentDto.getGroupDepth() == 0) {
				boardReplyListParent.add(commentDto);
			} else {
				boardReplyListChild.add(commentDto);
			}
		}
		
		//2부모를 돌린다.
		for(CommentBoardDto commentDtoParent : boardReplyListParent) {
			//부모를 넣는다
			newBoardReplyList.add(commentDtoParent);
			//자식을 그안에서 돌린다 
			for(CommentBoardDto boardReplyChild: boardReplyListChild) {
				if(commentDtoParent.getCommentNoSeq() == (boardReplyChild.getGroupNo())) {
					newBoardReplyList.add(boardReplyChild);
				}
			}
		}
		return newBoardReplyList;
	}

	@Override
	public int regReply(Map<String, Object> paramMap) {

		return commentDao.regReply(paramMap);
	}

	@Override
	public int delReply(Map<String, Object> paramMap) {

		return commentDao.delReply(paramMap);
	}

	@Override
	public boolean updateReply(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return commentDao.updateReply(paramMap);
	}

	
}
