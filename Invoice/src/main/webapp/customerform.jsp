<script lang="javascript">
 	function submitForm() {
 		
 		var isTaxableValue = $("input[name='isTaxable']:checked").val();
 		
		
 		var requestSTR="{";
 		
  		requestSTR=requestSTR+"\"firstName\":\"" + document.getElementById("firstName").value + "\",";
  		requestSTR=requestSTR+"\"lastName\":\"" + document.getElementById("lastName").value + "\",";
  		requestSTR=requestSTR+"\"email\":\"" + document.getElementById("email").value + "\",";
  		requestSTR=requestSTR+"\"mobilePhone\":\"" + document.getElementById("mobilePhone").value + "\",";
  		requestSTR=requestSTR+"\"officePhone\":\"" + document.getElementById("officePhone").value + "\",";
  		requestSTR=requestSTR+"\"companyName\":\"" + document.getElementById("companyName").value + "\",";
  		requestSTR=requestSTR+"\"address1\":\"" + document.getElementById("address1").value + "\",";
 		requestSTR=requestSTR+"\"address2\":\"" + document.getElementById("address2").value + "\",";
 		requestSTR=requestSTR+"\"city\":\"" + document.getElementById("city").value + "\",";
 		
 		requestSTR=requestSTR+"\"categoryID\":\"" + $("input[name='categoryID']:checked").val() + "\",";
 		
 		requestSTR=requestSTR+"\"dmvID\":\"" + document.getElementById("dmvID").value + "\",";
 		requestSTR=requestSTR+"\"employerID\":\"" + document.getElementById("employerID").value + "\",";
 		requestSTR=requestSTR+"\"isTaxable\":\"" + isTaxableValue + "\"";
  		
 		requestSTR=requestSTR+"}";
 		
 		//alert(requestSTR);
 		
	  var xhttp = new XMLHttpRequest();
	  xhttp.onreadystatechange = function() {
	    if (this.readyState == 4 && this.status == 200) {
	    	if(this.responseText=="1"){
	     		alert("Customer has been added successfully");
	     		document.getElementById("resetButton").click();
	     		$("#customerTable").DataTable().ajax.reload();
	     		$('#createCustomer').modal('hide');
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
 		document.getElementById("address1").value="";

 		$("#customerTable").DataTable().ajax.reload();
 		$('#createCustomer').modal('hide');
 	}
 	

 	
</script>

<style>
	p.groove{border-style:groove;}
</style>

<div class="modal fade" id="createCustomer" role="dialog">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header" style="background: rgba(25, 94, 148, 1);color:white">
				<h4 class="modal-title"> Add New Customer </h4>
			</div>	
		<form method="POST" action="javascript:submitForm();" id="productForm">
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
        <input id="firstName" name="firstName" type="text" class="form-control" required="required">
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
        <input id="lastName" name="lastName" type="text" required="required" class="form-control">
      </div>
    </div>
  </div>
  
   <div class="form-group row">
    <label class="col-4">Customer Type</label> 
    <div class="col-8">
      <div class="custom-control custom-radio custom-control-inline">
        <input name="categoryID" id="categoryID_0" type="radio" class="custom-control-input" value="1" required="required" checked="checked"> 
        <label for="categoryID_0" class="custom-control-label">Private</label>
      </div>
      <div class="custom-control custom-radio custom-control-inline">
        <input name="categoryID" id="categoryID_1" type="radio" class="custom-control-input" value="2" required="required"> 
        <label for="categoryID_1" class="custom-control-label">Company</label>
      </div>
    </div>
  </div>  
  
  <div id="dmvDIV" style="display:block">
  <div class="form-group row">
    <label for="companyName" class="col-2 col-form-label">DMV ID</label> 
    <div class="col-4">
      <div class="input-group">
        <div class="input-group-prepend">
          <div class="input-group-text">
            <i class="fa fa-address-card-o"></i>
          </div>
        </div> 
        <input id="dmvID" name="dmvID" type="text" class="form-control">
      </div>
    </div>
  </div>
  </div>
  <div id="companyDIV" style="display:none">
  <div class="form-group row">
    <label for="companyName" class="col-2 col-form-label">Company</label> 
    <div class="col-4">
      <div class="input-group">
        <div class="input-group-prepend">
          <div class="input-group-text">
            <i class="fa fa-address-card-o"></i>
          </div>
        </div> 
        <input id="companyName" name="companyName" type="text" class="form-control">
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
        <input id="employerID" name="employerID" type="text" class="form-control">
      </div>
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
        <input id="email" name="email" type="text" class="form-control">
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
        <input id="mobilePhone" name="mobilePhone" type="text" class="form-control">
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
        <input id="officePhone" name="officePhone" type="text" class="form-control">
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
        <input id="address1" name="address1" placeholder="Street Address 1" type="text" class="form-control">
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
        <input id="address2" name="address2" placeholder="Street Address 2" type="text" class="form-control">
      </div>
    </div>
  </div>
  <div class="form-group row">
    <label for="city" class="col-2 col-form-label">City</label> 
    <div class="col-8">
      <input id="city" name="city" type="text" class="form-control">
    </div>
  </div>
  <div class="form-group row">
    <label class="col-2">Taxable</label> 
    <div class="col-8">
      <div class="custom-control custom-radio custom-control-inline">
        <input name="isTaxable" id="isTaxable" type="radio" class="custom-control-input" value="1" required="required" checked="checked"> 
        <label for="isTaxable_0" class="custom-control-label">Yes</label>
      </div>
      <div class="custom-control custom-radio custom-control-inline">
        <input name="isTaxable" id="isTaxable_1" type="radio" class="custom-control-input" value="0" required="required"> 
        <label for="isTaxable_1" class="custom-control-label">No</label>
      </div>
    </div>
  </div> 

			</div>
			      <div class="modal-footer">
      <input type="reset" id="resetButton" class="btn btn-secondary" />
       <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="submit" class="btn btn-primary">Submit</button>
      </div>
      		</form>
		</div>
	</div>
</div> 

<script>
	$("input[name='categoryID']").change(function(){
 	
 	    categoryID=$("input[name='categoryID']:checked").val();
 	    
 	    if(categoryID==1){
 	    	document.getElementById("companyName").value="";
 	    	document.getElementById("employerID").value="";
 	    	document.getElementById("companyDIV").style.display="none";
 	    	document.getElementById("dmvDIV").style.display="block";
 	    }else{
 	    	document.getElementById("dmvID").value="";
 	    	document.getElementById("dmvDIV").style.display="none";
 	    	document.getElementById("companyDIV").style.display="block";
 	    }
 	    
 	});
</script>