package com.phoenix.carrot.model.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.phoenix.carrot.biz.sns.CommentBoardBiz;
import com.phoenix.carrot.biz.sns.FileValidator;
import com.phoenix.carrot.biz.sns.LikeTableBiz;
import com.phoenix.carrot.biz.sns.SnsBoardBiz;
import com.phoenix.carrot.dao.sns.LikeTableDao;
import com.phoenix.carrot.dto.sns.CommentBoardDto;
import com.phoenix.carrot.dto.sns.EntireBoardDto;
import com.phoenix.carrot.dto.sns.LikeTableDto;
import com.phoenix.carrot.user.biz.UserBiz;
import com.phoenix.carrot.user.dto.UserDto;
import com.phoenix.carrot.utils.UploadFileUtils;

@Controller
public class SnsController {
	
	private Logger logger = LoggerFactory.getLogger(SnsController.class);
	
	@Autowired
	private FileValidator fileValidator;
	
	@Autowired
	private SnsBoardBiz biz;
	
	@Autowired
	private LikeTableBiz likebiz;
	
	@Autowired
	private UserBiz userbiz;
	@Autowired
	private CommentBoardBiz commentbiz;
	
	@Resource(name="uploadPath")
	private String uploadPath;
	
	@RequestMapping("/main.do")
	public String mainForm(Model model , HttpSession session, @SessionAttribute("login") UserDto userdto) {
		logger.info("[Controller] : main.do");
		
		String userId = userdto.getUserid();
		
		//좋아요 여부 정보 모델링
		//model.addAttribute("likeCheck",likebiz.likeCheck(entireBoardSeq, userSeq));
		model.addAttribute("snsUserSelectOne", biz.snsUserSelectOne(userId));
		model.addAttribute("snsBoardList", biz.snsBoardList());
		
		return "main";
	}
	
	@RequestMapping("/snsBoardUserFeed.do")
	public String snsUserFeed(Model model, @RequestParam String userId) {
		logger.info("[Controller] : snsBoardUserFeed.do");
		
		model.addAttribute("snsUserSelectOne", biz.snsUserSelectOne(userId));
		model.addAttribute("snsUserFeedList", biz.snsUserFeedList(userId));
		return "snsuserfeed";
	}
	
	@RequestMapping("/snsBoardInsertForm.do")
	public String snsBoardInsertForm() {
		
		return "snsboardinsert";
	}
	
	@RequestMapping("/snsBoardInsertRes.do")
	public String snsBoardInsertRes(EntireBoardDto dto, MultipartFile file, HttpSession session) throws Exception {
		logger.info("[Controller] : snsBoardInsertRes.do");
		
		String imgUploadPath = uploadPath + File.separator + "upload";
		String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
		String fileName = null;
		String userId = dto.getUserId();
		System.out.println("userId : " + userId);
		if (file != null) {
			fileName = UploadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(), ymdPath);
		} else {
			fileName = uploadPath + File.separator + "image" + File.separator +"none.png";
		}
		
		dto.setBoardImg(File.separator + "upload" + ymdPath + File.separator + fileName);
		dto.setBoardThumbImg(File.separator + "upload" + ymdPath + File.separator + "s" + File.separator + "s_" + fileName);
		
		biz.snsBoardInsert(dto);
		
		return "redirect:snsBoardUserFeed.do?userId="+userId;
		
		/*
		 RedirectAttributes redirectAttributes파라미터 추가! 
		biz.snsBoardInsert(dto);
		redirectAttributes.addFlashAttribute("msg", "regSuccess");
		
		return "redirect:main.do";
		*/
	}
	
	@RequestMapping("/snsBoardOne.do")
	public String snsBoardOne(Model model, int entireBoardSeq ,@RequestParam Map<String, Object> paramMap,@SessionAttribute("login") UserDto userdto, HttpSession session) {
		logger.info("[Controller] : snsBoardOne.do");
		CommentBoardDto commentdto = new CommentBoardDto();
		
		int userSeq = userdto.getUserseq();
		
		// 게시물에대한 정보 모델링 
		model.addAttribute("dto", biz.snsBoardOne(entireBoardSeq));
		//좋아요 여부 정보 모델링
		model.addAttribute("likeCheck",likebiz.likeCheck(entireBoardSeq, userSeq));
		//댓글리스트 모델링 
		model.addAttribute("replyList", commentbiz.getReplyList(paramMap));
		
		return "snsboarddetail";
	}
	

	@RequestMapping("/snsBoardUpdateForm.do")
	public String snsBoardUpdateForm(Model model, int entireBoardSeq) {
		logger.info("[Controller] : snsBoardUpdateForm.do");
		
		model.addAttribute("dto", biz.snsBoardOne(entireBoardSeq));
		return "snsboardupdate";
	}
	
	@RequestMapping("/snsBoardUpdateRes.do")
	public String snsBoardUpdateRes(EntireBoardDto dto) {
		logger.info("[Controller] : snsBoardUpdateRes.do");
		
		if (biz.snsBoardUpdate(dto) > 0) {
			return "redirect:snsBoardOne.do?entireBoardSeq="+dto.getEntireBoardSeq();
		}
		
		return "redirect:snsBoardUpdateForm.do";
	}
	
	@RequestMapping("/snsBoardDelete.do")
	public String snsBoardDelete(int entireBoardSeq, RedirectAttributes redirectAttributes) throws Exception {
		logger.info("[Controller] : snsBoardDelete.do");
		
		biz.snsBoardDelete(entireBoardSeq);
		
		redirectAttributes.addFlashAttribute("msg", "delSuccess");
				
		return "redirect:main.do";
	}
	
	
	//빈하트 클릭시 저장 
	@ResponseBody
	@RequestMapping(value="/saveHeart.do")
	public EntireBoardDto save_heart(@RequestParam int entireBoardSeq,@SessionAttribute("login") UserDto user, HttpSession session) {
		logger.info("[Controller] : saveHeart.do");
		LikeTableDto likeDto = new LikeTableDto();
		
		//게시물 번호 세팅
		likeDto.setEntireBoardSeq(entireBoardSeq);
		
		//좋아요 누른사람 id를 세팅 
		//likeDto.setUserId((String) session.getAttribute("userid"));
		//String userId = ((String) session.getAttribute("userid"));
		int userSeq = user.getUserseq();
		String userId = user.getUserid();
		System.out.println(userId);
		likeDto.setUserSeq(userSeq);
		likeDto.setUserId(userId);
		//+1된 하트 갯수를 담아오기 위함
		EntireBoardDto dto = likebiz.pictureSaveHeart(likeDto);
		return dto;
	}
	
	@ResponseBody
	@RequestMapping(value="/removeHeart.do")
	public EntireBoardDto remove_heart(@RequestParam int entireBoardSeq,@SessionAttribute("login") UserDto user, HttpSession session) {
		logger.info("[Controller] : /removeHeart.do");
		LikeTableDto likeDto = new LikeTableDto();
		
		//게시물 번호 세팅 
		likeDto.setEntireBoardSeq(entireBoardSeq);
		
		//아이디, seq 세팅 
		int userSeq = user.getUserseq();
		String userId = user.getUserid();
		System.out.println(userId);
		likeDto.setUserSeq(userSeq);
		likeDto.setUserId(userId);
		
		//-1된 하트 갯수를 담아오기 위함
		EntireBoardDto dto = likebiz.pictureRemoveHeart(likeDto);
		return dto;
	}

	//검색을 위한 유저리스트 전체 출력 
	@RequestMapping("/snsUserSearch.do")
	public String userList(Model model) {
		
		logger.info("[Controller] : snsUserSearch.do");
		model.addAttribute("userList", biz.userList());
		return "snsusersearch";
	} 
	
	@ResponseBody
	@RequestMapping(value="/searchUser.do", method=RequestMethod.POST)
	public Map<String, Object> searchUser (HttpSession session, @RequestBody UserDto userdto) {
		
		System.out.println("값 전달");
		System.out.println("userid : " + userdto.getUserid());
		System.out.println("username : " + userdto.getUsername());
		
		String userid = userdto.getUserid();
		String username = userdto.getUsername();
		List<UserDto> userList = new ArrayList<UserDto>();
		
		Map<String, Object> userResult = new HashMap<String, Object>();
		
		if(userid != null) {
			userList =  biz.snsSearchUserById(userid);
			if(userList != null) {
				userResult.put("userList", userList);
			}
		} else if (username != null) {
			userList = biz.snsSearchUserByName(username);
			userResult.put("userList", userList);
		}
		return userResult;
	}
}
















