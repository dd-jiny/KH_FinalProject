package com.phoenix.carrot.model.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

import org.apache.commons.io.FileUtils;
import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;


import com.google.gson.JsonObject;
import com.phoenix.carrot.chat.biz.ChatRoomBiz;
import com.phoenix.carrot.chat.dto.ChatRoomDto;
import com.phoenix.carrot.product.biz.UserProductBiz;
import com.phoenix.carrot.product.dto.ProductDto;
import com.phoenix.carrot.utils.UploadFileUtils;

@Controller
public class UserMarketController {

	private Logger logger = LoggerFactory.getLogger(UserMarketController.class);

	@Resource(name = "uploadPath")
	private String uploadPath;

	@Autowired
	private UserProductBiz biz;

	@Autowired
	private ChatRoomBiz cbiz;

	@RequestMapping(value = "/uploadSummernoteImageFile.do", method = RequestMethod.POST, produces = "application/json; charset=utf8")
	@ResponseBody
	public String uploadSummernoteImageFile(@RequestParam("file") MultipartFile multipartFile,
			HttpServletRequest request) {
		JsonObject jsonObject = new JsonObject();

		/*
		 * String fileRoot = "C:\\summernote_image\\"; // �쇅遺�寃쎈줈濡� ���옣�쓣 �씗留앺븷�븣.
		 */

		// �궡遺�寃쎈줈濡� ���옣
		String contextRoot = new HttpServletRequestWrapper(request).getRealPath("/");
		String fileRoot = contextRoot + "resources/fileupload/";

		String originalFileName = multipartFile.getOriginalFilename(); // �삤由ъ��궇 �뙆�씪紐�
		String extension = originalFileName.substring(originalFileName.lastIndexOf(".")); // �뙆�씪 �솗�옣�옄
		String savedFileName = UUID.randomUUID() + extension; // ���옣�맆 �뙆�씪 紐�

		File targetFile = new File(fileRoot + savedFileName);
		try {
			InputStream fileStream = multipartFile.getInputStream();
			FileUtils.copyInputStreamToFile(fileStream, targetFile); // �뙆�씪 ���옣
			jsonObject.addProperty("url", "/carrot/resources/fileupload/" + savedFileName); // contextroot + resources +
																							// ���옣�븷 �궡遺� �뤃�뜑紐�
			jsonObject.addProperty("responseCode", "success");

		} catch (IOException e) {
			FileUtils.deleteQuietly(targetFile); // ���옣�맂 �뙆�씪 �궘�젣
			jsonObject.addProperty("responseCode", "error");
			e.printStackTrace();
		}
		String a = jsonObject.toString();
		return a;
	}

	@RequestMapping("/jusoPopup.do")
	public String jusoPopup() {

		return "jusoPopup";

	}

	@RequestMapping("/usermarketplace.do")
	public String userProductList(Model model) {
		logger.info("[Controller] : usermarketplace.do");
		model.addAttribute("userProductList", biz.userProductList());
		return "userproductmarket1";
	}

	@RequestMapping("/userproductinsert.do")
	public String productInsertForm() {
		return "userproductinsert";
	}

	@RequestMapping("/userproductinsertres.do")
	public String productInsertRes(ProductDto dto, MultipartFile file) throws Exception {

		String imgUploadPath = uploadPath + File.separator + "upload";
		String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
		String fileName = null;

		if (file != null) {
			fileName = UploadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(), ymdPath);
		} else {
			fileName = uploadPath + File.separator + "image" + File.separator + "none.png";
		}

		dto.setProductImg(File.separator + "upload" + ymdPath + File.separator + fileName);
		dto.setProductThumb(
				File.separator + "upload" + ymdPath + File.separator + "s" + File.separator + "s_" + fileName);

		biz.userProductInsert(dto);

		return "redirect:usermarketplace.do";
	}

	@RequestMapping("/userproductdetail.do")
	public String productDetail(Model model, @RequestParam("productSeq") int productSeq, HttpServletRequest request) {
		logger.info("[Controller] : userproductdetail.do");

		List<ProductDto> list = new ArrayList<ProductDto>();

		list = biz.selectlistLatLong();

		JSONObject obj = new JSONObject();
		
		JSONArray jArray = new JSONArray();


		for (int i = 0; i < list.size(); i++) {
			JSONObject sObject = new JSONObject();
			sObject.put("title", list.get(i).getProductName());
			sObject.put("lat", list.get(i).getUserLatitude());
			sObject.put("lng", list.get(i).getUserLongitude());
			jArray.put(sObject);
		}
/*
		for(ProductDto dto2 : list) { 
		 sObject.put("title", dto2.getProductName());
		 sObject.put("lat", dto2.getUserLatitude()); 
		 sObject.put("lng", dto2.getUserLongitude()); 
		 jArray.put(sObject); 
		 }
*/
		obj.put("positions", jArray);

		model.addAttribute("data", obj);

		model.addAttribute("dto", biz.userProductOne(productSeq));

		return "userproductdetail";
	}

	
	  @RequestMapping("/markerdetail.do") public String
	 markerDetail(HttpServletRequest request, Model model) { 
		  String productName = request.getParameter("productName");
		  System.out.println(productName);
	 
	 logger.info("[Controller] : marekrdetail.do");
	 
	  ProductDto dto = biz.selectOneByName(productName);
	
	 List<ProductDto> list = new ArrayList<ProductDto>();
	  
	list = biz.selectlistLatLong();
	 
	JSONObject obj = new JSONObject(); JSONArray jArray = new JSONArray();
	 JSONObject sObject = new JSONObject();
	 
	 for (int i = 0; i < list.size(); i++) {
	  
	  sObject.put("title", list.get(i).getProductName()); sObject.put("lat",
	  list.get(i).getUserLatitude()); sObject.put("lng",
	  list.get(i).getUserLongitude()); jArray.put(sObject); }
	  
	  /*
	  for(ProductDto dto2 : list) { sObject.put("title", dto2.getProductName());
	  sObject.put("lat", dto2.getUserLatitude()); sObject.put("lng",
	  dto2.getUserLongitude()); jArray.put(sObject); }
	  */
	  obj.put("positions", jArray);
	  
	  model.addAttribute("data", obj);
	  
	  
	  model.addAttribute("dto", dto);
	  
	  
	  return "userproductdetail2";
	  }


}
