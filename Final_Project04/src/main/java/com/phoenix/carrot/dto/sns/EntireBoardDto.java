package com.phoenix.carrot.dto.sns;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

public class EntireBoardDto {
	
	//기본필드
	private int entireBoardSeq;
	private String boardKind;
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date boardDate;
	private String boardTitle;
	private String boardContents;
	private String userId;
	private int userSeq;
	private String boardImg;
	private String boardThumbImg;
	private int likeCount;
	
	//private String[] files;
	
	public EntireBoardDto() {

	}

	public EntireBoardDto(int entireBoardSeq, String boardKind, Date boardDate, String boardTitle, String boardContents,
			String userId, int userSeq, String boardImg, String boardThumbImg, int likeCount) {
		this.entireBoardSeq = entireBoardSeq;
		this.boardKind = boardKind;
		this.boardDate = boardDate;
		this.boardTitle = boardTitle;
		this.boardContents = boardContents;
		this.userId = userId;
		this.userSeq = userSeq;
		this.boardImg = boardImg;
		this.boardThumbImg = boardThumbImg;
		this.likeCount = likeCount;
	}

	public int getEntireBoardSeq() {
		return entireBoardSeq;
	}

	public void setEntireBoardSeq(int entireBoardSeq) {
		this.entireBoardSeq = entireBoardSeq;
	}

	public String getBoardKind() {
		return boardKind;
	}

	public void setBoardKind(String boardKind) {
		this.boardKind = boardKind;
	}

	public Date getBoardDate() {
		return boardDate;
	}

	public void setBoardDate(Date boardDate) {
		this.boardDate = boardDate;
	}

	public String getBoardTitle() {
		return boardTitle;
	}

	public void setBoardTitle(String boardTitle) {
		this.boardTitle = boardTitle;
	}

	public String getBoardContents() {
		return boardContents;
	}

	public void setBoardContents(String boardContents) {
		this.boardContents = boardContents;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public int getUserSeq() {
		return userSeq;
	}

	public void setUserSeq(int userSeq) {
		this.userSeq = userSeq;
	}

	public String getBoardImg() {
		return boardImg;
	}

	public void setBoardImg(String boardImg) {
		this.boardImg = boardImg;
	}

	public String getBoardThumbImg() {
		return boardThumbImg;
	}

	public void setBoardThumbImg(String boardThumbImg) {
		this.boardThumbImg = boardThumbImg;
	}

	public int getLikeCount() {
		return likeCount;
	}

	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}
	

}
