package com.phoenix.carrot.model.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.json.Json;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.phoenix.carrot.admin.biz.AdminProductBiz;
import com.phoenix.carrot.order.biz.OrderBiz;
import com.phoenix.carrot.order.dto.OrderDto;
import com.phoenix.carrot.product.dto.ProductDto;
import com.phoenix.carrot.utils.UploadFileUtils;


@Controller
public class AdminProductController {

	private Logger logger = LoggerFactory.getLogger(AdminProductController.class);

	
	@Resource(name="uploadPath")
	private String uploadPath;
	
	@Autowired
	private AdminProductBiz adminproductbiz;
	
	@Autowired
	private OrderBiz orderbiz;
	
	/* adminproduct 게시판 ---------------------------------------------------*/
	/* 상품 리스트 */ 
	@RequestMapping("/adminproduct.do")
	public String adminProduct(Model model) {
		logger.info("[Controller] : adminproduct.do");
		model.addAttribute("adminProductList", adminproductbiz.adminProductList());

		return "adminproduct";
	}

	/* 상품등록 페이지 */
	//C:\Git\Final_Project\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Final_Project04\resources\
	//상품이미지 안보일땐 해당 경로 upload폴더가 있는지 확인
	@RequestMapping("/adminproductinsert.do")
	public String adminProductInsertForm() {
		return "adminproductinsert";
	}
	
	@RequestMapping("/adminproductinsertres.do")
	public String adminProductInsertRes(ProductDto dto, MultipartFile file) throws Exception {
		
		logger.info("[Controller] : adminproductinsertres.do");
		
		String imgUploadPath = uploadPath + File.separator + "upload";
		String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
		String fileName = null;
		
		if (file != null) {
			fileName = UploadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(), ymdPath);
		} else {
			fileName = uploadPath + File.separator + "image" + File.separator +"none.png";
		}
		
		dto.setProductImg(File.separator + "upload" + ymdPath + File.separator + fileName);
		dto.setProductThumb(File.separator + "upload" + ymdPath + File.separator + "s" + File.separator + "s_" + fileName);
		
		adminproductbiz.adminProductInsert(dto);
		
		return "redirect:adminproduct.do";
	}
	
	/* 상품 상세 정보 */
	@RequestMapping("/adminproductdetail.do")
	public String adminProductDetail(Model model, int productSeq) {
		logger.info("[Controller] : adminproductdetail.do");
		
		model.addAttribute("dto", adminproductbiz.adminProductOne(productSeq));
		return "adminproductdetail";
	}
	
	/* adminproduct 결제 ---------------------------------------------------*/
	/* 상품 주문 페이지 */
	@RequestMapping("/adminproductorder.do")
	public String adminproductOrder(Model model, int productSeq) {
		logger.info("[Controller] : adminproductorder.do");
		
		model.addAttribute("dto", adminproductbiz.adminProductOne(productSeq));

		return "adminproductorder";
	}

//	/* 아임포트 결제 페이지*/
//	@RequestMapping(value = "/adminproductorderpay.do", method = RequestMethod.POST)
//	@ResponseBody //결과를 json 형식으로 클라이언트 브라우저에 송신
//	public String adminproductorderPay(@RequestBody OrderDto dto) {
//		logger.info("[Controller] : adminproductorderpay.do");
//		JsonObject json = new JsonObject();
//
//		System.out.println(json);
//		
//		return json.toString();
//	}
	
	


	/* 아임포트 결제 페이지*/
	@ResponseBody // 결과를 json 형식으로 클라이언트 브라우저에 송신
	@RequestMapping(value = "/adminproductorderpay.do", method = RequestMethod.POST)
	public String adminproductorderPay(@RequestParam HashMap<String,Object> param){
		logger.info("[Controller] : adminproductorderpay.do");
		int result = 0;
		//String str = "";

		ObjectMapper mapper = new ObjectMapper();
		try {
			result = orderbiz.productorderInsert(param);
			//str = mapper.writeValueAsString(result);// java object -> json문자열로 변환
		} catch (Exception e) {
			e.printStackTrace();
		}
		//return str;
		return "adminproductorderPay";
	};
//
//	@RequestMapping(value = "/adminproductorderpay.do", method = RequestMethod.POST)
//	public String adminproductorderPay(Model model, OrderDto dto, int productSeq) {
//		logger.info("[Controller] : adminproductorderpay.do");
//		
//		/* adminproductorder.jsp에서 주문정보를 받아온거 찍어보기 */ 
//		
//		System.out.println("dto:"+dto.toString());
//		System.out.println("paymethod:"+dto.getPaymethod());
//		System.out.println("productName:"+dto.getProductName());
//
//		System.out.println("quantity:"+dto.getQuantity());
//		System.out.println("orderAmount:"+dto.getOrderAmount());
//		
//		System.out.println("receiveName:"+dto.getReceiveName());
//		System.out.println("receiverPhone:"+dto.getReceiverPhone());
//		System.out.println("receiverOaddress:"+dto.getReceiverOaddress());
//		System.out.println("receiverRaddress:"+dto.getReceiverRaddress());
//		System.out.println("receiverDetailaddress:"+dto.getReceiverDetailaddress());
//		
//		/* model에 받아온 주문 정보 넣어주기 */
//				
//		model.addAttribute("dto", adminproductbiz.adminProductOne(productSeq));
//		
//		//form 형태로 받아온 paymethod는 hidden type이어서 
//		//@RequestParam("paymethod")String paymethod에 담아주기
//		//HttpServletRequest request에 담기지 않는다.
//	//	model.addAttribute("paymethod", paymethod); 
//		
//		
//		model.addAttribute("productName:"+dto.getProductName());
//		model.addAttribute("orderAmount:"+dto.getOrderAmount());
//		model.addAttribute("quantity", dto.getQuantity());
//		model.addAttribute("orderAmount", dto.getOrderAmount());
//		model.addAttribute("receiveName", dto.getReceiveName());
//		model.addAttribute("receiverPhone", dto.getReceiverPhone());
//		model.addAttribute("receiverOaddress", dto.getReceiverOaddress());
//		model.addAttribute("receiverRaddress", dto.getReceiverRaddress());
//		model.addAttribute("receiverDetailaddress", dto.getReceiverDetailaddress());
//
//		System.out.println("model:"+model);
//	
//		return "adminproductorderPayRes";
//	}
//	
	/* 아임포트 결제 후 db 저장하기 */
//	@ResponseBody 화면에 뿌려줄때
	//ajax에서 보낸걸 받아와야 한다.

	
	//1
//	@RequestMapping(value = "/adminproductorderPayRes.do", method = RequestMethod.POST)
//	public String adminproductorderPayRes(Model model, @RequestBody OrderDto orderdto)throws Exception {
//		logger.info("[Controller] : adminproductorderPayRes.do");
//
//		 HashMap<String, Object> map = new HashMap<String, Object>();
//	        map.put("userseq", orderdto.getUserSeq());
//	        map.put("productSeq", orderdto.getProductSeq());
//	        return map;
//	        
//	}
	
	//2222-데이터 전달 받는거 됨
//	@RequestMapping(value="/adminproductorderPayRes.do")
//	public ModelAndView adminproductorderPayRes(@RequestBody OrderDto params, HttpServletRequest request){
//	    ModelAndView mv = new ModelAndView();
//	    boolean result = true;        
//	        
//	    System.out.println("controllerparams"+params);
//	    
//	    //컨트롤러에서 서비스 넘어가는데
//	    //뷰에서 ajax로 파람 넘겨줌
//	    //뷰에서 받아온건 map타입
//	    //biz에서 orderdto 라서 에러가 남
//	    int res = orderbiz.productorderInsert(params);
//	    System.out.println("res:"+res);
//	    
//	    
//	    
//	    mv.addObject("result", result);
//	    
//	    return mv;
//	}
//	
	
//3
//	@RequestMapping(value = "/adminproductorderPayRes.do", method = RequestMethod.POST)
//	@ResponseBody
//	public Map<String, Object> adminproductorderPayRes(Model model, @RequestParam Map<String, Object> params) {
//		logger.info("[Controller] : adminproductorderPayRes.do");
//		Map<String, Object> map = new HashMap<String, Object>();
//		System.out.println(params.get("userseq"));
//		System.out.println(map);
//		
//		String id = (String) params.get("userseq");
//		System.out.println(id);
//		
//		
//		return map;
//	}
//	
	

}
