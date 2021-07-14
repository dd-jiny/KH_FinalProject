package com.phoenix.carrot.model.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.phoenix.carrot.admin.biz.NoticeBoardBiz;
import com.phoenix.carrot.dto.sns.EntireBoardDto;

@Controller
public class NoticeBoardController {
	
	private Logger logger = LoggerFactory.getLogger(NoticeBoardController.class);
	
	@Autowired
	private NoticeBoardBiz biz;
	
	
	@RequestMapping("/noticeboardlist.do")
	public String noticeBoardlist(Model model) {
		List<EntireBoardDto> list = biz.noticeBoardList();
		
		model.addAttribute("noticeBoardList", list);
		
		return "noticeboard";
	}
	
	@RequestMapping("/noticeboarddetail.do")
	public String noticeboardDetail(@RequestParam("entireBoardSeq") int entireBoardSeq, Model model) {
		
		EntireBoardDto dto = biz.noticeBoardOne(entireBoardSeq);
		
		model.addAttribute("dto", dto);
		
		
		return "noticeboarddetail";
	}
	
	
	
}
