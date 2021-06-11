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
		 $("div.toolbar").html('<a class="btn" data-toggle="modal" data-target="#createCustomer"><img src="add.png" width="27" height="27"/> Add Customer </a>');
	} );
	</script>
	<jsp:include page="customerform.jsp" />  
	<br><br>
	<h2><img src="customer.png" width="50" height="50"/>&nbsp;&nbsp;&nbsp;Customer</h2>
	<br><br>
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
  	
 
