package com.accounting.data;


import java.util.ArrayList;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.Table;


@Entity
@Table(name = "customer")
public class Customer {
	
	@Id
	@Column(name = "customerID")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int customerID;
	
	private String firstName;
	private String lastName;
	private String mobilePhone;
	private String officePhone;
	private String email;
	private String address1;
	private String address2;
	private String city;
	private String dmvID;
	private String employerID;
	
	@OneToMany
	(mappedBy="customer")
	private List<Car> cars;
	
	private String categoryID;
	
	private String companyName;
	private int isTaxable;

	public int getCustomerID() {
		return customerID;
	}

	public void setCustomerID(int customerID) {
		this.customerID = customerID;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getMobilePhone() {
		return mobilePhone;
	}

	public void setMobilePhone(String mobilePhone) {
		this.mobilePhone = mobilePhone;
	}

	public String getOfficePhone() {
		return officePhone;
	}

	public void setOfficePhone(String officePhone) {
		this.officePhone = officePhone;
	}

	public String getCategoryID() {
		return categoryID;
	}

	public void setCategoryID(String categoryID) {
		this.categoryID = categoryID;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public List<Car> getCars() {
		return cars;
	}

	public void setCars(List<Car> cars) {
		this.cars = cars;
	}
	
	
	
	
	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	public int getIsTaxable() {
		return isTaxable;
	}

	public void setIsTaxable(int isTaxable) {
		this.isTaxable = isTaxable;
	}

	
	
	
	public String getAddress1() {
		return address1;
	}

	public void setAddress1(String address1) {
		this.address1 = address1;
	}

	public String getAddress2() {
		return address2;
	}

	public void setAddress2(String address2) {
		this.address2 = address2;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	
	
	public String getDmvID() {
		return dmvID;
	}

	public void setDmvID(String dmvID) {
		this.dmvID = dmvID;
	}

	public String getEmployerID() {
		return employerID;
	}

	public void setEmployerID(String employerID) {
		this.employerID = employerID;
	}

	public String toString() {
		
		String response="";
		
		response+="{";
		
		response+="\"customerID\":" + customerID;
		response+=",\"firstName\":\"" + firstName + "\"";
		response+=",\"lastName\":\"" + lastName + "\"";
		response+=",\"email\":\"" + email + "\"";
		response+=",\"mobilePhone\":\"" + mobilePhone + "\"";
		response+=",\"officePhone\":\"" + officePhone + "\"";
		response+=",\"companyName\":\"" + companyName + "\"";
		response+=",\"address1\":\"" + address1 + "\"";
		response+=",\"address2\":\"" + address2 + "\"";
		response+=",\"dmvID\":\"" + dmvID + "\"";
		response+=",\"employerID\":\"" + employerID + "\"";
		response+=",\"city\":\"" + city + "\"";
		response+=",\"isTaxable\":" + isTaxable;		
		response+=",\"cars\":[";
		
		System.out.println("CustomerID " + customerID + " has " + cars.size() + " cars ");
		
		for(int index=0;index<cars.size();index++) {
			
			if(index>0)response+=",";
			
			Car car=cars.get(index);
		
			response+="{\"carID\":" + car.getCarID();
			response+=",\"model\":\"" + car.getModel() + "\"";
			response+=",\"make\":\"" + car.getMake() + "\"";
			response+=",\"odoMeter\":\"" + car.getOdoMeter() + "\"";
			response+=",\"plateNo\":\"" + car.getPlateNo() + "\"}";

		}
		
		response+="]";
		
		response+="}";
		
		return response;
		
	}
	
	
	
	
	
}
