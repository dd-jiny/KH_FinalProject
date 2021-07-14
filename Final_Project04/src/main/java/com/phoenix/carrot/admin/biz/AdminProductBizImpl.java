package com.phoenix.carrot.admin.biz;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.phoenix.carrot.admin.dao.AdminProductDao;
import com.phoenix.carrot.product.biz.UserProductBizImpl;
import com.phoenix.carrot.product.dao.UserProductDao;
import com.phoenix.carrot.product.dto.ProductDto;

@Service
public class AdminProductBizImpl implements AdminProductBiz {
	
	private Logger logger = LoggerFactory.getLogger(UserProductBizImpl.class);
	
	@Autowired
	private AdminProductDao dao;
	
	@Override
	public List<ProductDto> adminProductList() {
		
		return dao.adminProductList();
	}

	@Override
	public ProductDto adminProductOne(int productSeq) {
		
		return dao.adminProductOne(productSeq);
	}

	@Override
	public int adminProductInsert(ProductDto dto) {
		
		return dao.adminProductInsert(dto);
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
