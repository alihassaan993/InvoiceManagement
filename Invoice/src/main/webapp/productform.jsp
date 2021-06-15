
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
 		
 		//alert(requestSTR);
 		
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
 		
 		$("#productTable").DataTable().ajax.reload();
 		//$('#createCustomer').modal('hide');
 	}
 	
</script>

<script>
$(document).ready(function() {
	

    $('#productTable').DataTable( {
    	  "ajax": {
    		    "url": "http://localhost:8080/Invoice/webapi/product",
    		    "dataSrc":""
    		  },
    		  columns:[
    			  {data:"productName"},
    			  {data:"description"},
    			  {data:"cost"},
    			  {data:"price"}
    		  ],
              		  
    dom: '<"toolbar">frtip',
    select:true
    } );
    $("div.toolbar").html('<a class="btn" data-toggle="modal" data-target="#myModal"><img src="add.png" width="27" height="27"/> Add Product </a>');
} );
</script>
	<br><br>
	<h2><img src="products.png" width="50" height="50"/>&nbsp;&nbsp;&nbsp;Product</h2>
	<br><br>
<div class="modal fade" id="myModal" role="dialog">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header" style="background: rgba(25, 94, 148, 1);color:white">
				<h4 class="modal-title"> Add New Product </h4>
			</div>	
			<div class="modal-body">
			<form method="POST" action="javascript:submitForm();" id="productForm">
			
			<div id="result"></div>	

  <div class="form-group row">
    <label for="productName" class="col-2 col-form-label">Product Name</label> 
    <div class="col-4">
      <div class="input-group">
        <div class="input-group-prepend">
          <div class="input-group-text">
            <i class="fa fa-product-hunt"></i>
          </div>
        </div> 
        <input id="productName" name="productName" type="text" class="form-control" required="required">
      </div>
    </div>
  </div>
  <div class="form-group row">
    <label for="description" class="col-2 col-form-label">Description</label> 
    <div class="col-4">
      <div class="input-group">
        <div class="input-group-prepend">
          <div class="input-group-text">
            <i class="fa fa-arrow-circle-right"></i>
          </div>
        </div> 
        <input id="description" name="description" type="text" class="form-control">
      </div>
    </div>
  </div>
  <div class="form-group row">
    <label for="cost" class="col-2 col-form-label">Cost</label> 
    <div class="col-4">
      <div class="input-group">
        <div class="input-group-prepend">
          <div class="input-group-text">
            <i class="fa fa-dollar"></i>
          </div>
        </div> 
        <input id="cost" name="cost" type="number" required="required" class="form-control">
      </div>
    </div>
  </div>
  <div class="form-group row">
    <label for="price" class="col-2 col-form-label">Price</label> 
    <div class="col-4">
      <div class="input-group">
        <div class="input-group-prepend">
          <div class="input-group-text">
            <i class="fa fa-dollar"></i>
          </div>
        </div> 
        <input id="price" name="price" type="number" class="form-control" required="required">
      </div>
    </div>
  </div>
  <div class="form-group row">
    <label class="col-2">Taxable</label> 
    <div class="col-4">
      <div class="custom-control custom-checkbox custom-control-inline">
        <input name="taxable" id="salesTax" type="checkbox" class="custom-control-input" value="1" checked="checked"> 
        <label for="taxable_0" class="custom-control-label">Sales Tax</label>
      </div>
      <div class="custom-control custom-checkbox custom-control-inline">
        <input name="taxable" id="californiaTax" type="checkbox" class="custom-control-input" value="2" checked="checked"> 
        <label for="taxable_1" class="custom-control-label">California Tax</label>
      </div>
    </div>
  </div> 


		<div class="modal-footer">
      <input type="reset" id="resetButton" class="btn btn-secondary" />
       <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="submit" class="btn btn-primary" onclick="javascript:submitForm();">Submit</button>
      </div>
			</form>
			
			</div>
			
		</div>
	</div>
</div> 

	<table id="productTable" class="table table-striped table-bordered" style="width:100%">
        <thead>
            <tr>
                <th>Product Name</th>
                <th>Description</th>
                <th>Cost</th>
                <th>Price</th>
            </tr>
        </thead>
  	</table>
            


