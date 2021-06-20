package com.accounting.action;


import java.util.ArrayList;
import java.util.List;


import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

import com.accounting.data.Customer;
import com.accounting.data.Estimate;
import com.accounting.data.Product;
import com.accounting.data.User;
import com.accounting.data.AuditLog;
import com.accounting.data.Car;
import com.accounting.util.HibernateUtil;
import com.accounting.util.Logger;
import com.google.gson.Gson;

//import com.google.gson.*;

public class CustomerAction {
	
	
	protected static SessionFactory sessionFactory;
	
	public String fetch() throws Exception{

		Session session = HibernateUtil.getSessionFactory().openSession();
		List<Customer> results=null;
		String response="";
		try {
			String hql = "FROM Customer";
	        Query query = session.createQuery(hql);
	        results = query.getResultList();

	        response="[";
	        
	        for(int index=0;index<results.size();index++) {
	        	if(index>0)
	        		response+=",";
	        		       	
	        	Customer _prod=results.get(index);
	        	response+=_prod.toString();
	        }
	        
	        response+="]";		
		
		}catch(Exception err) {
			err.printStackTrace();
		}finally {
			session.close(); 
		}

        return response;
        
	}
	
	public String fetch(int customerID) throws Exception{

		Session session = HibernateUtil.getSessionFactory().openSession();
		List<Customer> results=null;
		String response="";
		try {
			
			Customer customer=session.get(Customer.class, customerID);
			
	        //response="{";
	        
	        response+=customer.toString();
	        
	        //response+="}";		
	        
		
		}catch(Exception err) {
			err.printStackTrace();
		}finally {
			session.close(); 
		}

        return response;
        
	}
	
	public void update(Customer customer) {
		Session session = HibernateUtil.getSessionFactory().openSession();
		
		try {
			
			session.beginTransaction();
			
			session.update(customer);

	    	///////////////////////////////////
	    	AuditLog auditLog=new AuditLog();
	    	auditLog.setDetails("Updated Customer with Customer ID "+ customer.getCustomerID());
	    	User user=new User();
	    	user.setUserID(customer.getCreatedBy());
	    	auditLog.setUser(user);
	    	Logger.log(auditLog);
	    	///////////////////////////////////			
			
			session.getTransaction().commit();
			
		}catch(Exception err) {
			err.printStackTrace();
			session.getTransaction().rollback();
		}finally {
			session.close();
		}
	}
	
	
	public void create(Customer customer) throws Exception {
		
		Session session = HibernateUtil.getSessionFactory().openSession();
		
		try {
			session.beginTransaction();
	    	
	    	session.save(customer);
	    	
	    	///////////////////////////////////
	    	AuditLog auditLog=new AuditLog();
	    	auditLog.setDetails("Create New Customer with CustomerID "+ customer.getCustomerID());
	    	User user=new User();
	    	user.setUserID(customer.getCreatedBy());
	    	auditLog.setUser(user);
	    	Logger.log(auditLog);
	    	///////////////////////////////////
	    	
	    	session.getTransaction().commit();
	    	
		}catch(Exception err) {
			err.printStackTrace();
		}finally {
			session.close();
		}
		
	}

}
