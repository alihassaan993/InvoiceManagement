package com.accounting.Invoice;

import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;

import com.accounting.data.Estimate;
import com.accounting.action.EstimateAction;

/**
 * Root resource (exposed at "estimate" path)
 */

@Path("estimate")
public class EstimateResource {

    /**
     * Method handling HTTP GET requests. The returned object will be sent
     * to the client as "text/plain" media type.
     *
     * @return String that will be returned as a text/plain response.
     */
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public String getIt() {
    	
    	String response="Error";
    	
    	try {
	    	
    		EstimateAction custAction=new EstimateAction();
    		response=custAction.fetch();
	    	
    	}catch(Exception err) {
    		err.printStackTrace();
    	}
    	System.out.println(response);
        return response;
    }
    
  
   @POST
   @Consumes(MediaType.APPLICATION_JSON)
   @Produces(MediaType.TEXT_PLAIN)
    public String createEstimate(Estimate estimate) {
	   
	    EstimateAction estimateAction=new EstimateAction();
	    estimateAction.create(estimate);
	   	
    	return "";
    }
    
}
