package com.phoenix.carrot.user.biz;

import com.phoenix.carrot.user.dto.UserDto;

public interface UserBiz {

	public UserDto login(UserDto dto);
	
	public int regist(UserDto dto);
	
	public UserDto idcheck(String userid);
	
	public String find_id(String useremail);
	
	public int updatePw(UserDto dto);
	
	//�̸��Ϲ߼�
	public void sendEmail(UserDto dto);

	//��й�ȣã��
	public String findPw(UserDto dto) throws Exception;


}
