<script>

	function matchPasswords(){
		if(document.getElementById("password").value!=document.getElementById("confirmPassword").value)
		{	
			alert("Password and confirm password do not match");
			return false;
		}
		else
			return true;
	}

	function saveUser(){
		requestSTR="";
		if(matchPasswords()){
			
			var userRole = $("input[name='userRole']:checked").val();
			
			//alert(userRole);
			
			requestSTR="{";
			
			requestSTR+="\"userName\":\""+document.getElementById("userName").value+"\"";
			requestSTR+=",\"firstName\":\""+document.getElementById("firstName").value+"\"";
			requestSTR+=",\"lastName\":\""+document.getElementById("lastName").value+"\"";
			requestSTR+=",\"userRole\":\""+userRole+"\"";
			requestSTR+=",\"password\":\""+document.getElementById("password").value+"\"";
			
			requestSTR+="}";
			
			//alert(requestSTR);
			
			  var xhttp = new XMLHttpRequest();
			  xhttp.onreadystatechange = function() {
			    if (this.readyState == 4 && this.status == 200) {
			    	if(this.responseText=="1"){
			     		alert("User has been added successfully");
			     		document.getElementById("resetButton").click();
			     		$("#userTable").DataTable().ajax.reload();
			     		$('#createUser').modal('hide');
			    	}
		     		else{
		     			document.getElementById("result").innerHTML ="Cannot add User at this time!!!";
		     		}
			     	
			     		
			     
			    }
			  };
			  xhttp.open("POST", "../Invoice/webapi/user", true);
			  xhttp.setRequestHeader("Content-Type", "application/json");
			  xhttp.send(requestSTR); 			
			
		}
	}

</script>
<div class="modal fade" id="createUser" role="dialog">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header" style="background: rgba(25, 94, 148, 1);color:white">
				<h4 class="modal-title"> Create User </h4>
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
        <input id="firstName" name="firstName" type="text" class="form-control" required="required">
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
        <input id="lastName" name="lastName" type="text" class="form-control" required="required">
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
        <input id="userName" name="userName" type="text" class="form-control" required="required">
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
        <input id="password" name="password" type="password" required="required" class="form-control">
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
        <input id="confirmPassword" name="confirmPassword" type="password" class="form-control" required="required">
      </div>
    </div>
  </div>
  <div class="form-group row">
    <label class="col-4">User Role</label> 
    <div class="col-8">
      <div class="custom-control custom-radio custom-control-inline">
        <input name="userRole" id="userRole_0" type="radio" class="custom-control-input" value="user" checked required="required"> 
        <label for="userRole_0" class="custom-control-label">User</label>
      </div>
      <div class="custom-control custom-radio custom-control-inline">
        <input name="userRole" id="userRole_1" type="radio" class="custom-control-input" value="admin" required="required"> 
        <label for="userRole_1" class="custom-control-label">Admin</label>
      </div>
    </div>
  </div> 

        <div class="modal-footer">
      <input type="reset" id="resetButton" class="btn btn-secondary" />
       <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" onclick="javascript:saveUser();">Save Changes</button>
      </div>
</form>
</div>
</div>
</div>
</div>
