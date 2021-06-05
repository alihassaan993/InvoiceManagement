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
	  xhttp.open("POST", "http://localhost:8080/Invoice/webapi/customer", true);
	  xhttp.setRequestHeader("Content-Type", "application/json");
	  xhttp.send(requestSTR); 
	} 

 	function resetForm(){
 		document.getElementById("customerName").value="";
 		document.getElementById("email").value="";
 		document.getElementById("address").value="";
 	}
 	
</script>

<div class="modal fade" id="myModal" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header" style="background: rgba(25, 94, 148, 1);color:white">
				<h4 class="modal-title"> Add New Customer </h4>
			</div>	
			<div class="modal-body">
		<form method="POST" action="javascript:submitForm();" id="productForm">
		
		<div id="result"></div>	
		
		  <div class="form-group">
		
			<label for="firstName">First Name</label>
			<input type="text" name="firstName" id="firstName" placeHolder="First Name" required/>
		
			<label for="lastName">Last Name</label>
			<input type="text" name="lastName" id="lastName" placeHolder="Last Name" required/>

		  </div>
		  <div class="form-group">
		
			<label for="email">Email</label>
			<input type="email" name="email" id="email" placeHolder="Email" required/>
		
		  </div>
		  <div class="form-group">
		
			<label for="mobilePhone">Mobile Number</label>
			<input type="tel" name="mobilePhone" id="mobilePhone" placeHolder="Mobile Number" required/>
		
			<label for="officePhone">Office Number</label>
			<input type="tel" name="officePhone" id="officePhone" placeHolder="Office Number"/>

		  </div>
		
		  <div class="form-group">
		
			<label for="billingAddress">Billing Address</label>
			<input type="text" name="billingAddress" id="billingAddress" placeHolder="Billing Address" required/>
		
		  </div>  

		    
		  <div class="form-group" align="center">
		
			<button type="submit" class="btn btn-primary">Submit</button>
		
		  </div>  
		 
		  
		</form>
		

			</div>
			
		</div>
	</div>
</div> 