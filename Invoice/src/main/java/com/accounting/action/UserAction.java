package com.accounting.action;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.NoResultException;
import javax.transaction.Transactional;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

import com.accounting.data.User;
import com.accounting.data.AuditLog;
import com.accounting.data.Product;
import com.accounting.data.ProductTax;
import com.accounting.util.HibernateUtil;
import com.accounting.util.Logger;
import com.google.gson.Gson;

public class UserAction {
	

	public String login(User user) {
		
		Session session = HibernateUtil.getSessionFactory().openSession();

		String response="";
		
		try {
		
        String hql = "FROM User u WHERE u.userName = :user_name and u.password=:password";
        Query query = session.createQuery(hql);
        query.setParameter("user_name",user.getUserName());
        query.setParameter("password",user.getPassword());
        
        try {
	        User results = (User) query.getSingleResult();
	        response=results.toString();
	
	    	///////////////////////////////////
	    	AuditLog auditLog=new AuditLog();
	    	auditLog.setDetails("Logged In");
	    	auditLog.setUser(results);
	    	Logger.log(auditLog);
	    	///////////////////////////////////
        
        }catch (NoResultException err){
	    	response="Error";
	    }
	        
		}catch(Exception err) {
			err.printStackTrace();
		}finally {
			session.close();
		}
		
		return response;
        
	}
	
	public String create(User user) {
		
		Session session = HibernateUtil.getSessionFactory().openSession();
		String response="Success";
		
		try {
			session.beginTransaction();
			session.save(user);
			session.getTransaction().commit();
			
		}catch(Exception err) {
			err.printStackTrace();
			session.getTransaction().rollback();
		}finally {
			session.close();
		}

		return response;

	}
	
	public String fetch() {
		Session session = HibernateUtil.getSessionFactory().openSession();
		String response="[";
		
		try {
			String hql = "FROM User";
	        Query query = session.createQuery(hql);
	        List<User> results = query.getResultList();
	        //String _response=new Gson().toJson(results);
	
	       
	        
	        for(int index=0;index<results.size();index++) {
	        	if(index>0)
	        		response+=",";
	        		       	
	        	User user=results.get(index);
	        	response+=user.toString();
	        }
	        
	        response+="]";
	        
	        System.out.println(response);
        

		}catch(Exception err) {
			err.printStackTrace();
		}finally {
			session.close();	
		}
        
        return response;
	}
	
	public String update(User user) {
		System.out.println("Updating User");

		Session session = HibernateUtil.getSessionFactory().openSession();
		String response="Success";
		try {
			
			session.beginTransaction();
			
			session.update(user);
			
			session.getTransaction().commit();
			
		}catch(Exception err) {
			response="Error";
			session.getTransaction().rollback();
		}finally {
			session.close();
		}
		return response;
	}
	
	public String fetch(int userID) {
		Session session = HibernateUtil.getSessionFactory().openSession();
		String response="";
		
		User _user=new User();
		try {
       
		_user=session.get(User.class, userID);
		response=_user.toString();
		
		}catch(Exception err) {
			err.printStackTrace();
		}finally {
	        session.close();
		}
        

        return response;
	}


}
