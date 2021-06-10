<script lang="javascript">
 	function submitForm() {
 		
		
 		var requestSTR="{";
 		
  		requestSTR=requestSTR+"\"firstName\":\"" + document.getElementById("firstName").value + "\",";
  		requestSTR=requestSTR+"\"lastName\":\"" + document.getElementById("lastName").value + "\",";
  		requestSTR=requestSTR+"\"email\":\"" + document.getElementById("email").value + "\",";
  		requestSTR=requestSTR+"\"mobilePhone\":\"" + document.getElementById("mobilePhone").value + "\",";
  		requestSTR=requestSTR+"\"officePhone\":\"" + document.getElementById("officePhone").value + "\",";
 		requestSTR=requestSTR+"\"billingAddress\":\"" + document.getElementById("billingAddress").value +"\"" ;
  		
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
     			document.getElementById("result").innerHTML ="Cannot add Customer at this time!!!";
     		}
	     	
	     		
	     
	    }
	  };
	  xhttp.open("POST", "../Invoice/webapi/customer", true);
	  xhttp.setRequestHeader("Content-Type", "application/json");
	  xhttp.send(requestSTR); 
	} 

 	function resetForm(){
 		document.getElementById("firstName").value="";
 		document.getElementById("lastName").value="";
 		document.getElementById("email").value="";
 		document.getElementById("mobilePhone").value="";
 		document.getElementById("officePhone").value="";
 		document.getElementById("billingAddress").value="";

 		$("#customerTable").DataTable().ajax.reload();
 		$('#createCustomer').modal('hide');
 	}
 	
</script>

<div class="modal fade" id="createCustomer" role="dialog">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header" style="background: rgba(25, 94, 148, 1);color:white">
				<h4 class="modal-title"> Add New Customer </h4>
			</div>	
			<div class="modal-body">
		<form method="POST" action="javascript:submitForm();" id="productForm">
		
		<div id="result"></div>	
		<div class="container">	
		   <div class="row">
		   	<div class="col-md-6">
			<label for="firstName">First Name</label>
			<input type="text" class="form-control" name="firstName" id="firstName" placeHolder="First Name" required/>
			</div>
			<div class="col-md-6">
			<label for="lastName">Last Name</label>
			<input type="text" class="form-control" name="lastName" id="lastName" placeHolder="Last Name" required/>
			</div>
		  </div>
			<div class="row">
			<div class="col-md-12">
		
			<label for="email">Email</label>
			<input type="email" class="form-control" name="email" id="email" placeHolder="Email" required/>
		
		 	</div>
		 	</div>
		 	<div class="row">
		 	<div class="col-md-6">
		 		
			<label for="mobilePhone">Mobile Number</label>
			<input type="tel" class="form-control" name="mobilePhone" id="mobilePhone" placeHolder="Mobile Number" required/>
			
			</div>
			<div class="col-md-6">
			<label for="officePhone">Office Number</label>
			<input type="tel" class="form-control" name="officePhone" id="officePhone" placeHolder="Office Number"/>
			</div>
			</div>
			<div class="row">
			<div class="col-md-12">		
		
			<label for="billingAddress">Billing Address</label>
			<textarea class="form-control" name="billingAddress" id="billingAddress" 
				placeHolder="Billing Address" 
			rows="3"></textarea>
		
		
		  	</div>
		  	</div>  

			<div class="row">
			<div class="col-md-12">
		    
		
			<button type="submit" class="btn btn-primary">Submit</button>
		
		 </div>
		 </div>
		  </div>
		</form>
		

			</div>
			
		</div>
	</div>
</div> 