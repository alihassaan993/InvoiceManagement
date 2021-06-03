package com.accounting.data;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "productTax")
public class ProductTax {

	@Id
	@Column(name = "productTaxID")
	@GeneratedValue(strategy = GenerationType.IDENTITY)		
	private int productTaxID;
	
	@ManyToOne
	@JoinColumn(name="productID",nullable=false)
	private Product product;
	
	
	
	
	public Product getProduct() {
		return product;
	}
	public void setProduct(Product product) {
		this.product = product;
	}
	private int taxID;
	public int getProductTaxID() {
		return productTaxID;
	}
	public void setProductTaxID(int productTaxID) {
		this.productTaxID = productTaxID;
	}
	public Product getProductID() {
		return product;
	}
	public void setProductID(Product productID) {
		this.product = productID;
	}
	public int getTaxID() {
		return taxID;
	}
	public void setTaxID(int taxID) {
		this.taxID = taxID;
	}
	
	
	
}
