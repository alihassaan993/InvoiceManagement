package com.accounting.util;

import org.hibernate.Session;

import com.accounting.data.AuditLog;

public class Logger {
	
	
	public static void log(AuditLog auditLog) {
		
		Session session = HibernateUtil.getSessionFactory().openSession();
		try {
       
			session.save(auditLog);
		
		}catch(Exception err) {
			err.printStackTrace();
		}finally {
	        session.close();
		}
        
		
	}
	
}
