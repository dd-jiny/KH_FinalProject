package com.phoenix.carrot.order.dto;

import java.util.Date;

public class OrderDto {
	
	private int orderSeq;
	private int productSeq;
	private String productName;
	private int productPrice;
	private int quantity;
	private int orderAmount;
	private String paymethod;
	private int userSeq;
	private String userId;
	private String receiveName;
	private String receiverPhone;
	private String receiverOaddress;
	private String receiverRaddress;
	private String receiverDetailaddress;
	private Date orderDate;
	
	public OrderDto() {
	}

	public OrderDto(int orderSeq, int productSeq, String productName, int productPrice, int quantity, int deliveryfee,
			int orderAmount, String paymethod, int userSeq, String userId, String receiveName, String receiverPhone,
			String receiverOaddress, String receiverRaddress, String receiverDetailaddress, Date orderDate) {
		super();
		this.orderSeq = orderSeq;
		this.productSeq = productSeq;
		this.productName = productName;
		this.productPrice = productPrice;
		this.quantity = quantity;
		this.orderAmount = orderAmount;
		this.paymethod = paymethod;
		this.userSeq = userSeq;
		this.userId = userId;
		this.receiveName = receiveName;
		this.receiverPhone = receiverPhone;
		this.receiverOaddress = receiverOaddress;
		this.receiverRaddress = receiverRaddress;
		this.receiverDetailaddress = receiverDetailaddress;
		this.orderDate = orderDate;
	}

	public int getOrderSeq() {
		return orderSeq;
	}

	public void setOrderSeq(int orderSeq) {
		this.orderSeq = orderSeq;
	}

	public int getProductSeq() {
		return productSeq;
	}

	public void setProductSeq(int productSeq) {
		this.productSeq = productSeq;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public int getProductPrice() {
		return productPrice;
	}

	public void setProductPrice(int productPrice) {
		this.productPrice = productPrice;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}


	public int getOrderAmount() {
		return orderAmount;
	}

	public void setOrderAmount(int orderAmount) {
		this.orderAmount = orderAmount;
	}

	public String getPaymethod() {
		return paymethod;
	}

	public void setPaymethod(String paymethod) {
		this.paymethod = paymethod;
	}

	public int getUserSeq() {
		return userSeq;
	}

	public void setUserSeq(int userSeq) {
		this.userSeq = userSeq;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getReceiveName() {
		return receiveName;
	}

	public void setReceiveName(String receiveName) {
		this.receiveName = receiveName;
	}

	public String getReceiverPhone() {
		return receiverPhone;
	}

	public void setReceiverPhone(String receiverPhone) {
		this.receiverPhone = receiverPhone;
	}

	public String getReceiverOaddress() {
		return receiverOaddress;
	}

	public void setReceiverOaddress(String receiverOaddress) {
		this.receiverOaddress = receiverOaddress;
	}

	public String getReceiverRaddress() {
		return receiverRaddress;
	}

	public void setReceiverRaddress(String receiverRaddress) {
		this.receiverRaddress = receiverRaddress;
	}

	public String getReceiverDetailaddress() {
		return receiverDetailaddress;
	}

	public void setReceiverDetailaddress(String receiverDetailaddress) {
		this.receiverDetailaddress = receiverDetailaddress;
	}

	public Date getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}

	@Override
	public String toString() {
		return "OrderDto [orderSeq=" + orderSeq + ", productSeq=" + productSeq + ", productName=" + productName
				+ ", productPrice=" + productPrice + ", quantity=" + quantity + ", orderAmount=" + orderAmount
				+ ", paymethod=" + paymethod + ", userSeq=" + userSeq + ", userId=" + userId + ", receiveName="
				+ receiveName + ", receiverPhone=" + receiverPhone + ", receiverOaddress=" + receiverOaddress
				+ ", receiverRaddress=" + receiverRaddress + ", receiverDetailaddress=" + receiverDetailaddress
				+ ", orderDate=" + orderDate + "]";
	}	
	
	
	

}
