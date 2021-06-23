<script>
	var userID;
	function matchPasswords(){
		if(document.getElementById("epassword").value!=document.getElementById("econfirmPassword").value)
		{	
			alert("Password and confirm password do not match");
			return false;
		}
		else
			return true;
	}

	function editUser(){
		requestSTR="";
		if(matchPasswords()){
			
			var userRole = $("input[name='euserRole']:checked").val();
			
			//alert(userRole);
			
			requestSTR="{";
			
			requestSTR+="\"userID\":"+userID+"";
			requestSTR+=",\"userName\":\""+document.getElementById("euserName").value+"\"";
			requestSTR+=",\"firstName\":\""+document.getElementById("efirstName").value+"\"";
			requestSTR+=",\"lastName\":\""+document.getElementById("elastName").value+"\"";
			requestSTR+=",\"userRole\":\""+userRole+"\"";
			requestSTR+=",\"password\":\""+document.getElementById("epassword").value+"\"";
			
			requestSTR+="}";
			
			//alert(requestSTR);
			
			  var xhttp = new XMLHttpRequest();
			  xhttp.onreadystatechange = function() {
			    if (this.readyState == 4 && this.status == 200) {
			    	if(this.responseText=="1"){
			     		alert("User have been updated successfully");
			     		document.getElementById("resetButton").click();
			     		$("#userTable").DataTable().ajax.reload();
			     		$('#editUser').modal('hide');
			    	}
		     		else{
		     			document.getElementById("result").innerHTML ="Cannot add User at this time!!!";
		     		}
			     	
			     		
			     
			    }
			  };
			  xhttp.open("POST", "../Invoice/webapi/user/update", true);
			  xhttp.setRequestHeader("Content-Type", "application/json");
			  xhttp.send(requestSTR); 			
			
		}
	}

	function fetchUser(userID){
		//Submitting Request
		  var xhttp = new XMLHttpRequest();
		  xhttp.onreadystatechange = function() {
		    if (this.readyState == 4 && this.status == 200) {
		    	var response=JSON.parse(this.responseText);
		    	//alert(response);
		    	if(response!=""){
					document.getElementById("euserName").value=response.userName;
					document.getElementById("efirstName").value=response.firstName;
					document.getElementById("elastName").value=response.lastName;
					document.getElementById("epassword").value=response.password;
					document.getElementById("euserID").value=userID;
		    	}
	     		else{
	     			//document.getElementById("result").innerHTML ="Cannot add Customer at this time!!!";
	     		}
		     	
		     		
		     
		    }
		  };
		  xhttp.open("POST", "../Invoice/webapi/user/fetch/"+userID, true);
		  xhttp.setRequestHeader("Content-Type", "application/json");
		  xhttp.send(); 
		
			
	}
	
</script>
<div class="modal fade" id="editUser" role="dialog">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header" style="background: rgba(25, 94, 148, 1);color:white">
				<h4 class="modal-title"> Edit User </h4>
			</div>	
			<div class="modal-body">
<form>
  <div class="form-group row">
    <label for="firstName" class="col-4 col-form-label">First Name</label> 
    <div class="col-8">
      <div class="input-group">
        <div class="input-group-prepend">
          <div class="input-group-text">
            <i class="fa fa-address-book"></i>
          </div>
        </div> 
        <input id="efirstName" name="efirstName" type="text" class="form-control" required="required">
      </div>
    </div>
  </div>
  <div class="form-group row">
    <label for="lastName" class="col-4 col-form-label">Last Name</label> 
    <div class="col-8">
      <div class="input-group">
        <div class="input-group-prepend">
          <div class="input-group-text">
            <i class="fa fa-address-book"></i>
          </div>
        </div> 
        <input id="elastName" name="elastName" type="text" class="form-control" required="required">
      </div>
    </div>
  </div>
  <div class="form-group row">
    <label for="userName" class="col-4 col-form-label">User Name</label> 
    <div class="col-8">
      <div class="input-group">
        <div class="input-group-prepend">
          <div class="input-group-text">
            <i class="fa fa-user"></i>
          </div>
        </div> 
        <input id="euserName" name="euserName" type="text" class="form-control" required="required" readonly>
      </div>
    </div>
  </div>
  <div class="form-group row">
    <label for="password" class="col-4 col-form-label">Password</label> 
    <div class="col-8">
      <div class="input-group">
        <div class="input-group-prepend">
          <div class="input-group-text">
            <i class="fa fa-compass"></i>
          </div>
        </div> 
        <input id="epassword" name="epassword" type="password" required="required" class="form-control">
      </div>
    </div>
  </div>
  <div class="form-group row">
    <label for="confirmPassword" class="col-4 col-form-label">Confirm Password</label> 
    <div class="col-8">
      <div class="input-group">
        <div class="input-group-prepend">
          <div class="input-group-text">
            <i class="fa fa-compass"></i>
          </div>
        </div> 
        <input id="econfirmPassword" name="econfirmPassword" type="password" class="form-control" required="required">
      </div>
    </div>
  </div>
  <div class="form-group row">
    <label class="col-4">User Role</label> 
    <div class="col-8">
      <div class="custom-control custom-radio custom-control-inline">
        <input name="euserRole" id="euserRole_0" type="radio" class="custom-control-input" value="user" checked required="required"> 
        <label for="euserRole_0" class="custom-control-label">User</label>
      </div>
      <div class="custom-control custom-radio custom-control-inline">
        <input name="euserRole" id="euserRole_1" type="radio" class="custom-control-input" value="admin" required="required"> 
        <label for="euserRole_1" class="custom-control-label">Admin</label>
      </div>
    </div>
  </div> 

        <div class="modal-footer">
      <input type="reset" id="resetButton" class="btn btn-secondary" />
       <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" onclick="javascript:editUser();">Save Changes</button>
      </div>
</form>
</div>
</div>
</div>
</div>
