package com.phoenix.carrot.model.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class JaeheeController {
	
	@RequestMapping("/pay.do")
	public String payForm() {
			return "pay";
	}
	
	

}
