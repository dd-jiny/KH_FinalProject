package com.phoenix.carrot.dto.sns;

import java.util.Date;

public class CommentBoardDto {
	
	private int commentNoSeq;
	private int groupNo;  //댓글 그룹 번호 (모댓글과 거기에 속한 대댓글은 같은 번호를 가진다)
	private int groupDepth; //그룹내 댓글 깊이 댓글인지 대댓글인지 
	private int entireBoardSeq;  //댓글이 속한 게시글 번호 (받아와야하는 값)
	private int userSeq;
	private String userId;
	private String replyContent;
	private Date replyRegDate;
	
	public CommentBoardDto() {

	}

	public CommentBoardDto(int commentNoSeq, int groupNo, int groupDepth, int entireBoardSeq,
			int userSeq, String userId, String replyContent, Date replyRegDate) {

		this.commentNoSeq = commentNoSeq;
		this.groupNo = groupNo;
		this.groupDepth = groupDepth;
		this.entireBoardSeq = entireBoardSeq;
		this.userSeq = userSeq;
		this.userId = userId;
		this.replyContent = replyContent;
		this.replyRegDate = replyRegDate;
	}

	public int getCommentNoSeq() {
		return commentNoSeq;
	}

	public void setCommentNoSeq(int commentNoSeq) {
		this.commentNoSeq = commentNoSeq;
	}

	public int getGroupNo() {
		return groupNo;
	}

	public void setGroupNo(int groupNo) {
		this.groupNo = groupNo;
	}

	public int getGroupDepth() {
		return groupDepth;
	}

	public void setGroupDepth(int groupDepth) {
		this.groupDepth = groupDepth;
	}

	public int getEntireBoardSeq() {
		return entireBoardSeq;
	}

	public void setEntireBoardSeq(int entireBoardSeq) {
		this.entireBoardSeq = entireBoardSeq;
	}

	public int getUserSeq() {
		return userSeq;
	}

	public void setUserSeq(int userSeq) {
		this.userSeq = userSeq;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getReplyContent() {
		return replyContent;
	}

	public void setReplyContent(String replyContent) {
		this.replyContent = replyContent;
	}

	public Date getReplyRegDate() {
		return replyRegDate;
	}

	public void setReplyRegDate(Date replyRegDate) {
		this.replyRegDate = replyRegDate;
	}
	
	
}
