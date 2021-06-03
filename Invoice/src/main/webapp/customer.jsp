<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Invoice Application</title>

  <meta name="viewport" content="width=device-width, initial-scale=1">
  
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"/>
  
	<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/bs4-4.1.1/jq-3.3.1/dt-1.10.24/af-2.3.6/b-1.7.0/b-colvis-1.7.0/r-2.2.7/rg-1.1.2/rr-1.2.7/sc-2.0.3/sb-1.0.1/sp-1.2.2/sl-1.3.3/datatables.min.css"/>
 
<script type="text/javascript" src="https://cdn.datatables.net/v/bs4-4.1.1/jq-3.3.1/dt-1.10.24/af-2.3.6/b-1.7.0/b-colvis-1.7.0/r-2.2.7/rg-1.1.2/rr-1.2.7/sc-2.0.3/sb-1.0.1/sp-1.2.2/sl-1.3.3/datatables.min.js"></script>


</head>
<body>

	<script>
	$(document).ready(function() {
		$('#customerTable').DataTable( {
	    	  "ajax": {
	    		    "url": "http://localhost:8080/Invoice/webapi/customer"
	    		  },
	    dom: '<"toolbar">rtip',
	    select:true
	    } );
		 $("div.toolbar").html('<button class="btn" data-toggle="modal" data-target="#myModal">Add New</button>');
	} );
	</script>
	
	<table id="customerTable" class="table table-striped table-bordered" style="width:100%">
        <thead>
            <tr>
            	<th>Customer ID</th>
                <th>Customer Name</th>
                <th>Email</th>
                <th>Address</th>
            </tr>
        </thead>
  	</table>

</body>
</html>