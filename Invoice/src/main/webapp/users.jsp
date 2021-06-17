	<script>
	$(document).ready(function() {
		//alert("Loading users");
		$('#userTable').DataTable( {
	    	  "ajax": {
	    		    "url": "../Invoice/webapi/user",
	    		    "dataSrc":""
	    		  },
	    		  columns:[
	    			  {data:"userID"},
	    			  {data:"firstName"},
	    			  {data:"lastName"},
	    			  {data:"userName"},
	    			  {data:"userRole"}
	    		  ],
	    		    dom: '<"toolbar">frtip',
	    		    select:true
	    		    } );
	     $("div.toolbar").html('<a class="btn" data-toggle="modal" data-target="#createUser"><img src="add.png" width="27" height="27"/> Add User </a>');
		
 				
	} );
	

	</script>
	
	<jsp:include page="userform.jsp" /> 
	<br><br>
	<h2><img src="customer.png" width="50" height="50"/>&nbsp;&nbsp;&nbsp;User</h2>
	<br><br>
	
		<table id="userTable" class="table table-striped table-bordered" style="width:100%">
		        <thead>
		            <tr>
		            	<th>User ID</th>
		                <th>First Name</th>
		                <th>Last Name</th>
		                <th>UserName</th>
		                <th>User Role</th>
		            </tr>
		        </thead>
		  	</table>

  	