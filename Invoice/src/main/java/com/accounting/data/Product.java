package com.accounting.data;

import java.util.List;
import java.util.Map;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.Table;	
import javax.persistence.JoinColumn;

@Entity
@Table(name = "product")
public class Product {
	

	@Id
	@Column(name = "productID")
	@GeneratedValue(strategy = GenerationType.IDENTITY)		
	private int productID;
	private String productName;
	private String description;
	private int cost;
	private int price;
	
	@OneToMany(mappedBy = "product")
	private List<ProductTax> taxID;

	public List<ProductTax> getTaxID() {
		return taxID;
	}
	public void setTaxID(List<ProductTax> taxID) {
		this.taxID = taxID;
	}
	public int getProductID() {
		return productID;
	}
	public void setProductID(int productID) {
		this.productID = productID;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public int getCost() {
		return cost;
	}
	public void setCost(int cost) {
		this.cost = cost;
	}
	public void setCost(String _cost) {
		this.cost=Integer.parseInt(_cost);
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	
	public void setPrice(String _price) {
		this.price=Integer.parseInt(_price);
	}

	
	public String toString() {
		
		String response="";
		
		response+="{";
		response+="\"productID\":" + productID + ",";
		response+="\"productName\":\"" + productName + "\",";
		response+="\"description\":\"" + description + "\",";
		response+="\"price\":" + price + ",";
		response+="\"cost\":" + cost + ",";
		response+="\"taxIDs\":[";
		for(int index=0;index<taxID.size();index++) {
			if(index>0)
        		response+=",";
			
			response+=taxID.get(index).getTax().toString();
					
		}
		response+="]";
		
		response+="}";
		
		return response;
		
	}
	
}
