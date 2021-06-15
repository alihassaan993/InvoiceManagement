	<script>
	$(document).ready(function() {
		$('#customerTable').DataTable( {
	    	  "ajax": {
	    		    "url": "../Invoice/webapi/customer",
	    		    "dataSrc":""
	    		  },
	    		  columns:[
	    			  {data:"customerID"},
	    			  {data:"firstName"},
	    			  {data:"lastName"},
	    			  {data:"email"},
	    			  {data:"mobilePhone"}
	    		  ],
	    		    dom: '<"toolbar">frtip',
	    		    select:true
	    		    } );
	    			 $("div.toolbar").html('<button class="btn" data-toggle="modal" data-target="#createCustomer">Add New</button>');

 				$('#customerTable').on('click','tr',function(){
 					var table=$('#customerTable').DataTable();
 					var data=table.row(this).data();

 					//alert('You clicked on ' + data.customerID);
 					document.getElementById("resetButton").click();
 					document.getElementById("customerName").value=data.customerID+"-"+data.firstName+" "+data.lastName;
 					//alert(data.isTaxable);
 					if(data.isTaxable==0)
 						isCustomerTaxable=false;
 					else
 						isCustomerTaxable=true;
 					$('#customerList').modal('hide');
 				});
	
	} );
	

	</script>
<div class="modal fade" id="customerList" role="dialog">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header" style="background: rgba(25, 94, 148, 1);color:white">
				<h4 class="modal-title"> Select Customer </h4>
			</div>	
			<div class="modal-body">

	<table id="customerTable" class="table table-striped table-bordered" style="width:100%">
        <thead>
            <tr>
            	<th>Customer ID</th>
                <th>First Name</th>
                <th>Last Name</th>
                <th>Email</th>
                <th>Phone Number</th>
            </tr>
        </thead>
  	</table>
  </div>
  </div>
 </div>
</div>
  	