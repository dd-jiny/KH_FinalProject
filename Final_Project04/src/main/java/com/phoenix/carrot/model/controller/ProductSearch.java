package com.phoenix.carrot.model.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.phoenix.carrot.product.biz.UserProductBiz;
import com.phoenix.carrot.product.dto.ProductDto;

@Controller
public class ProductSearch {

	
	private Logger logger = LoggerFactory.getLogger(UserMarketController.class);
	
	@Autowired
	private UserProductBiz biz;
	
	
	@RequestMapping(value="/searchProduct.do", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> searchProduct(HttpSession session,@RequestBody ProductDto dto) {
		System.out.println("값 넘어왔어요");
		System.out.println(dto.getSellerAddress());
		System.out.println(dto.getProductName());
		
		String sellerAddress = dto.getSellerAddress();
		String productName = dto.getProductName();
		List<ProductDto> list = new ArrayList<ProductDto>();
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		if(sellerAddress != null) {
			list = biz.selectByaddr(sellerAddress);
			if(list != null) {
			result.put("list", list);
			} 
		} else if(productName != null) {
			list = biz.selectByproName(productName);
			result.put("list", list);
		}
		
		return result;
	}
	
}
