package com.accounting.Invoice;

import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.PathParam;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;

import com.accounting.data.Product;

/**
 * Root resource (exposed at "product" path)
 */

import com.accounting.action.ProductAction;

@Path("product")
public class ProductResource {

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
	    	
    		ProductAction prodAction=new ProductAction();
    		response=prodAction.fetch();
	    	
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
	    	
    		ProductAction prodAction=new ProductAction();
    		response=prodAction.fetch(id);
	    	
    	}catch(Exception err) {
    		err.printStackTrace();
    	}
    	System.out.println(response);
        return response;
    }
    
    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.TEXT_PLAIN)
    public String saveProduct(final Product product) {
    	
    	String response="2";
    	
    	try {
	    	//System.out.println("i am receving in POST "+ product.getProductName());
	    	ProductAction prodAction=new ProductAction();
	    	prodAction.create(product);
	    	
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
    public String update( Product product) {
    	
    	String response="Error";
    	
    	try {
	    	//System.out.println("i am receving in POST "+ product.getProductName());
	    	ProductAction prodAction=new ProductAction();
	    	response=prodAction.update(product);
	    	
	    	//response="1";
	    	
    	}catch(Exception err) {
    		err.printStackTrace();
    	}
        return response;
    }  
    
}
