package com.accounting.data;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "productTax")
@Embeddable
public class ProductTax {

	@Id
	@Column(name = "productTaxID")
	@GeneratedValue(strategy = GenerationType.IDENTITY)		
	private int productTaxID;
	
	@ManyToOne
	@JoinColumn(name="productID")
	private Product product;
	
	@ManyToOne
	@JoinColumn(name="taxID")	
	private Tax tax;
	
	private int percentage;
	
	
	public Tax getTax() {
		return tax;
	}
	public void setTax(Tax tax) {
		this.tax = tax;
	}
	public int getPercentage() {
		return percentage;
	}
	public void setPercentage(int percentage) {
		this.percentage = percentage;
	}
	public Product getProduct() {
		return product;
	}
	public void setProduct(Product product) {
		this.product = product;
	}
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
	
	
	
}
