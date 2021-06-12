package com.accounting.action;

import java.util.ArrayList;

import java.util.List;


import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

import com.accounting.data.Customer;
import com.accounting.data.Product;
import com.accounting.data.Invoice;
import com.accounting.data.InvoiceProduct;
import com.accounting.util.HibernateUtil;
import com.google.gson.Gson;

public class InvoiceAction {
	
	protected static SessionFactory sessionFactory;
	
	public String fetch() throws Exception{
		
		Session session = HibernateUtil.getSessionFactory().openSession();
		List<Invoice> results = null;
		String response="";
		
		try {
			String hql = "FROM Invoice";
	        Query query = session.createQuery(hql);
	        results = query.getResultList();
	        
	        response="[";
	        
	        for(int index=0;index<results.size();index++) {
	        	if(index>0)
	        		response+=",";
	        		       	
	        	Invoice _prod=results.get(index);
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

	public String fetch(int invoiceID) throws Exception{
		
		Session session = HibernateUtil.getSessionFactory().openSession();
		//List<invoice> results = null;
		String response="";
		
		try {
//			String hql = "FROM invoice";
//	        Query query = session.createQuery(hql);
//	        results = query.getResultList();
//	        
	        Invoice invoice=session.get(Invoice.class, invoiceID);
	        
	        response=invoice.toString();
	        
	        
	        
		}catch(Exception err) {
			err.printStackTrace();
		}finally {
			session.close(); 
		}
        return response;
	}	
	
	public String create(Invoice invoice) {
		
		Session session = HibernateUtil.getSessionFactory().openSession();
		String response="2";
		
		try {
			
			session.beginTransaction();
			
		    Query q = session.createQuery("select max(invoiceID) from invoice"); 

		    Integer invoiceID = (Integer)q.uniqueResult();
		    
		    String invoiceNo = "EST" + String.format("%05d" , invoiceID.intValue());
		    
		    invoice.setInvoiceNo(invoiceNo);
		    
			session.save(invoice.getCar());
			
			session.save(invoice);
			
			List<InvoiceProduct> invoiceProducts = invoice.getInvoiceProducts();
			
			for(int index=0;index<invoiceProducts.size();index++) {
				
				InvoiceProduct invoiceProduct=(InvoiceProduct)invoiceProducts.get(index);
				invoiceProduct.setInvoice(invoice);
				session.save(invoiceProduct);
				
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
	
	public String payInvoice(int invoiceID) {
		Session session = HibernateUtil.getSessionFactory().openSession();
		String response="2";
		try {
			
			session.beginTransaction();
			Invoice invoice=session.get(Invoice.class, invoiceID);
			invoice.setStatus("Paid");
			
			session.update(invoice);
			
			session.getTransaction().commit();
			
			
			
			response="1";
			
		}catch(Exception err) {
			err.printStackTrace();
			session.getTransaction().commit();
		}finally {
			session.close();
		}
		
		return response;
		
	}

}
