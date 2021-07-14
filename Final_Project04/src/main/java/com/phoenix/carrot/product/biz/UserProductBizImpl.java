package com.phoenix.carrot.product.biz;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.phoenix.carrot.biz.sns.SnsBoardBizImpl;
import com.phoenix.carrot.product.dao.UserProductDao;
import com.phoenix.carrot.product.dto.ProductDto;


@Service
public class UserProductBizImpl implements UserProductBiz {
	
	private Logger logger = LoggerFactory.getLogger(UserProductBizImpl.class);
	
	@Autowired
	private UserProductDao dao;
	
	@Override
	public List<ProductDto> userProductList() {

		return dao.userProductList();
	}

	@Override
	public ProductDto userProductOne(int productSeq) {

		return dao.userProductOne(productSeq);
	}

	@Override
	public int userProductInsert(ProductDto dto) {

		return dao.userProductInsert(dto);
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
		return dao.selectByaddr(sellerAddress);
	}

	@Override
	public List<ProductDto> selectByproName(String productName) {
		// TODO Auto-generated method stub
		return dao.selectByproName(productName);
	}

	@Override
	public List<ProductDto> selectlistLatLong() {
		// TODO Auto-generated method stub
		return dao.selectlistLatLong();
	}

	@Override
	public ProductDto selectOneByName(String productName) {
		// TODO Auto-generated method stub
		return dao.selectOneByName(productName);
	}

}
