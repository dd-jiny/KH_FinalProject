package com.phoenix.carrot.model.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MypageController {

@RequestMapping("/mypage.do")
public String Mypage() {
	return "mypage";
}

@RequestMapping("/userUpdate.do")
public String userUpdate() {
	return"userupdate";
}
}
