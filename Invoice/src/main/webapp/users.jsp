	<script>
	$(document).ready(function() {
		//alert("Loading users");
		$('#userTable').DataTable( {
	    	  "ajax": {
	    		    "url": "../Invoice/webapi/user",
	    		    "dataSrc":""
	    		  },
	    		  columns:[
	    			  {data:"firstName"},
	    			  {data:"lastName"},
	    			  {data:"userName"},
	    			  {data:"userRole"},
		   		    	{ 
		   		            "data": "userID",
		   		            "render": function(data, type, row, meta){
		   		            	userID=data;
		   		               if(type === 'display'){
		   		                   data = '<a data-toggle="modal" onclick="javascript:fetchUser('+userID+');" data-target="#editUser"><span class="material-icons">mode_edit</span></a>';	
		   		               }
		   		               return data;
		   		            }
		   		         } 
	    		  ],
	    		    dom: '<"toolbar">frtip',
	    		    select:true
	    		    } );
	     $("div.toolbar").html('<a class="btn" data-toggle="modal" data-target="#createUser"><img src="add.png" width="27" height="27"/> Add User </a>');
		
 				
	} );
	

	</script>
	
	<jsp:include page="userform.jsp" /> 
	<jsp:include page="edituser.jsp" /> 
	<br><br>
	<h2><img src="customer.png" width="50" height="50"/>&nbsp;&nbsp;&nbsp;User</h2>
	<br><br>
	
		<table id="userTable" class="table table-striped table-bordered" style="width:100%">
		        <thead>
		            <tr>
		            	<th>First Name</th>
		                <th>Last Name</th>
		                <th>UserName</th>
		                <th>User Role</th>
		                <th>Edit</th>
		            </tr>
		        </thead>
		  	</table>

  	