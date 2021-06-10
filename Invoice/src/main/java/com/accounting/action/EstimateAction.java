package com.accounting.action;

import java.util.ArrayList;
import java.util.List;


import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

import com.accounting.data.Customer;
import com.accounting.data.Product;
import com.accounting.data.Estimate;
import com.accounting.data.EstimateProduct;
import com.accounting.util.HibernateUtil;
import com.google.gson.Gson;

public class EstimateAction {
	
	protected static SessionFactory sessionFactory;
	
	public String fetch() throws Exception{
		
		Session session = HibernateUtil.getSessionFactory().openSession();
		List<Customer> results = null;
		
		try {
			String hql = "FROM Estimate";
	        Query query = session.createQuery(hql);
	        results = query.getResultList();
	              
		}catch(Exception err) {
			err.printStackTrace();
		}finally {
			session.close(); 
		}
        return new Gson().toJson(results);
	}	
	
	public String create(Estimate estimate) {
		
		Session session = HibernateUtil.getSessionFactory().openSession();
		
		try {
			
			session.beginTransaction();
			
			session.save(estimate.getCar());
			
			session.save(estimate);
			
			List<EstimateProduct> estimateProducts = estimate.getEstimateProducts();
			
			for(int index=0;index<estimateProducts.size();index++) {
				
				EstimateProduct estimateProduct=(EstimateProduct)estimateProducts.get(index);
				estimateProduct.setEstimate(estimate);
				session.save(estimateProduct);
				
			}
			
			session.getTransaction().commit();
			
		}catch(Exception err) {
			session.getTransaction().rollback();
			err.printStackTrace();
			
		}finally {
			
			session.close();
			
		}
		
		return "Error";
	}

}
