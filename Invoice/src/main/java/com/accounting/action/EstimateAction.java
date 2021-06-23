package com.accounting.action;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.NoResultException;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

import com.accounting.data.AuditLog;
import com.accounting.data.Car;
import com.accounting.data.Customer;
import com.accounting.data.Product;
import com.accounting.data.User;
import com.accounting.data.Estimate;
import com.accounting.data.EstimateProduct;
import com.accounting.data.Invoice;
import com.accounting.data.InvoiceProduct;
import com.accounting.util.HibernateUtil;
import com.accounting.util.Logger;
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
		    
		    String estimateNo="";
		    
		    try {
		    
		    	estimateNo = "EST" + String.format("%05d" , estimateID.intValue());
		    
		    }catch(NullPointerException err) {
		    	
		    	estimateNo="EST000001";
		    }
		    
		    estimate.setEstimateNo(estimateNo);
		    
		    Car car=estimate.getCar();
		    car.setCustomer(estimate.getCustomer());
		    Query q2=session.createQuery("from Car c where c.plateNo=:plate_no");
		    q2.setParameter("plate_no", car.getPlateNo());
		    Car _car=null;
		    try {
		    	_car = (Car)q2.setMaxResults(1).uniqueResult();
		    	if(_car==null) throw new NoResultException();
		    	car.setCarID(_car.getCarID());
		    	session.clear();
		    	session.update(car);
		    }catch (NoResultException err){
		    	session.save(car);
		    }
			
			session.save(estimate);
			
			List<EstimateProduct> estimateProducts = estimate.getEstimateProducts();
			
			for(int index=0;index<estimateProducts.size();index++) {
				
				EstimateProduct estimateProduct=(EstimateProduct)estimateProducts.get(index);
				estimateProduct.setEstimate(estimate);
				session.save(estimateProduct);
				
			}
			
	    	///////////////////////////////////
	    	AuditLog auditLog=new AuditLog();
	    	auditLog.setDetails("Add estimate number "+ estimate.getEstimateNo());
	    	User user=new User();
	    	user.setUserID(estimate.getCreatedBy());
	    	auditLog.setUser(user);
	    	Logger.log(auditLog);
	    	///////////////////////////////////	
			
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
		    
		    String invoiceNo="";
		    
		    try {
		    
		    	invoiceNo = "INV" + String.format("%05d" , invoiceID.intValue()+1);
		    
		    }catch(NullPointerException err) {
		    	invoiceNo="INV000001";
		    }
		    
		    invoice.setInvoiceNo(invoiceNo);			
			

			
			invoice.setCaliforniaTax(estimate.getCaliforniaTax());
			invoice.setCar(estimate.getCar());
			invoice.setCustomer(estimate.getCustomer());
			invoice.setLabourCost(estimate.getLabourCost());
			invoice.setRecyclingCharges(estimate.getRecyclingCharges());
			invoice.setSalesTax(estimate.getSalesTax());
			invoice.setTotalAmount(estimate.getTotalAmount());
			invoice.setStatus("Unpaid");
			invoice.setCreatedBy(new User(estimate.getCreatedBy()));
			
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

	    	///////////////////////////////////
	    	AuditLog auditLog=new AuditLog();
	    	auditLog.setDetails("Add invoice number "+ invoice.getInvoiceNo());
	    	User user=new User();
	    	user.setUserID(estimate.getCreatedBy());
	    	auditLog.setUser(user);
	    	Logger.log(auditLog);
	    	///////////////////////////////////	
	    	
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
