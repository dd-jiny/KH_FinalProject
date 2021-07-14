package com.phoenix.carrot.dto.sns;

public class FollowDto {
	
	private int followSeq;
	private String followingId;
	private String followerId;
	
	public FollowDto() {

	}

	public FollowDto(int followSeq, String followingId, String followerId) {

		this.followSeq = followSeq;
		this.followingId = followingId;
		this.followerId = followerId;
	}

	public int getFollowSeq() {
		return followSeq;
	}

	public void setFollowSeq(int followSeq) {
		this.followSeq = followSeq;
	}

	public String getFollowingId() {
		return followingId;
	}

	public void setFollowingId(String followingId) {
		this.followingId = followingId;
	}

	public String getFollowerId() {
		return followerId;
	}

	public void setFollowerId(String followerId) {
		this.followerId = followerId;
	}
	
	
	
	
	
	

}
