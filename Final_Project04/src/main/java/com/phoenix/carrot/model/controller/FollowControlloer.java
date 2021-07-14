package com.phoenix.carrot.model.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.phoenix.carrot.biz.sns.FollowBiz;
import com.phoenix.carrot.dto.sns.FollowDto;

@Controller
public class FollowControlloer {
	
	@Autowired
	private FollowBiz followbiz;
	
	@RequestMapping(value="/insertFollow.do", method=RequestMethod.POST)
	@ResponseBody
	public int insertFollow(Model model, String follower_ID, String following_ID, FollowDto followdto, HttpSession session) throws Exception {
		
		followbiz.insertFollow(followdto);
		String follower = followdto.getFollowerId();
		int followingInfo = followbiz.checkFollow(followdto.getFollowingId(), follower_ID);
		
		//followingInfo=1이라면 이미 팔로워  followingInfo=0이라면 아직 팔로워하지 않았음
		if(followingInfo == 0) {
			model.addAttribute("followingInfo", "enable");
		} else {
			model.addAttribute("followingInfo", "disable");
		}
		
		model.addAttribute("countSub",followbiz.followCount(follower_ID));//구독자 수
		model.addAttribute("member_email_sub",followbiz.selectFollow(follower_ID));
		
		return followbiz.followCount(follower_ID);
	};
}
