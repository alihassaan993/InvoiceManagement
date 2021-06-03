package com.accounting.Invoice;

import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;

import com.accounting.data.Product;

/**
 * Root resource (exposed at "myresource" path)
 */

import com.accounting.action.CustomerAction;
import com.accounting.action.ProductAction;

@Path("myresource")
public class MyResource {

    /**
     * Method handling HTTP GET requests. The returned object will be sent
     * to the client as "text/plain" media type.
     *
     * @return String that will be returned as a text/plain response.
     */
    @GET
    @Produces(MediaType.TEXT_PLAIN)
    public String getIt() {
    	
    	try {
	    	Product prod = new Product();
	    	prod.setProductName("New Tyre");
	    	prod.setDescription("Yokohama 120x230");
	    	prod.setCost(100);
	    	prod.setPrice(120);
	    	
	    	ProductAction prodAction=new ProductAction();
	    	prodAction.create(prod);
	    	
    	}catch(Exception err) {
    		err.printStackTrace();
    	}
        return "Got it!";
    }
    

}
