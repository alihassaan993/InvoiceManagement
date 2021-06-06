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

public class EstimateAction {
	
	protected static SessionFactory sessionFactory;
	
	public String fetch() throws Exception{
		
		Session session = HibernateUtil.getSessionFactory().openSession();
		
		String hql = "FROM Customer";
        Query query = session.createQuery(hql);
        List<Customer> results = query.getResultList();
        session.close();       
		
        return new Gson().toJson(results);
	}	

}
