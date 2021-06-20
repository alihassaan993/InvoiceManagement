<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<html>
<head>
	<title>Login Page</title>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link rel="icon" type="image/png" href="tire.png"/>
<script>
	function login(){
	  var requestSTR="";
	  

	  
	  requestSTR+="{\"userName\":\""+ document.getElementById("userName").value +"\"";
	  requestSTR+=",\"password\":\""+ document.getElementById("userPassword").value +"\"}";
	  

	  
	  var xhttp = new XMLHttpRequest();
	  xhttp.onreadystatechange = function() {
	    if (this.readyState == 4 && this.status == 200) {
	    	//alert(this.responseText);
	    	if(this.responseText!="Error"){
	    		//window.location.href = 'newmenu.jsp';
	    		var response=JSON.parse(this.responseText);
	    		document.cookie="userName="+response.userName + ";";
	    		document.cookie="userRole="+response.userRole + ";";
	    		document.cookie="userID="+response.userID + ";";
	    		document.cookie="fullName="+ response.firstName + " " + response.lastName + ";";
	    		
	    		//document.cookie=cookieValue;
	    		
	    		document.getElementById("verifiedUserName").value=document.getElementById("userName").value;
	    		document.getElementById("loginForm").action="newmenu.jsp";
	    		document.getElementById("loginForm").submit();
	    	}
     		else{
     			alert("UserName or Password are incorrect!!!");
     		}
	     	
	     		
	     
	    }
	  };
	  xhttp.open("POST", "../Invoice/webapi/user/login", false);
	  xhttp.setRequestHeader("Content-Type", "application/json");
	  xhttp.send(requestSTR); 
	//  alert(requestSTR);
		
	}
</script>



   
	<!--Bootsrap 4 CDN-->
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
    
    <!--Fontawesome CDN-->
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" >

	<!--Custom styles-->
	<link rel="stylesheet" type="text/css" href="login.css">
</head>
<body>
<div class="container">
	<div class="d-flex justify-content-center h-100">
		<div class="card">
			<div class="card-header">
				<h3>Sign In</h3>
				<div class="d-flex justify-content-end social_icon">
	
				</div>
			</div>
			<div class="card-body">
				<form action="#" method="post" id="loginForm">
				<input type="hidden" id="verifiedUserName" name="verifiedUserName"/>
					<div class="input-group form-group">
						<div class="input-group-prepend">
							<span class="input-group-text"><i class="fas fa-user"></i></span>
						</div>
						<input type="text" id="userName" class="form-control" placeholder="username" required>
						
					</div>
					<div class="input-group form-group">
						<div class="input-group-prepend">
							<span class="input-group-text"><i class="fas fa-key"></i></span>
						</div>
						<input type="password" id="userPassword" class="form-control" placeholder="password" required>
					</div>
					<div class="row align-items-center remember">
						<input type="checkbox">Remember Me
					</div>
					<div class="form-group">
						<button onclick="javascription:login();" class="btn float-right login_btn">Login</button>
					</div>
				</form>
			</div>
			<div class="card-footer">
				<div class="d-flex justify-content-center links">
					Don't have an account?<a href="#">Sign Up</a>
				</div>
				<div class="d-flex justify-content-center">
					<a href="#">Forgot your password?</a>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>
<script>
$('#loginForm').submit(function(){
    $('input[type=submit]', this).attr('disabled', 'disabled');
});

</script>
