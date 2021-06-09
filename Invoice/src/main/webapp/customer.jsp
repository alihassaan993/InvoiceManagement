<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

	<script>
	$(document).ready(function() {
		$('#customerTable').DataTable( {
	    	  "ajax": {
	    		    "url": "http://localhost:8080/Invoice/webapi/customer",
	    		    "dataSrc":""
	    		  },
	    		  columns:[
	    			  {data:"firstName"},
	    			  {data:"lastName"},
	    			  {data:"email"},
	    			  {data:"mobilePhone"}
	    		  ],
	    dom: '<"toolbar">frtip',
	    select:true
	    } );
		 $("div.toolbar").html('<button class="btn" data-toggle="modal" data-target="#createCustomer">Add New</button>');
	} );
	</script>
	<jsp:include page="customerform.jsp" />  

	<table id="customerTable" class="table table-striped table-bordered" style="width:100%">
        <thead>
            <tr>
                <th>First Name</th>
                <th>Last Name</th>
                <th>Email</th>
                <th>Phone Number</th>
            </tr>
        </thead>
  	</table>
  	
 
