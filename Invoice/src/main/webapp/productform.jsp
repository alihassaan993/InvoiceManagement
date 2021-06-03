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
<script lang="javascript">
 	function submitForm() {
 		
		
 		var requestSTR="{";
 		
  		requestSTR=requestSTR+"\"productName\":\"" + document.getElementById("productName").value + "\",";
  		requestSTR=requestSTR+"\"description\":\"" + document.getElementById("description").value + "\",";
 		requestSTR=requestSTR+"\"cost\":" + document.getElementById("cost").value +"," ;
 		requestSTR=requestSTR+"\"price\":" + document.getElementById("price").value +",";
 		
 		requestSTR=requestSTR+"\"taxID\":["; 
 		
 		salesTax=false;
 		
 		if (document.getElementById('salesTax').checked) {
 			salesTax=true;
 			requestSTR+="{\"taxID\":1}"
 		}
 		if (document.getElementById('californiaTax').checked) {
 			if(!salesTax)
 				requestSTR+="{\"taxID\":2}"
 			else{
 				requestSTR+=",{\"taxID\":2}"
 			}
 		}
 		
 		requestSTR+="]";
 		
  		
 		requestSTR=requestSTR+"}";
 		
 		alert(requestSTR);
 		
	  var xhttp = new XMLHttpRequest();
	  xhttp.onreadystatechange = function() {
	    if (this.readyState == 4 && this.status == 200) {
	    	if(this.responseText=="1"){
	     		document.getElementById("result").innerHTML = "Successfully added the Product!!!"
	     		resetForm();
	    	}
     		else{
     			document.getElementById("result").innerHTML ="Cannot add Product at this time!!!";
     		}
	     	
	     		
	     
	    }
	  };
	  xhttp.open("POST", "http://localhost:8080/Invoice/webapi/product", true);
	  xhttp.setRequestHeader("Content-Type", "application/json");
	  xhttp.send(requestSTR); 
	} 

 	function resetForm(){
 		document.getElementById("productName").value="";
 		document.getElementById("description").value="";
 		document.getElementById("cost").value="";
 		document.getElementById("price").value="";
 	}
 	
</script>

<script>
$(document).ready(function() {
	

    $('#example').DataTable( {
    	  "ajax": {
    		    "url": "http://localhost:8080/Invoice/webapi/product"
    		  },
              		  
    dom: '<"toolbar">rtip',
    select:true
    } );
    $("div.toolbar").html('<button class="btn" data-toggle="modal" data-target="#myModal">Add New</button>');
} );
</script>

<div class="modal fade" id="myModal" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title"> Add New Product </h4>
			</div>	
			<div class="modal-body">
			<form method="POST" action="javascript:submitForm();" id="productForm">
			
			<div id="result"></div>	
			
			  <div class="form-group">
			
				<label for="productName">Product Name</label>
				<input type="text" name="productName" id="productName" placeHolder="Product Name" required/>
			
			  </div>
			  <div class="form-group">
			
				<label for="description">Product Desc</label>
				<input type="text" name="description" id="description" placeHolder="Product Desc" required/>
			
			  </div>
			
			  <div class="form-group">
			
				<label for="cost">Cost</label>
				<input type="number" name="cost" id="cost" placeHolder="$$" required/>
				
				<label for="price">Price</label>
				<input type="number" name="price" id="price" placeHolder="$$" required/>
			
			  </div>  
	
			<div class="form-check">
			  <input class="form-check-input" type="checkbox" value="1" id="salesTax">
			  <label class="form-check-label" for="flexCheckDefault">
			    Sales Tax
			  </label>
			</div>
			<div class="form-check">
			  <input class="form-check-input" type="checkbox" value="2" id="californiaTax" checked>
			  <label class="form-check-label" for="flexCheckChecked">
			    California Tax
			  </label>
			</div>
	
	
			    
			  <div class="form-group" align="center">
			
				<button type="submit" class="btn btn-primary">Submit</button>
			
			  </div>  
			 
			  
			</form>
			
			</div>
			
		</div>
	</div>
</div> 

	<table id="example" class="table table-striped table-bordered" style="width:100%">
        <thead>
            <tr>
                <th>Product Name</th>
                <th>Description</th>
                <th>Cost</th>
                <th>Price</th>
                <th>Edit</th>
            </tr>
        </thead>
  	</table>
            


</body>



</html>

