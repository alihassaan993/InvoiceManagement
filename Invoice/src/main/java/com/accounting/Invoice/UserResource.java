package com.accounting.Invoice;

import com.accounting.action.ProductAction;
import com.accounting.action.UserAction;
import com.accounting.data.Product;
import com.accounting.data.User;

import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.PathParam;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.QueryParam;
import jakarta.ws.rs.core.MediaType;

@Path("user")
public class UserResource {
	

    @Path("login")
    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    public String getIt(User user) {
    	System.out.println("userName " + user.getUserName());
    	UserAction userAction=new UserAction();
    	
	    if(userAction.login(user)) {
	        return "1";
	    }else {
	    	return "2";
	    }
    	//return "{\"result\":\"Success\"}"; 
    }
	
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public String getIt() {
    	
    	String response="Error";
    	
    	try {
	    	
    		UserAction userAction=new UserAction();
    		response=userAction.fetch();
	    	
    	}catch(Exception err) {
    		err.printStackTrace();
    	}
    	System.out.println(response);
        return response;
    }
    
    @POST
    @Path("fetch/{id}")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.TEXT_PLAIN)
    public String getIt(@PathParam("id") Integer id) {
    	
    	String response="Error";
    	
    	try {
	    	
    		UserAction userAction=new UserAction();
    		response=userAction.fetch(id);
	    	
    	}catch(Exception err) {
    		err.printStackTrace();
    	}
    	System.out.println(response);
        return response;
    }
    
    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.TEXT_PLAIN)
    public String saveUser(final User user) {
    	
    	String response="2";
    	
    	try {
	    	//System.out.println("i am receving in POST "+ product.getProductName());
    		UserAction userAction=new UserAction();
    		userAction.create(user);
	    	
	    	response="1";
	    	
    	}catch(Exception err) {
    		err.printStackTrace();
    	}
        return response;
    } 
    
    @Path("update")
    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.TEXT_PLAIN)
    public String update( User user) {
    	
    	String response="Error";
    	
    	try {
	    	//System.out.println("i am receving in POST "+ product.getProductName());
    		UserAction userAction=new UserAction();
	    	response=userAction.update(user);
	    	
	    	//response="1";
	    	
    	}catch(Exception err) {
    		err.printStackTrace();
    	}
        return response;
    }  
    
}
