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
@Table(name = "car")
public class Car {

	@Id
	@Column(name = "carID")
	@GeneratedValue(strategy = GenerationType.IDENTITY)	
	private int carID;
	private String model;
	private String plateNo;
	//private String color;
	private String make;
	
	private String odoMeter;
	
	private String year;
	
	@ManyToOne
	@JoinColumn(name="customerID",nullable=false)
	private Customer customer;
	
	public String getOdoMeter() {
		return odoMeter;
	}
	public void setOdoMeter(String odoMeter) {
		this.odoMeter = odoMeter;
	}
	public int getCarID() {
		return carID;
	}
	public void setCarID(int carID) {
		this.carID = carID;
	}
	public String getModel() {
		return model;
	}
	public void setModel(String model) {
		this.model = model;
	}
	public String getPlateNo() {
		return plateNo;
	}
	public void setPlateNo(String plateNo) {
		this.plateNo = plateNo;
	}
//	public String getColor() {
//		return color;
//	}
//	public void setColor(String color) {
//		this.color = color;
//	}
	public String getMake() {
		return make;
	}
	public void setMake(String make) {
		this.make = make;
	}
//	public int getCustomerID() {
//		return customerID;
//	}
//	public void setCustomerID(int customerID) {
//		this.customerID = customerID;
//	}
	public Customer getCustomer() {
		return customer;
	}
	public void setCustomer(Customer customer) {
		this.customer = customer;
	}
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}

	
	
}
