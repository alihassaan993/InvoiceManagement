package com.accounting.action;

import java.util.ArrayList;
import java.util.List;

import javax.transaction.Transactional;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

import com.accounting.data.User;
import com.accounting.data.ProductTax;
import com.accounting.util.HibernateUtil;
import com.google.gson.Gson;

public class UserAction {
	

	protected static SessionFactory sessionFactory;
	
	public boolean login(User user) {
		
		Session session = HibernateUtil.getSessionFactory().openSession();

        String hql = "FROM User u WHERE u.userName = :user_name and u.password=:password";
        Query query = session.createQuery(hql);
        query.setParameter("user_name",user.getUserName());
        query.setParameter("password",user.getPassword());
        List<User> results = query.getResultList();
        session.close();
        
        if (results.size()!=0) {
        	return true;
        }else {
        	return false;
        }
     
        
	}

}
