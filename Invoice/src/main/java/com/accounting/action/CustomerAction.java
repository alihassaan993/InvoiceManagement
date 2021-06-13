package com.accounting.action;


import java.util.ArrayList;
import java.util.List;


import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

import com.accounting.data.Customer;
import com.accounting.data.Estimate;
import com.accounting.data.Product;
import com.accounting.data.Car;
import com.accounting.util.HibernateUtil;
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
	
	public void create(Customer customer) throws Exception {
		
		Session session = HibernateUtil.getSessionFactory().openSession();
		
		try {
			session.beginTransaction();
	    	
	    	session.save(customer);
	    	
	    	session.getTransaction().commit();
		}catch(Exception err) {
			err.printStackTrace();
		}finally {
			session.close();
		}
		
	}

}
