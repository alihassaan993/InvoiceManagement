package com.accounting.data;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "tax")
public class Tax {
	
	@Id
	@Column(name = "taxID")
	@GeneratedValue(strategy = GenerationType.IDENTITY)	
	private int taxID;
	private String taxName;
	private float percentage;
	

	@OneToMany(mappedBy="tax")
	private List<ProductTax> prodTax;
	
	
	
	public List<ProductTax> getProdTax() {
		return prodTax;
	}
	public void setProdTax(List<ProductTax> prodTax) {
		this.prodTax = prodTax;
	}
	public int getTaxID() {
		return taxID;
	}
	public void setTaxID(int taxID) {
		this.taxID = taxID;
	}
	public String getTaxName() {
		return taxName;
	}
	public void setTaxName(String taxName) {
		this.taxName = taxName;
	}
	public float getPercentage() {
		return percentage;
	}
	public void setPercentage(int percentage) {
		this.percentage = percentage;
	}

	public String toString() {
		
		String response="{";
		
		response+="\"taxID\":"+taxID + ",";
		response+="\"taxName\":\""+taxName + "\",";
		response+="\"percentage\":"+percentage;
		
		response+="}";
		
		return response;
	}
	
}
