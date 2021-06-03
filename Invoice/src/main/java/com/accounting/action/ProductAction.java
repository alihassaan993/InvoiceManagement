package com.accounting.action;


import java.util.ArrayList;
import java.util.List;


import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

import com.accounting.data.Product;
import com.accounting.data.ProductTax;
import com.accounting.util.HibernateUtil;
import com.google.gson.Gson;

//import com.google.gson.*;

public class ProductAction {
	
	protected static SessionFactory sessionFactory;
	
	//public Customer fetch() throws Exception
	
	public String fetch(Product product) throws Exception{

		Session session = HibernateUtil.getSessionFactory().openSession();
		
		Product _product=new Product();
		
       
		_product=session.get(Product.class, product.getProductID());
		
        session.close();
        

        return new Gson().toJson(_product);
		
	}

	public String fetch() throws Exception{

		Session session = HibernateUtil.getSessionFactory().openSession();
		
		String hql = "FROM Product";
        Query query = session.createQuery(hql);
        List<Product> results = query.getResultList();
        session.close();

        String response="{ \"data\":[";
        
        for(int index=0;index<results.size();index++) {
        	if(index>0)
        		response+=",";
        		
        	response+="[";
        	Product _prod=results.get(index);
        	response+="\""+_prod.getProductName() + "\"" + ",";
        	response+="\"" + _prod.getDescription() + "\"" + ",";
        	response+="\"" + _prod.getCost() + "\"" + ",";
        	response+="\"" + _prod.getPrice() + "\"" + ",";
        	response+="\" <button>Edit</button> \"" + "]";
        	
        }
        
        response+="]}";
        
        return response;
		
	}
	
	public void create(Product product) throws Exception {
		
		Session session = HibernateUtil.getSessionFactory().openSession();
		
		try {
			
			session.beginTransaction();
			
			session.save(product);
			
			List<ProductTax> taxIDs=product.getTaxID();
			
			for(int index=0;index<taxIDs.size();index++)			
			{	
				ProductTax prodTax=taxIDs.get(index);
				prodTax.setProduct(product);
				session.save(prodTax);
			}
			session.getTransaction().commit();
			
		}catch(Exception err) {
			err.printStackTrace();
			session.getTransaction().rollback();
		}finally {
			session.close();
		}
		
	}	

}
