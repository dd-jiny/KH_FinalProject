package com.phoenix.carrot.admin.biz;

import java.util.List;

import com.phoenix.carrot.product.dto.ProductDto;

public interface AdminProductBiz {
	
		//상품리스트출력
		public List<ProductDto> adminProductList();
		//등록상품상세출력
		public ProductDto adminProductOne(int productSeq);
		//상품등록
		public int adminProductInsert(ProductDto dto);
		//유저상품수정
		public int adminProductUpdate(ProductDto dto);
		//상품삭제
		public int adminProductDelete(int productSeq);
}
