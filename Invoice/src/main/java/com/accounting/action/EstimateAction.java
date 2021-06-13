package com.accounting.action;

import java.util.ArrayList;
import java.util.List;


import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

import com.accounting.data.Car;
import com.accounting.data.Customer;
import com.accounting.data.Product;
import com.accounting.data.Estimate;
import com.accounting.data.EstimateProduct;
import com.accounting.data.Invoice;
import com.accounting.data.InvoiceProduct;
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
		    
		    Car car=estimate.getCar();
		    car.setCustomer(estimate.getCustomer());
		    
			session.save(car);
			
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
	
	public String generateInvoice(int estimateID) {
		
		Session session = HibernateUtil.getSessionFactory().openSession();
		String response="2";
		session.beginTransaction();
		try {
			
			Estimate estimate=session.get(Estimate.class, estimateID);
			
			Invoice invoice=new Invoice();
			
			Query q = session.createQuery("select max(invoiceID) from Invoice"); 

		    Integer invoiceID = (Integer)q.uniqueResult();
		    
		    String invoiceNo = "INV" + String.format("%05d" , invoiceID.intValue()+1);
		    
		    invoice.setInvoiceNo(invoiceNo);			
			

			
			invoice.setCaliforniaTax(estimate.getCaliforniaTax());
			invoice.setCar(estimate.getCar());
			invoice.setCustomer(estimate.getCustomer());
			invoice.setLabourCost(estimate.getLabourCost());
			invoice.setRecyclingCharges(estimate.getRecyclingCharges());
			invoice.setSalesTax(estimate.getSalesTax());
			
			session.save(invoice);
			
			response="{\"result\":\"Success\",\"invoiceID\":"+ invoice.getInvoiceID() +"}";
			
			//List<InvoiceProduct> invoiceProducts=new ArrayList<>();
			
			for(int index=0;index<estimate.getEstimateProducts().size();index++) {
				
				EstimateProduct estimateProduct=estimate.getEstimateProducts().get(index);
				
				InvoiceProduct invoiceProduct=new InvoiceProduct();
				invoiceProduct.setAmount(estimateProduct.getAmount());
				invoiceProduct.setPrice(estimateProduct.getPrice());
				invoiceProduct.setProduct(estimateProduct.getProduct());
				invoiceProduct.setQuantity(invoiceProduct.getQuantity());
				invoiceProduct.setInvoice(invoice);
				//invoiceProducts.add(invoiceProduct);
				
				session.save(invoiceProduct);
				//response="1";
				
			}
			
			session.getTransaction().commit();
			//invoice.setInvoiceProducts(invoiceProducts);
			
		}catch(Exception err) {
			response="{\"result\":\"Error\"}";
			err.printStackTrace();
			session.getTransaction().rollback();
		}finally {
			session.close();
		}
		return response;
	}

}
