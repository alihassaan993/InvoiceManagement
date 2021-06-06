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
import javax.persistence.Table;


@Entity
@Table(name = "estimate")
public class Estimate {
	
	private int estimateID;
	private Date creationDate;
	private String status;
	private String estimateNo;
	
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
	
	
	

}
