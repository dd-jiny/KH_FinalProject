package com.phoenix.carrot.order.dao;

import java.util.HashMap;

import com.phoenix.carrot.order.dto.OrderDto;

public interface OrderDao {
	
	String NAMESPACE = "Order.";
	
	//해당 아이디로 결제내역 추가
	public int productorderInsert(HashMap<String, Object> param);

	//해당 아이디로 된 마지막 결제내역 확인
	public OrderDto productorderOne(int userSeq);
	
	

}
