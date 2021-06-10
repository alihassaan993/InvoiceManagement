package com.accounting.data;


import java.util.ArrayList;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.accounting.data.Customer;
import com.accounting.data.Estimate;


@Entity
@Table(name = "estimate_product")
public class EstimateProduct {

	@Id
	@Column(name = "estimateProductID")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int estimateProductID;
	private float price;
	private int discount;
	private float amount;
	private int quantity;
	
	
	@ManyToOne
	@JoinColumn(name="estimateID",nullable=false)
	private Estimate estimate;
	
	@ManyToOne
	@JoinColumn(name="productID",nullable=false)
	private Product product;
	
	public int getEstimateProductID() {
		return estimateProductID;
	}
	public void setEstimateProductID(int estimateProductID) {
		this.estimateProductID = estimateProductID;
	}
	public float getPrice() {
		return price;
	}
	public void setPrice(float price) {
		this.price = price;
	}
	public int getDiscount() {
		return discount;
	}
	public void setDiscount(int discount) {
		this.discount = discount;
	}
	public Estimate getEstimate() {
		return estimate;
	}
	public void setEstimate(Estimate estimate) {
		this.estimate = estimate;
	}
	public float getAmount() {
		return amount;
	}
	public void setAmount(float amount) {
		this.amount = amount;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public Product getProduct() {
		return product;
	}
	public void setProduct(Product product) {
		this.product = product;
	}

	
	

}