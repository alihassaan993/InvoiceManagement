<script lang="javascript">
 	function editCustomer() {
 		
 		var isTaxableValue = $("input[name='eisTaxable']:checked").val();
 		//alert(isTaxableValue);
 		
		
 		var requestSTR="{";
 		
 		requestSTR=requestSTR+"\"customerID\":" + document.getElementById("customerID").value + ",";
  		
  		requestSTR=requestSTR+"\"firstName\":\"" + document.getElementById("efirstName").value + "\",";
  		requestSTR=requestSTR+"\"lastName\":\"" + document.getElementById("elastName").value + "\",";
  		requestSTR=requestSTR+"\"email\":\"" + document.getElementById("eemail").value + "\",";
  		requestSTR=requestSTR+"\"mobilePhone\":\"" + document.getElementById("emobilePhone").value + "\",";
  		requestSTR=requestSTR+"\"officePhone\":\"" + document.getElementById("eofficePhone").value + "\",";
  		requestSTR=requestSTR+"\"companyName\":\"" + document.getElementById("ecompanyName").value + "\",";
  		requestSTR=requestSTR+"\"address1\":\"" + document.getElementById("eaddress1").value + "\",";
 		requestSTR=requestSTR+"\"address2\":\"" + document.getElementById("eaddress2").value + "\",";
 		requestSTR=requestSTR+"\"city\":\"" + document.getElementById("ecity").value + "\",";
 		requestSTR=requestSTR+"\"dmvID\":\"" + document.getElementById("edmvID").value + "\",";
 		requestSTR=requestSTR+"\"employerID\":\"" + document.getElementById("eemployerID").value + "\",";
 		requestSTR=requestSTR+"\"isTaxable\":\"" + isTaxableValue + "\"";
  		
 		requestSTR=requestSTR+"}";
 		
 		//alert(requestSTR);
 		
	  var xhttp = new XMLHttpRequest();
	  xhttp.onreadystatechange = function() {
	    if (this.readyState == 4 && this.status == 200) {
	    	if(this.responseText=="1"){
	     		//alert("Customer has been updated successfully");
	     		//document.getElementById("resetButton").click();
	     		$("#customerTable").DataTable().ajax.reload();
	     		$('#createCustomer').modal('hide');
	    	}
     		else{
     			document.getElementById("result").innerHTML ="Cannot add Customer at this time!!!";
     		}
	     	
	     		
	     
	    }
	  };
	  xhttp.open("POST", "../Invoice/webapi/customer/update", true);
	  xhttp.setRequestHeader("Content-Type", "application/json");
	  xhttp.send(requestSTR); 
	} 
 	
 	function fetchCustomer(customerID){
 		
		//Submitting Request
		  var xhttp = new XMLHttpRequest();
		  xhttp.onreadystatechange = function() {
		    if (this.readyState == 4 && this.status == 200) {
		    	var response=JSON.parse(this.responseText);
		    	//alert(response);
		    	if(response!=""){
		     		//document.getElementById("result").innerHTML = "Successfully added the Product!!!"
		     		//resetForm();
		     		//alert(response.firstName);
		     		document.getElementById("efirstName").value=response.firstName;
					document.getElementById("elastName").value=response.lastName;
					document.getElementById("edmvID").value=response.dmvID;
					document.getElementById("eemail").value=response.email;
					document.getElementById("emobilePhone").value=response.mobilePhone;
					document.getElementById("eofficePhone").value=response.officePhone;
					document.getElementById("ecompanyName").value=response.companyName;
					document.getElementById("eemployerID").value=response.employerID;
					document.getElementById("eaddress1").value=response.address1;
					document.getElementById("eaddress2").value=response.address2;
					document.getElementById("ecity").value=response.city;
					//if(response.isTaxable==0){
					//	document.getElementById("eisTaxable").value=response.isTaxable;
					//}
					$('input:radio[name=eisTaxable]').val([response.isTaxable]);
					document.getElementById("customerID").value=response.customerID;
		    	}
	     		else{
	     			//document.getElementById("result").innerHTML ="Cannot add Customer at this time!!!";
	     		}
		     	
		     		
		     
		    }
		  };
		  xhttp.open("POST", "../Invoice/webapi/customer/fetchCustomer/"+customerID, true);
		  xhttp.setRequestHeader("Content-Type", "application/json");
		  xhttp.send(); 
		
 		
 		
 	}

 	function resetForm(){
 		document.getElementById("firstName").value="";
 		document.getElementById("lastName").value="";
 		document.getElementById("email").value="";
 		document.getElementById("mobilePhone").value="";
 		document.getElementById("officePhone").value="";
 		document.getElementById("address1").value="";

 		$("#customerTable").DataTable().ajax.reload();
 		$('#createCustomer').modal('hide');
 	}
 	
</script>


<div class="modal fade" id="editCustomer" role="dialog">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header" style="background: rgba(25, 94, 148, 1);color:white">
				<h4 class="modal-title"> Edit Customer </h4>
			</div>	
		<form method="POST" id="productForm">
		<input type="hidden" id="customerID" name="customerID"/>
			<div class="modal-body">
		
		<div id="result"></div>	

 <div class="form-group row">
    <label for="firstName" class="col-2 col-form-label">First Name</label> 
    <div class="col-4">
      <div class="input-group">
        <div class="input-group-prepend">
          <div class="input-group-text">
            <i class="fa fa-address-book"></i>
          </div>
        </div> 
        <input id="efirstName" name="efirstName" type="text" class="form-control" required="required">
      </div>
    </div>
    <label for="lastName" class="col-2 col-form-label">Last Name</label> 
    <div class="col-4">
      <div class="input-group">
        <div class="input-group-prepend">
          <div class="input-group-text">
            <i class="fa fa-address-book"></i>
          </div>
        </div> 
        <input id="elastName" name="elastName" type="text" required="required" class="form-control">
      </div>
    </div>
  </div>
  <div class="form-group row">
    <label for="companyName" class="col-2 col-form-label">DMV ID</label> 
    <div class="col-4">
      <div class="input-group">
        <div class="input-group-prepend">
          <div class="input-group-text">
            <i class="fa fa-address-card-o"></i>
          </div>
        </div> 
        <input id="edmvID" name="edmvID" type="text" class="form-control">
      </div>
    </div>
  </div>
  <div class="form-group row">
    <label for="companyName" class="col-2 col-form-label">Company</label> 
    <div class="col-4">
      <div class="input-group">
        <div class="input-group-prepend">
          <div class="input-group-text">
            <i class="fa fa-address-card-o"></i>
          </div>
        </div> 
        <input id="ecompanyName" name="ecompanyName" type="text" class="form-control">
      </div>
    </div>

    <label for="companyName" class="col-2 col-form-label">Employer ID</label> 
    <div class="col-4">
      <div class="input-group">
        <div class="input-group-prepend">
          <div class="input-group-text">
            <i class="fa fa-address-card-o"></i>
          </div>
        </div> 
        <input id="eemployerID" name="eemployerID" type="text" class="form-control">
      </div>
    </div>
  </div>
  <div class="form-group row">
    <label for="email" class="col-2 col-form-label">Email</label> 
    <div class="col-4">
      <div class="input-group">
        <div class="input-group-prepend">
          <div class="input-group-text">
            <i class="fa fa-envelope-open"></i>
          </div>
        </div> 
        <input id="eemail" name="eemail" type="text" class="form-control">
      </div>
    </div>
  </div>
  <div class="form-group row">
    <label for="mobilePhone" class="col-2 col-form-label">Mobile Phone</label> 
    <div class="col-4">
      <div class="input-group">
        <div class="input-group-prepend">
          <div class="input-group-text">
            <i class="fa fa-phone"></i>
          </div>
        </div> 
        <input id="emobilePhone" name="emobilePhone" type="text" class="form-control">
      </div>
    </div>
    <label for="officePhone" class="col-2 col-form-label">Office Phone</label> 
    <div class="col-4">
      <div class="input-group">
        <div class="input-group-prepend">
          <div class="input-group-text">
            <i class="fa fa-phone"></i>
          </div>
        </div> 
        <input id="eofficePhone" name="eofficePhone" type="text" class="form-control">
      </div>
    </div>
  </div>
  <div class="form-group row">
    <label for="address1" class="col-2 col-form-label">Address 1</label> 
    <div class="col-8">
      <div class="input-group">
        <div class="input-group-prepend">
          <div class="input-group-text">
            <i class="fa fa-home"></i>
          </div>
        </div> 
        <input id="eaddress1" name="eaddress1" placeholder="Street Address 1" type="text" class="form-control">
      </div>
    </div>
  </div>
  <div class="form-group row">
    <label for="address2" class="col-2 col-form-label">Address 2</label> 
    <div class="col-8">
      <div class="input-group">
        <div class="input-group-prepend">
          <div class="input-group-text">
            <i class="fa fa-home"></i>
          </div>
        </div> 
        <input id="eaddress2" name="eaddress2" placeholder="Street Address 2" type="text" class="form-control">
      </div>
    </div>
  </div>
  <div class="form-group row">
    <label for="city" class="col-2 col-form-label">City</label> 
    <div class="col-8">
      <input id="ecity" name="ecity" type="text" class="form-control">
    </div>
  </div>
  <div class="form-group row">
    <label class="col-2">Taxable</label> 
    <div class="col-8">
      <div class="custom-control custom-radio custom-control-inline">
        <input name="eisTaxable" id="eisTaxable_1" type="radio" class="custom-control-input" value="1" > 
        <label for="eisTaxable_1" class="custom-control-label">Yes</label>
      </div>
      <div class="custom-control custom-radio custom-control-inline">
        <input name="eisTaxable" id="eisTaxable_0" type="radio" class="custom-control-input" value="0" > 
        <label for="eisTaxable_0" class="custom-control-label">No</label>
      </div>
    </div>
  </div> 

  </div>
	<div class="modal-footer">
	     <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
	     <button class="btn btn-primary" onclick="editCustomer();">Submit</button>
	</div>
      		</form>
		</div>
	</div>
</div> 