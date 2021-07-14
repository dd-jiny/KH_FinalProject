package com.phoenix.carrot.admin.dao;

import java.util.List;

import com.phoenix.carrot.product.dto.ProductDto;

public interface AdminProductDao {

	String NAMESPACE = "adminProduct.";
	//상품리스트출력
	public List<ProductDto> adminProductList();
	//등록상품상세출력
	public ProductDto adminProductOne(int productSeq);
	//상품등록
	public int adminProductInsert(ProductDto dto);
	//상품수정
	public int adminProductUpdate(ProductDto dto);
	//상품삭제
	public int adminProductDelete(int productSeq);

}
