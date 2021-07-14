package com.phoenix.carrot.user.dto;

public class UserDto {
	private int userseq;
	private String userid;
	private String password;
	private String useremail;
	private String userphone;
	private String useroaddress; // �����ȣ
	private String useraddress;  // �ּ�
	private String userdetailaddress; // ���ּ�
	private String userrole;
	private String username;
	private String userbirthday;
	private String userImg;
	private String userProfileImg;
	
	
	public UserDto() {
	
	}


	public UserDto(int userseq, String userid, String password, String useremail, String userphone, String useroaddress,
			String useraddress, String userdetailaddress, String userrole, String username, String userbirthday,
			String userImg, String userProfileImg) {
		super();
		this.userseq = userseq;
		this.userid = userid;
		this.password = password;
		this.useremail = useremail;
		this.userphone = userphone;
		this.useroaddress = useroaddress;
		this.useraddress = useraddress;
		this.userdetailaddress = userdetailaddress;
		this.userrole = userrole;
		this.username = username;
		this.userbirthday = userbirthday;
		this.userImg = userImg;
		this.userProfileImg = userProfileImg;
	}


	public int getUserseq() {
		return userseq;
	}


	public void setUserseq(int userseq) {
		this.userseq = userseq;
	}


	public String getUserid() {
		return userid;
	}


	public void setUserid(String userid) {
		this.userid = userid;
	}


	public String getPassword() {
		return password;
	}


	public void setPassword(String password) {
		this.password = password;
	}


	public String getUseremail() {
		return useremail;
	}


	public void setUseremail(String useremail) {
		this.useremail = useremail;
	}


	public String getUserphone() {
		return userphone;
	}


	public void setUserphone(String userphone) {
		this.userphone = userphone;
	}


	public String getUseroaddress() {
		return useroaddress;
	}


	public void setUseroaddress(String useroaddress) {
		this.useroaddress = useroaddress;
	}


	public String getUseraddress() {
		return useraddress;
	}


	public void setUseraddress(String useraddress) {
		this.useraddress = useraddress;
	}


	public String getUserdetailaddress() {
		return userdetailaddress;
	}


	public void setUserdetailaddress(String userdetailaddress) {
		this.userdetailaddress = userdetailaddress;
	}


	public String getUserrole() {
		return userrole;
	}


	public void setUserrole(String userrole) {
		this.userrole = userrole;
	}


	public String getUsername() {
		return username;
	}


	public void setUsername(String username) {
		this.username = username;
	}


	public String getUserbirthday() {
		return userbirthday;
	}


	public void setUserbirthday(String userbirthday) {
		this.userbirthday = userbirthday;
	}


	public String getUserImg() {
		return userImg;
	}


	public void setUserImg(String userImg) {
		this.userImg = userImg;
	}


	public String getUserProfileImg() {
		return userProfileImg;
	}


	public void setUserProfileImg(String userProfileImg) {
		this.userProfileImg = userProfileImg;
	}
	
		
}
