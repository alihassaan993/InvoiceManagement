package com.accounting.action;


import java.util.ArrayList;
import java.util.List;

import javax.transaction.Transactional;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

import com.accounting.data.Product;
import com.accounting.data.ProductTax;
import com.accounting.util.HibernateUtil;
import com.google.gson.Gson;

//import com.google.gson.*;

public class ProductAction {
	
	//public Customer fetch() throws Exception
	
	public String fetch(Product product) throws Exception{

		Session session = HibernateUtil.getSessionFactory().openSession();
		
		Product _product=new Product();
		try {
       
		_product=session.get(Product.class, product.getProductID());
		}catch(Exception err) {
			err.printStackTrace();
		}finally {
	        session.close();
		}
        

        return new Gson().toJson(_product);
		
	}

	public String fetch() throws Exception{

		Session session = HibernateUtil.getSessionFactory().openSession();
		String response="[";
		
		try {
			String hql = "FROM Product";
	        Query query = session.createQuery(hql);
	        List<Product> results = query.getResultList();
	        //String _response=new Gson().toJson(results);
	
	       
	        
	        for(int index=0;index<results.size();index++) {
	        	if(index>0)
	        		response+=",";
	        		       	
	        	Product _prod=results.get(index);
	        	response+=_prod.toString();
	        }
	        
	        response+="]";
	        
	        System.out.println(response);
        

		}catch(Exception err) {
			err.printStackTrace();
		}finally {
			session.close();	
		}
        
        return response;
		
	}
	
	public void create(Product product) throws Exception {
		
		Session session = HibernateUtil.getSessionFactory().openSession();
		
		try {
			
			session.beginTransaction();
			
			session.save(product);
			
//			List<ProductTax> taxIDs=product.getTaxID();
//			
//			for(int index=0;index<taxIDs.size();index++)			
//			{	
//				ProductTax prodTax=taxIDs.get(index);
//				prodTax.setProduct(product);
//				session.save(prodTax);
//			}
			session.getTransaction().commit();
			
		}catch(Exception err) {
			err.printStackTrace();
			session.getTransaction().rollback();
		}finally {
			session.close();
		}
		
	}
	
	public String fetch(int productID) throws Exception{

		Session session = HibernateUtil.getSessionFactory().openSession();
		String response="";
		
		Product _product=new Product();
		try {
       
		_product=session.get(Product.class, productID);
		response=_product.toString();
		
		}catch(Exception err) {
			err.printStackTrace();
		}finally {
	        session.close();
		}
        

        return response;
		
	}
	
	public String update(Product product) {
		
		System.out.println("Updating Product");

		Session session = HibernateUtil.getSessionFactory().openSession();
		String response="Success";
		try {
			
			session.beginTransaction();
			
			session.update(product);
			
			session.getTransaction().commit();
			
		}catch(Exception err) {
			response="Error";
			session.getTransaction().rollback();
		}finally {
			session.close();
		}
		return response;
	}
	

}
