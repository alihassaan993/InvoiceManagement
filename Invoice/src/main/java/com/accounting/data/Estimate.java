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

import org.hibernate.annotations.CreationTimestamp;


@Entity
@Table(name = "estimate")
public class Estimate {
	@Id
	@Column(name = "estimateID")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int estimateID;
	
	@CreationTimestamp
	private Date creationDate;
	private String status;
	private String estimateNo;
	private float salesTax;
	private float californiaTax;
	private float labourCost;
	private float recyclingCharges;
	private float totalAmount;
	
    @OneToOne
    @JoinColumn(name = "carID")
	private Car car;
	
	@ManyToOne
	@JoinColumn(name="customerID",nullable=false)
	private Customer customer;
	
	@OneToMany (mappedBy="estimate")
	private List<EstimateProduct> estimateProducts;

	public int getEstimateID() {
		return estimateID;
	}

	public void setEstimateID(int estimateID) {
		this.estimateID = estimateID;
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

	public String getEstimateNo() {
		return estimateNo;
	}

	public void setEstimateNo(String estimateNo) {
		this.estimateNo = estimateNo;
	}

	public Customer getCustomer() {
		return customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}

	public List<EstimateProduct> getEstimateProducts() {
		return estimateProducts;
	}

	public void setEstimateProducts(List<EstimateProduct> estimateProducts) {
		this.estimateProducts = estimateProducts;
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
	
	public String toString() {
		
		String response="";
		
		response+="{";
		response+="\"estimateID\":" + estimateID + ",";
		response+="\"creationDate\":\"" + creationDate + "\",";
		response+="\"customerName\":\"" + customer.getFirstName() + " " + customer.getLastName() + "\",";
		response+="\"mobilePhone\":\"" + customer.getMobilePhone()+ "\",";
		response+="\"email\":\"" + customer.getEmail()+ "\",";
		response+="\"estimateNo\":\"" + estimateNo + "\",";
		response+="\"billingAddress\":\"" + customer.getAddress1()+ "<br>" + customer.getAddress2() + "<br>" + customer.getCity() + "\",";
		
		response+="\"totalAmount\":" + totalAmount + ",";
		response+="\"salesTax\":" + salesTax + ",";
		response+="\"californiaTax\":" + californiaTax + ",";
		response+="\"labourCost\":" + labourCost + ",";
		response+="\"recyclingCharges\":" + recyclingCharges + ",";
		
		response+="\"estimateProducts\":[";
		
		for(int index=0;index<estimateProducts.size();index++) {
			EstimateProduct estimateProduct=estimateProducts.get(index);
			if(index>0) response+=",";
			
			Product product=estimateProduct.getProduct();
			response+="{";
			response+="\"productName\": \"" + product.getProductName() + "\","; 
			response+="\"description\": \"" + product.getDescription() + "\",";
			response+="\"quantity\": " + estimateProduct.getQuantity() + ",";
			response+="\"price\": " + estimateProduct.getPrice() + ",";
			response+="\"amount\": " + estimateProduct.getAmount();
			response+="}";
					
		}
		
		response+="]";
		
		
		response+="}";
		
		return response;		
		
	}
	
	

}
