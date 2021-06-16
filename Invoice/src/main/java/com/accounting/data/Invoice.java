package com.accounting.data;


import java.sql.Date;
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
import javax.persistence.OneToOne;
import javax.persistence.Table;

import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.CreationTimestamp;


@Entity
@Table(name = "invoice")
public class Invoice {
	@Id
	@Column(name = "invoiceID")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int invoiceID;
	
	@CreationTimestamp
	private Date creationDate;
	
	@ColumnDefault("Not Paid")
	private String status;
	private String invoiceNo;
	private float salesTax;
	private float californiaTax;
	private float labourCost;
	private float recyclingCharges;
	private float totalAmount;
	private String paymentMethod;
	private String remarks;
	
    @OneToOne
    @JoinColumn(name = "carID")
	private Car car;
	
	@ManyToOne
	@JoinColumn(name="customerID",nullable=false)
	private Customer customer;
	
	@OneToMany (mappedBy="invoice")
	private List<InvoiceProduct> invoiceProducts;

	public int getInvoiceID() {
		return invoiceID;
	}

	public void setInvoiceID(int invoiceID) {
		this.invoiceID = invoiceID;
	}

	public Date getCreationDate() {
		return creationDate;
	}

	public void setCreationDate(Date creationDate) {
		this.creationDate = creationDate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getInvoiceNo() {
		return invoiceNo;
	}

	public void setInvoiceNo(String invoiceNo) {
		this.invoiceNo = invoiceNo;
	}

	public Customer getCustomer() {
		return customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}

	public List<InvoiceProduct> getInvoiceProducts() {
		return invoiceProducts;
	}

	public void setInvoiceProducts(List<InvoiceProduct> invoiceProducts) {
		this.invoiceProducts = invoiceProducts;
	}

	public float getSalesTax() {
		return salesTax;
	}

	public void setSalesTax(float salesTax) {
		this.salesTax = salesTax;
	}

	public float getCaliforniaTax() {
		return californiaTax;
	}

	public void setCaliforniaTax(float californiaTax) {
		this.californiaTax = californiaTax;
	}

	public float getLabourCost() {
		return labourCost;
	}

	public void setLabourCost(float labourCost) {
		this.labourCost = labourCost;
	}

	public float getRecyclingCharges() {
		return recyclingCharges;
	}

	public void setRecyclingCharges(float recyclingCharges) {
		this.recyclingCharges = recyclingCharges;
	}

	public float getTotalAmount() {
		return totalAmount;
	}

	public void setTotalAmount(float totalAmount) {
		this.totalAmount = totalAmount;
	}

	public Car getCar() {
		return car;
	}

	public void setCar(Car car) {
		this.car = car;
	}
	
	
	
	public String getPaymentMethod() {
		return paymentMethod;
	}

	public void setPaymentMethod(String paymentMethod) {
		this.paymentMethod = paymentMethod;
	}
	
	
	

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public String toString() {
		
		String response="";
		
		response+="{";
		response+="\"invoiceID\":" + invoiceID + ",";
		response+="\"creationDate\":\"" + creationDate + "\",";
		response+="\"customerName\":\"" + customer.getFirstName() + " " + customer.getLastName() + "\",";
		response+="\"mobilePhone\":\"" + customer.getMobilePhone()+ "\",";
		response+="\"email\":\"" + customer.getEmail()+ "\",";
		response+="\"invoiceNo\":\"" + invoiceNo + "\",";
		response+="\"paymentMethod\":\"" + paymentMethod + "\",";
		response+="\"billingAddress\":\"" + customer.getAddress1()+ "<br>" + customer.getAddress2() + "<br>" + customer.getCity() + "\",";
		
		response+="\"status\":\"" + status + "\",";
		response+="\"totalAmount\":" + totalAmount + ",";
		response+="\"salesTax\":" + salesTax + ",";
		response+="\"californiaTax\":" + californiaTax + ",";
		response+="\"labourCost\":" + labourCost + ",";
		response+="\"recyclingCharges\":" + recyclingCharges + ",";
		response+="\"remarks\":\"" + remarks + "\",";
		
		response+="\"invoiceProducts\":[";
		
		for(int index=0;index<invoiceProducts.size();index++) {
			InvoiceProduct invoiceProduct=invoiceProducts.get(index);
			if(index>0) response+=",";
			
			Product product=invoiceProduct.getProduct();
			response+="{";
			response+="\"productName\": \"" + product.getProductName() + "\","; 
			response+="\"description\": \"" + product.getDescription() + "\",";
			response+="\"quantity\": " + invoiceProduct.getQuantity() + ",";
			response+="\"price\": " + invoiceProduct.getPrice() + ",";
			response+="\"amount\": " + invoiceProduct.getAmount();
			response+="}";
					
		}
		
		response+="]";
		
		
		response+="}";
		
		return response;		
		
	}
	
	

}
