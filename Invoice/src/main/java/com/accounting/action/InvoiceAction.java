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
import com.accounting.data.Invoice;
import com.accounting.data.InvoiceProduct;
import com.accounting.util.HibernateUtil;
import com.accounting.util.Logger;
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

	
	public String fetchCustomerInvoices(int customerID) throws Exception{
		
		Session session = HibernateUtil.getSessionFactory().openSession();
		//List<invoice> results = null;
		String response="";
		
		try {
			String hql = "FROM Invoice inv where inv.customer.customerID = :customer_id ";
	        Query query = session.createQuery(hql);
	        query.setParameter("customer_id",customerID);
	        List<Invoice> results = query.getResultList();
	        
	        //Invoice invoice=session.get(Invoice.class, custom);
	        
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
	
	public String create(Invoice invoice) {
		
		Session session = HibernateUtil.getSessionFactory().openSession();
		String response="2";
		
		try {
			System.out.println(invoice.toString());
			
			session.beginTransaction();
			
		    Query q = session.createQuery("select max(invoiceID) from Invoice"); 
		    Integer invoiceID = (Integer)q.uniqueResult();
		    
		    
		    String invoiceNo="";
		    
		    try {
		    
		    	invoiceNo = "INV" + String.format("%05d" , invoiceID.intValue()+1);
		    
		    }catch(NullPointerException err) {
		    	invoiceNo="INV000001";
		    }
		    
		    invoice.setInvoiceNo(invoiceNo);
		    
		    Car car=invoice.getCar();
		    car.setCustomer(invoice.getCustomer());
		    
		    
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
		    		    
			session.save(invoice);
			
			List<InvoiceProduct> invoiceProducts = invoice.getInvoiceProducts();
			
			for(int index=0;index<invoiceProducts.size();index++) {
				
				InvoiceProduct invoiceProduct=(InvoiceProduct)invoiceProducts.get(index);
				invoiceProduct.setInvoice(invoice);
				session.save(invoiceProduct);
				
			}

	    	///////////////////////////////////
	    	AuditLog auditLog=new AuditLog();
	    	auditLog.setDetails("Add invoice number "+ invoice.getInvoiceNo());

	    	auditLog.setUser(new User(invoice.getCreatedBy().getUserID()));
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
	
	public String payInvoice(Invoice invoice) {
		Session session = HibernateUtil.getSessionFactory().openSession();
		String response="2";
		try {
			
			session.beginTransaction();
			Invoice _invoice=session.get(Invoice.class, invoice.getInvoiceID());
			if(!invoice.getPaymentMethod().equals("Return")) {
				_invoice.setStatus("Paid");
				_invoice.setPaymentMethod(invoice.getPaymentMethod());
			}else {
				_invoice.setStatus("Return");
				//_invoice.setPaymentMethod("");				
			}
			
			session.update(_invoice);
			
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
