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
		
		String hql = "FROM Customer";
        Query query = session.createQuery(hql);
        List<Customer> results = query.getResultList();
        session.close();       
        
        String response="{ \"data\":[";
        
        for(int index=0;index<results.size();index++) {
        	if(index>0)
        		response+=",";
        		
        	response+="[";
        	Customer _customer=results.get(index);
        	response+="\""+_customer.getCustomerName() + "\"" + ",";
        	response+="\"" + _customer.getEmail() + "\"" + ",";
        	response+="\"" + _customer.getAddress() + "\"" + ",";
        	response+="\"" + _customer.getCategoryID() + "\"" + ",";
        	response+="\" <button>Edit</button> \"" + "]";
        	
        }
        
        response+="]}";
        return response;
        
	}
	
	public void create() throws Exception {
		
		Session session = HibernateUtil.getSessionFactory().openSession();
		
		Customer customer=new Customer();
		customer.setCustomerName("Ali Hassaan");
		customer.setEmail("alihassaan@gmail.com");
		customer.setAddress("Muscat");
		customer.setCategoryID(1);
		
		Car car1=new Car();
		car1.setModel("Ford Explorer");
		car1.setMake("2010");
		car1.setPlateNo("Y 58602");
		
		Car car2=new Car();
		car2.setModel("Ford Edge");
		car2.setMake("2010");
		car2.setPlateNo("Y 1232");
		
		try {
			session.beginTransaction();
	    	
	    	session.save(customer);
	    	
	    	car1.setCustomerID(customer.getCustomerID());
	    	car2.setCustomerID(customer.getCustomerID());
	    	
	    	session.save(car1);
	    	session.save(car2);
	    	
	    	session.getTransaction().commit();
		}catch(Exception err) {
			err.printStackTrace();
		}finally {
			session.close();
		}
		
	}

}
