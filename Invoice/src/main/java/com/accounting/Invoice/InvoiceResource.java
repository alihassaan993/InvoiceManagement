package com.accounting.Invoice;

import com.accounting.action.EstimateAction;
import com.accounting.action.InvoiceAction;
import com.accounting.data.Estimate;
import com.accounting.data.Invoice;

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
	    	System.out.println("Fetching invoices");
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

	   @GET
	   @Path("customerInvoices/{id}")
	   public String fetchCustomerInvoices(@PathParam("id") Integer id) {
	   	String response="Error";
		
	   	try {
		    	
	   		InvoiceAction custAction=new InvoiceAction();
	   		response=custAction.fetchCustomerInvoices(id.intValue());
		    	
	   	}catch(Exception err) {
	   		err.printStackTrace();
	   	}
	   	System.out.println(response);
	       return response;
	   }	   
	   
	   @Path("pay")
	   @POST
	   @Consumes(MediaType.APPLICATION_JSON)
	   @Produces(MediaType.TEXT_PLAIN)
	   public String payInvoice(Invoice invoice) {
	   	String response="Error";
		
	   	try {
		    	
	   		InvoiceAction custAction=new InvoiceAction();
	   		response=custAction.payInvoice(invoice);
		    	
	   	}catch(Exception err) {
	   		err.printStackTrace();
	   	}
	   	System.out.println(response);
	       return response;
	   }
	   
	   @POST
	   @Consumes(MediaType.APPLICATION_JSON)
	   @Produces(MediaType.TEXT_PLAIN)
	    public String createInvoice(Invoice invoice) {
		   
		    InvoiceAction estimateAction=new InvoiceAction();
		    String response=estimateAction.create(invoice);
		   	
	    	return response;
	    }
}
