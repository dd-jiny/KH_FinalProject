package com.phoenix.carrot.product.biz;

import java.util.List;

import com.phoenix.carrot.product.dto.ProductDto;

public interface UserProductBiz {

	// 유저상품리스트출력
	public List<ProductDto> userProductList();

	// 유저등록상품상세출력
	public ProductDto userProductOne(int productSeq);

	// 유저상품등록
	public int userProductInsert(ProductDto dto);

	// 유저상품수정
	public int userProductUpdate(ProductDto dto);

	// 유저상품삭제
	public int userProductDelete(int productSeq);

	// 주소로 상품 검색
	public List<ProductDto> selectByaddr(String sellerAddress);

	// 상품명으로 검색
	public List<ProductDto> selectByproName(String productName);

	// 회원 위도 경도 리스트 뽑아오기
	public List<ProductDto> selectlistLatLong();
	
	
	// 상품명으로 하나 꺼내오기
	public ProductDto selectOneByName(String productName);

}
