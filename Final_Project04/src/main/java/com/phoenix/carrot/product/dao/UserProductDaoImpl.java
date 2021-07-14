package com.phoenix.carrot.product.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.phoenix.carrot.product.dto.ProductDto;


@Repository
public class UserProductDaoImpl implements UserProductDao {
	
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public List<ProductDto> userProductList() {
		
		List<ProductDto> userProductList = new ArrayList<ProductDto>();
		
		try {
			userProductList = sqlSession.selectList(NAMESPACE + "userProductList");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return userProductList;
	}

	@Override
	public ProductDto userProductOne(int productSeq) {
		ProductDto dto = null;
		
		try {
			dto = sqlSession.selectOne(NAMESPACE + "userProductOne", productSeq);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public int userProductInsert(ProductDto dto) {
		int res = 0;
		
		try {
			res = sqlSession.insert(NAMESPACE + "userProductInsert", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return res;
	}

	@Override
	public int userProductUpdate(ProductDto dto) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int userProductDelete(int productSeq) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<ProductDto> selectByaddr(String sellerAddress) {
		// TODO Auto-generated method stub
		
		List<ProductDto> productListByaddr = new ArrayList<ProductDto>();
		
		try {
			productListByaddr = sqlSession.selectList(NAMESPACE+"selectByaddr", sellerAddress);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return productListByaddr;
	}

	@Override
	public List<ProductDto> selectByproName(String productName) {
		// TODO Auto-generated method stub
		
		List<ProductDto> productListByproName = new ArrayList<ProductDto>();
		
		try {
			productListByproName = sqlSession.selectList(NAMESPACE+"selectByproName", productName);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		return productListByproName;
	}

	@Override
	public List<ProductDto> selectlistLatLong() {
		// TODO Auto-generated method stub
		
		List<ProductDto> list = null;
		
		try {
			list = sqlSession.selectList(NAMESPACE+"selectlistLatLong");
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			System.out.println("위도 경도 리스트 추출 실패");
		}
		return list;
	}

	@Override
	public ProductDto selectOneByName(String productName) {
		// TODO Auto-generated method stub
		
		ProductDto res = null;
		
		try {
			res = sqlSession.selectOne(NAMESPACE+"selectOneByName", productName);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return res;
	}
	

}
