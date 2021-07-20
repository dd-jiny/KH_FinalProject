package com.phoenix.carrot.dto.sns;

public class FollowDto {
	
	private int followSeq;
	private String following_ID;
	private String follower_ID;
	
	public FollowDto() {

	}

	public FollowDto(int followSeq, String following_ID, String follower_ID) {
		super();
		this.followSeq = followSeq;
		this.following_ID = following_ID;
		this.follower_ID = follower_ID;
	}

	public int getFollowSeq() {
		return followSeq;
	}

	public void setFollowSeq(int followSeq) {
		this.followSeq = followSeq;
	}

	public String getFollowing_ID() {
		return following_ID;
	}

	public void setFollowing_ID(String following_ID) {
		this.following_ID = following_ID;
	}

	public String getFollower_ID() {
		return follower_ID;
	}

	public void setFollower_ID(String follower_ID) {
		this.follower_ID = follower_ID;
	}

	

}
