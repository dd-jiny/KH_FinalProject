package com.phoenix.carrot.admin.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.phoenix.carrot.product.dto.ProductDto;

@Repository
public class AdminProductDaoImpl implements AdminProductDao {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public List<ProductDto> adminProductList() {
		List<ProductDto> adminProductList = new ArrayList<ProductDto>();
	
		try {
			adminProductList = sqlSession.selectList(NAMESPACE + "adminProductList");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return adminProductList;
	}

	@Override
	public ProductDto adminProductOne(int productSeq) {
		ProductDto dto = null;
		
		try {
		dto = sqlSession.selectOne(NAMESPACE + "adminProductOne", productSeq);
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public int adminProductInsert(ProductDto dto) {
		int res = 0;
		
		try {
			res = sqlSession.insert(NAMESPACE + "adminProductInsert", dto);
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return res;
	}

	@Override
	public int adminProductUpdate(ProductDto dto) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int adminProductDelete(int productSeq) {
		// TODO Auto-generated method stub
		return 0;
	}

}
