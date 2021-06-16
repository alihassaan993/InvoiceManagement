<script lang="javascript">
 	function editProduct() {

 		//alert($("input[id='esalesTax']").checked());
		
 		var requestSTR="{";
 		
 		requestSTR=requestSTR+"\"productID\":\"" + document.getElementById("productID").value + "\",";
  		requestSTR=requestSTR+"\"productName\":\"" + document.getElementById("eproductName").value + "\",";
  		requestSTR=requestSTR+"\"description\":\"" + document.getElementById("edescription").value + "\",";
 		requestSTR=requestSTR+"\"cost\":" + document.getElementById("ecost").value +"," ;
 		requestSTR=requestSTR+"\"price\":" + document.getElementById("eprice").value +",";
 		
 		requestSTR=requestSTR+"\"taxID\":["; 
 		
 		esalesTax=false;
 		
 		//responseSTR+=$("input[type='ecaliforniaTax']").val();
 		
 		if (document.getElementById('esalesTax').checked) {
 			esalesTax=true;
 			requestSTR+="{\"taxID\":1}"
 		}
 		if (document.getElementById('ecaliforniaTax').checked) {
 			if(!esalesTax)
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
	    	//alert(this.responseText);
	    	if(this.responseText=="Success"){
	     		document.getElementById("result").innerHTML = "Successfully updated the Product!!!";
	     		$("#productTable").DataTable().ajax.reload();
	     		$('#editProduct').modal('hide');
	     		//resetForm();
	    	}
     		else{
     			document.getElementById("result").innerHTML ="Cannot update Product at this time!!!";
     		}
	     	
	     		
	     
	    }
	  };
	  xhttp.open("POST", "../Invoice/webapi/product/update", true);
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
 	
 	function fetchProduct(productID){
		//Submitting Request
		//alert("Fetching Product");
		document.getElementById("productID").value=productID;
		  var xhttp = new XMLHttpRequest();
		  xhttp.onreadystatechange = function() {
		    if (this.readyState == 4 && this.status == 200) {
		    	var response=JSON.parse(this.responseText);
		    	//alert(response[0]);
		    	if(response!=""){

		    	
		     		document.getElementById("eproductName").value=response.productName;
		     		document.getElementById("edescription").value=response.description;
		     		document.getElementById("ecost").value=response.cost;
		     		document.getElementById("eprice").value=response.price;		    	
		    	
		    	
		    	
		   		}
	     		else{
	     			
	     			alert("Not able to update Product. Please contact system administrator");
	     			//document.getElementById("result").innerHTML ="Cannot add Customer at this time!!!";
	     		}
		     	
		     		
		     
		    }
		  };
		  xhttp.open("POST", "../Invoice/webapi/product/fetch/"+productID, true);
		  xhttp.setRequestHeader("Content-Type", "application/json");
		  xhttp.send(); 
		
		
 	}
 	
</script>

<div class="modal fade" id="editProduct" role="dialog">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header" style="background: rgba(25, 94, 148, 1);color:white">
				<h4 class="modal-title"> Edit Product </h4>
			</div>	
			<div class="modal-body">
			<form method="POST">
			<input type="hidden" id="productID" name="productID"/>
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
        <input id="eproductName" name="eproductName" type="text" class="form-control" required="required">
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
        <input id="edescription" name="edescription" type="text" class="form-control">
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
        <input id="ecost" name="ecost" type="number" required="required" class="form-control">
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
        <input id="eprice" name="eprice" type="number" class="form-control" required="required">
      </div>
    </div>
  </div>
  <div class="form-group row">
    <label class="col-2">Taxable</label> 
    <div class="col-4">
      <div class="custom-control custom-checkbox custom-control-inline">
        <input name="esalesTax" id="esalesTax" type="checkbox" class="custom-control-input" value="1" checked="checked"> 
        <label for="esalesTax" class="custom-control-label">Sales Tax</label>
      </div>
      <div class="custom-control custom-checkbox custom-control-inline">
        <input name="ecaliforniaTax" id="ecaliforniaTax" type="checkbox" class="custom-control-input" value="2" checked="checked"> 
        <label for="ecaliforniaTax" class="custom-control-label">California Tax</label>
      </div>
    </div>
  </div> 


		<div class="modal-footer">
       <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" onclick="javascript:editProduct();">Submit</button>
      </div>
			</form>
			
			</div>
			
		</div>
	</div>
</div> 
