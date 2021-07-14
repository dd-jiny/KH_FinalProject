package com.phoenix.carrot.model.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.JsonNode;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.phoenix.carrot.admin.dto.WeatherDto;
import com.phoenix.carrot.login.NaverLoginBo;
import com.phoenix.carrot.login.VerifyRecaptcha;
import com.phoenix.carrot.user.biz.UserBiz;
import com.phoenix.carrot.user.dao.UserDao;
import com.phoenix.carrot.user.dto.UserDto;

@Controller
public class UserController {
	
	private Logger logger = LoggerFactory.getLogger(UserController.class);
	
	@Autowired
	private Weather weather;
	
	// NaverLoginBo
		private NaverLoginBo naverLoginBO;
		private String apiResult = null;

		@Autowired
		private void setNaverLoginBO(NaverLoginBo naverLoginBO) {
			this.naverLoginBO = naverLoginBO;
		}
	
	
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	private UserBiz biz;
	
	@Autowired
	private UserDao dao;

	
	@RequestMapping("/loginform.do")
	public String goLoginForm(Model model, HttpSession session) {
		logger.info("[Controller] loginform.do");
		logger.info("[Controller] : naverlogin.do");
		logger.info("[Controller] : googlelogin.do");
		String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);

		System.out.println("���̹� : " + naverAuthUrl);

		// ���̹�
		model.addAttribute("naverUrl", naverAuthUrl);

		return "login";
	}

	@RequestMapping(value="/ajaxlogin.do", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Boolean> ajaxLogin(HttpSession session, @RequestBody UserDto dto) {
		logger.info("[Controller] : ajaxlogin.do");
		System.out.println(dto);
		
		UserDto res = biz.login(dto);
		
		System.out.println(res);
		
		boolean check = false;
		
		if(res != null) {
			if(passwordEncoder.matches(dto.getPassword(), res.getPassword())) {
				logger.info("[Controller] : password correct!!");
				
				session.setAttribute("login", res);
				
				check = true;
			} else {
				logger.info("[Controller] : password failed");
			}
		}
		
		Map<String, Boolean> map = new HashMap<String, Boolean>();
		map.put("check", check);
		
		return map;
	}
	
	@RequestMapping("/registform.do")
	public String registForm() {
		logger.info("[Controller] : registform.do");
		
		return "regist";
	}
	
	@RequestMapping(value="/registPost.do", method=RequestMethod.POST)
	public String registPost(UserDto dto) {
		logger.info("[Controller] : registPost.do");
		dto.setUserImg("NULL");
		dto.setUserProfileImg("NULL");
		dto.setPassword(passwordEncoder.encode(dto.getPassword()));
		
		int res = biz.regist(dto);
		
		if(res > 0) {
			return "redirect:loginform.do";
		}
		return "redirect:registform.do";
	}
	
	@RequestMapping(value="/idcheck.do", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Integer> idcheck(@RequestBody UserDto dto) {

		String id = dto.getUserid().trim();

		UserDto dtoq = biz.idcheck(id);
		System.out.println(dto);
		int res = 0;

		if (dtoq != null) {
			res = 1;
		} else {
			res = -1;
		}

		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("res", res);

		return map;
	}
	
	@ResponseBody
	@RequestMapping(value="/VerifyRecaptcha.do", method=RequestMethod.POST)
	public int VerifyRecaptcha(HttpServletRequest request) {
		
		VerifyRecaptcha.setSecretKey("6LfJBFIbAAAAAKqCWrQ2EgrLHaSnt3bsOccH1_G1");
		
		String gRecaptchaResponse = request.getParameter("recaptcha");
		
		try {
			if(VerifyRecaptcha.verify(gRecaptchaResponse)) {
				return 0; // ����������
			} else {
				return 1; // ����������
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return -1; // �������� -1
		}
	}
	
	
	
	
	
	
	@RequestMapping("/findidform.do")
	public String findid() {
		logger.info("[Controller] : findid.do");
		
		return "findidform";
	}
	
	@RequestMapping(value="/ajaxfindid.do", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, String> ajaxFindid(@RequestBody Map<String, String> usermap) {
		logger.info("[Controller] : ajaxfindid.do");
		
		String email = usermap.get("useremail");
		System.out.println(email);
		String res = biz.find_id(email);
		System.out.println(res);
		Map<String, String> map = new HashMap<String, String>();
		if(res != null) {
			map.put("userid", res);
		} else {
			logger.info("[Controller] : findid error");
			map.put("userid", null);
		}
		
		return map;
	}
	
	@RequestMapping("/findpwform.do")
	public String findpwform() {
		logger.info("[Controller] : findpwform.do");

		return "findpwform";
	}

	@RequestMapping(value = "/naverlogincallback.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String naverloginCallback(Model model, @RequestParam String code, @RequestParam String state,
			HttpSession session) throws IOException, ParseException {
		logger.info("[Controller] : naverlogincallback");
		OAuth2AccessToken oauthToken;
		oauthToken = naverLoginBO.getAccessToken(session, code, state);

		// 1. �α��� ����� ������ �о�´�.
		apiResult = naverLoginBO.getUserProfile(oauthToken); // String ������ json ������

		/*
		 * apiResult ���� {"resultcode":"00", "messege":"success",
		 * "reponse":{"id":"339281","nickname":"kim", "age", "gender","email","name"}} }
		 */

		// 2. String ������ apiResult�� json ���·� �ٲ��ش�.
		JSONParser parser = new JSONParser();
		Object obj = parser.parse(apiResult);
		JSONObject jsonObj = (JSONObject) obj;

		// 3. ������ �Ľ�
		JSONObject response_obj = (JSONObject) jsonObj.get("response");
		String userid = (String) response_obj.get("id");
		String useremail = (String) response_obj.get("email");
		String username = (String) response_obj.get("name");
		String nickname = (String) response_obj.get("nickname");
		System.out.println(userid);
		System.out.println(useremail);
		System.out.println(username);

		// 4. �Ľ� �г���
		session.setAttribute("login", nickname);

		model.addAttribute("naverloginUser", apiResult);

		return "navercallback";
	}
	
	@RequestMapping(value = "/googlelogin.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> googleLogin(HttpSession session, @RequestBody UserDto dto) {
		logger.info("[Controller] : googlelogin.do");
		
		UserDto res = biz.login(dto);
		
		String username = "";
		dto.setPassword("null");
		dto.setUseraddress("null");
		dto.setUserbirthday("null");
		dto.setUserdetailaddress("null");
		dto.setUseroaddress("null");
		dto.setUserphone("null");
		dto.setUserProfileImg("null");
		dto.setUserImg("null");
		if (res == null) {
			int regresult = biz.regist(dto);
			if (regresult > 0) {
				System.out.println("ȸ�����Լ���");
				session.setAttribute("login", dto);
				username = dto.getUsername();
			}
		} else {
			session.setAttribute("login", dto);
			username = dto.getUsername();
		}
		Map<String, String> map = new HashMap<String, String>();
		map.put("username", username);

		return map;

	}
	
	@RequestMapping("/logOut.do")
	public String logOut(HttpSession session) {

		session.invalidate();

		return "redirect:/";
	}
	
	@RequestMapping(value="/kakaologincallback.do",method= {RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public Map<String, String> kakaoLogincallback(HttpSession session, @RequestBody UserDto dto) {
		logger.info("[Controller] : kakaologincallback.do");
		
		UserDto res = biz.login(dto);
		
		String username = null;
		
		dto.setPassword("null");
		dto.setUseraddress("null");
		dto.setUserbirthday("null");
		dto.setUserdetailaddress("null");
		dto.setUserrole("user");
		dto.setUseroaddress("null");
		dto.setUserphone("null");
		dto.setUserProfileImg("null");
		dto.setUserImg("null");
		
		if(res == null) {
			int regresult = biz.regist(dto);
			if (regresult > 0) {
				System.out.println("회원가입성공");
				username = dto.getUsername();
				session.setAttribute("login", dto);
			} else {
				System.out.println("회원가입실패");
			}
		} else {
			username = dto.getUsername();
			session.setAttribute("login", dto);
		}
		Map<String, String> map = new HashMap<String, String>();
		map.put("username", username);

		return map;
	}
	
	@RequestMapping(value="/findpw.do", method= {RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public int findpw(@RequestBody UserDto dto) throws Exception {
		
		UserDto selectOneById = dao.selectOneById(dto.getUserid());
		UserDto selectOneByEmail = dao.selectOneByEmail(dto.getUseremail());
		int i = 0;
		
		if(selectOneById.getUserid() == null) {
			i = 1;
			
			//msg = "���Ե� ���̵� �����ϴ�. ���̵� Ȯ���� �ּ���.";
		} else if(selectOneByEmail.getUseremail() == null) {
			i = 2;
			
			//msg = "���Ե� �̸����� �����ϴ�. �̸����� Ȯ���� �ּ���.";
		} else {
			i = 3;
			//msg = "���Ե� �̸��Ϸ� �ӽ� ��й�ȣ�� �����Ͽ����ϴ�. ������ Ȯ�����ּ���.";
			
			String newPw = biz.findPw(selectOneById);
			selectOneById.setPassword(passwordEncoder.encode(newPw));
			biz.updatePw(selectOneById);
			
		}
	
		return i;
	}

	
	@RequestMapping("/honeytip.do")
	public String hoenyTip(Model model) {
		
		//get()호출
		
		List<WeatherDto> list = weather.get();
		System.out.println("controller" + list);
		model.addAttribute("list", list);
	
	
		return "honeytip";
	}


	
}
