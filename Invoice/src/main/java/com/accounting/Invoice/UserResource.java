package com.accounting.Invoice;

import com.accounting.action.UserAction;
import com.accounting.data.User;

import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.QueryParam;
import jakarta.ws.rs.core.MediaType;

@Path("user")
public class UserResource {
	

    @Path("login")
    @GET
    @Consumes(MediaType.APPLICATION_JSON)
    public String getIt(User user) {
    	System.out.println("userName " + user.getUserName());
    	UserAction userAction=new UserAction();
    	
	    if(userAction.login(user)) {
	        return "{\"result\":\"Success\"}";
	    }else {
	    	return "{\"result\":\"False\"}";
	    }
    	//return "{\"result\":\"Success\"}"; 
    }
	
}
