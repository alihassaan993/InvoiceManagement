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
import com.accounting.data.Invoice;


@Entity
@Table(name = "invoice_product")
public class InvoiceProduct {

	@Id
	@Column(name = "invoiceProductID")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int invoiceProductID;
	private float price;
	private int discount;
	private float amount;
	private int quantity;
	
	
	@ManyToOne
	@JoinColumn(name="invoiceID",nullable=false)
	private Invoice invoice;
	
	@ManyToOne
	@JoinColumn(name="productID",nullable=false)
	private Product product;
	
	public int getInvoiceProductID() {
		return invoiceProductID;
	}
	public void setInvoiceProductID(int invoiceProductID) {
		this.invoiceProductID = invoiceProductID;
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
	public Invoice getInvoice() {
		return invoice;
	}
	public void setInvoice(Invoice invoice) {
		this.invoice = invoice;
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