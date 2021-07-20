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
	
	//팔로우 하기
	@RequestMapping(value="/insertFollow.do", method=RequestMethod.POST)
	@ResponseBody
	public int insertFollow(Model model, String follower_ID, String following_ID, FollowDto followdto, HttpSession session) throws Exception {
		
		followbiz.insertFollow(followdto);
		String follow = followdto.getFollower_ID();
		int followInfo = followbiz.checkFollow(followdto.getFollowing_ID(), follow);
		
		//followingInfo=1이라면 이미 팔로워  followingInfo=0이라면 아직 팔로워하지 않았음
		if(followInfo == 0) {
			model.addAttribute("followingInfo", "enable");
		} else {
			model.addAttribute("followingInfo", "disable");
		}
		
		model.addAttribute("followCount",followbiz.followCount(follow));//구독자 수
		model.addAttribute("following_ID",followbiz.selectFollow(follow));
		
		return followbiz.followCount(follow);
	};
	
	//팔로우 취소
	@RequestMapping(value="/deleteFollow.do", method=RequestMethod.POST)
	@ResponseBody
	public int deleteFollow(Model model, String follower_ID,String following_ID, FollowDto followdto, HttpSession session) throws Exception {
		
		followbiz.deleteFollow(following_ID, follower_ID);
		
		String follow = followdto.getFollower_ID();
		
		int followInfo = followbiz.checkFollow(followdto.getFollowing_ID(), follow);
		
		if(followInfo == 0) {
			model.addAttribute("followingInfo", "enable");
		} else {
			model.addAttribute("followingInfo", "disable");
		}
		
		model.addAttribute("followCount",followbiz.followCount(follow));
		model.addAttribute("following_ID",followbiz.selectFollow(follow));
		
		return followbiz.followCount(follow);
	}
	
	//내가 팔로우한 사용자들 
	@RequestMapping(value="/myFollowing.do", method=RequestMethod.GET)
	public String myFollowing(Model model, String following_ID, HttpSession session) throws Exception {
		session.getAttribute("userid");
		model.addAttribute("myFollowing", followbiz.myFollow(following_ID));
		
		return "myfollowinglist";
				
	}
	
	//나를 팔로우한 사용자 
	@RequestMapping(value="/myFollower.do", method=RequestMethod.GET)
	public String myFollower(Model model, String follower_ID, HttpSession session) throws Exception {
		session.getAttribute("userid");
		model.addAttribute("myFollower", followbiz.myFollow(follower_ID));
		return "myfollowerlist";
	}
	
	
	
}
























