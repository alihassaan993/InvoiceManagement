package com.accounting.util;


import org.hibernate.SessionFactory;
import org.hibernate.boot.MetadataSources;
import org.hibernate.boot.registry.StandardServiceRegistry;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;



public class HibernateUtil {
    private static  SessionFactory sessionFactory=null;

    static {     
        try {
        	final StandardServiceRegistry registry = new StandardServiceRegistryBuilder()
        	        .configure() // configures settings from hibernate.cfg.xml
        	        .build();
        	try {
        	    sessionFactory = new MetadataSources(registry).buildMetadata().buildSessionFactory();
        	} catch (Exception ex) {
        	    StandardServiceRegistryBuilder.destroy(registry);
        	}
        }catch(Exception err) {
        	err.printStackTrace();
        }
    	
    }

    public static SessionFactory getSessionFactory() {
        return sessionFactory;
    }
}