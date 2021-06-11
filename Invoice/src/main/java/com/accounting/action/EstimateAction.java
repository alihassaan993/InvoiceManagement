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
		List<Estimate> results = null;
		String response="";
		
		try {
			String hql = "FROM Estimate";
	        Query query = session.createQuery(hql);
	        results = query.getResultList();
	        
	        response="[";
	        
	        for(int index=0;index<results.size();index++) {
	        	if(index>0)
	        		response+=",";
	        		       	
	        	Estimate _prod=results.get(index);
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

	public String fetch(int estimateID) throws Exception{
		
		Session session = HibernateUtil.getSessionFactory().openSession();
		//List<Estimate> results = null;
		String response="";
		
		try {
//			String hql = "FROM Estimate";
//	        Query query = session.createQuery(hql);
//	        results = query.getResultList();
//	        
	        Estimate estimate=session.get(Estimate.class, estimateID);
	        
	        response=estimate.toString();
	        
	        
	        
		}catch(Exception err) {
			err.printStackTrace();
		}finally {
			session.close(); 
		}
        return response;
	}	
	
	public String create(Estimate estimate) {
		
		Session session = HibernateUtil.getSessionFactory().openSession();
		String response="2";
		
		try {
			
			session.beginTransaction();
			
		    Query q = session.createQuery("select max(estimateID) from Estimate"); 

		    Integer estimateID = (Integer)q.uniqueResult();
		    
		    String estimateNo = "EST" + String.format("%05d" , estimateID.intValue());
		    
		    estimate.setEstimateNo(estimateNo);
		    
			session.save(estimate.getCar());
			
			session.save(estimate);
			
			List<EstimateProduct> estimateProducts = estimate.getEstimateProducts();
			
			for(int index=0;index<estimateProducts.size();index++) {
				
				EstimateProduct estimateProduct=(EstimateProduct)estimateProducts.get(index);
				estimateProduct.setEstimate(estimate);
				session.save(estimateProduct);
				
			}
			
			session.getTransaction().commit();
			
			response="1";
			
		}catch(Exception err) {
			session.getTransaction().rollback();
			err.printStackTrace();
			
		}finally {
			
			session.close();
			
		}
		
		return response;
	}

}
