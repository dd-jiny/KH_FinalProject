package com.phoenix.carrot.dto.sns;

public class LikeTableDto {
	
	private int likeSeq;
	private int userSeq;
	private String userId;
	private int entireBoardSeq;
	private int likeCheck;
	
	

	public LikeTableDto() {

	}
	
	

	public LikeTableDto(int likeSeq, int userSeq, String userId, int entireBoardSeq, int likeCheck) {

		this.likeSeq = likeSeq;
		this.userSeq = userSeq;
		this.userId = userId;
		this.entireBoardSeq = entireBoardSeq;
		this.likeCheck = likeCheck;
	}



	public int getLikeSeq() {
		return likeSeq;
	}

	public void setLikeSeq(int likeSeq) {
		this.likeSeq = likeSeq;
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

	public int getEntireBoardSeq() {
		return entireBoardSeq;
	}

	public void setEntireBoardSeq(int entireBoardSeq) {
		this.entireBoardSeq = entireBoardSeq;
	}



	public int getLikeCheck() {
		return likeCheck;
	}



	public void setLikeCheck(int likeCheck) {
		this.likeCheck = likeCheck;
	}

	

}
