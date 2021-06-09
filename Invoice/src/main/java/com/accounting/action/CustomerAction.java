package com.accounting.action;


import java.util.ArrayList;
import java.util.List;


import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

import com.accounting.data.Customer;
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
		
		try {
			String hql = "FROM Customer";
	        Query query = session.createQuery(hql);
	        results = query.getResultList();
		}catch(Exception err) {
			err.printStackTrace();
		}finally {
			session.close(); 
		}
        
//        String response="{ \"data\":[";
//        
//        for(int index=0;index<results.size();index++) {
//        	if(index>0)
//        		response+=",";
//        		
//        	response+="[";
//        	Customer _customer=results.get(index);
//        	response+="\""+_customer.getFirstName() + "\"" + ",";
//        	response+="\"" + _customer.getLastName() + "\"" + ",";
//        	response+="\"" + _customer.getEmail() + "\"" + ",";
//        	response+="\"" + _customer.getMobilePhone() + "\"" + ",";
//        	response+="\" <button>Edit</button> \"" + "]";
//        	
//        }
//        
//        response+="]}";
        return new Gson().toJson(results);
        
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
