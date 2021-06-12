package com.accounting.Invoice;

import com.accounting.action.EstimateAction;
import com.accounting.action.InvoiceAction;

import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.PathParam;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;

@Path("invoice")
public class InvoiceResource {
	
	   @GET
	    @Produces(MediaType.APPLICATION_JSON)
	    public String getIt() {
	    	
	    	String response="Error";
	    	
	    	try {
		    	
	    		InvoiceAction custAction=new InvoiceAction();
	    		response=custAction.fetch();
		    	
	    	}catch(Exception err) {
	    		err.printStackTrace();
	    	}
	    	System.out.println(response);
	        return response;
	    }
	   
	   @GET
	   @Path("/{id}")
	   public String fetch(@PathParam("id") Integer id) {
	   	String response="Error";
		
	   	try {
		    	
	   		InvoiceAction custAction=new InvoiceAction();
	   		response=custAction.fetch(id.intValue());
		    	
	   	}catch(Exception err) {
	   		err.printStackTrace();
	   	}
	   	System.out.println(response);
	       return response;
	   }

	   @POST
	   @Path("/{id}")
	   public String payInvoice(@PathParam("id") Integer id) {
	   	String response="Error";
		
	   	try {
		    	
	   		InvoiceAction custAction=new InvoiceAction();
	   		response=custAction.payInvoice(id.intValue());
		    	
	   	}catch(Exception err) {
	   		err.printStackTrace();
	   	}
	   	System.out.println(response);
	       return response;
	   }
}
