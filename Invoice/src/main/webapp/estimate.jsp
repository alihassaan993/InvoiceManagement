
	<script>
	$(document).ready(function() {
		$('#customerTable').DataTable( {
	    	  "ajax": {
	    		    "url": "http://localhost:8080/Invoice/webapi/estimate"
	    		  },
	    columns:[
	    	data:"estimateNo",
	    	data:"creationDate",
	    	data:"customerName"
	    ],
	    dom: '<"toolbar">frtip',
	    select:true
	    } );
		 $("div.toolbar").html('<button class="btn" data-toggle="modal" data-target="#myModal">Add New</button>');
	} );
	</script>
	<jsp:include page="customerform.jsp" />  

	<table id="customerTable" class="table table-striped table-bordered" style="width:100%">
        <thead>
            <tr>
                <th>Quotation Number</th>
                <th>Creation Date</th>
                <th>Customer Name</th>
            </tr>
        </thead>
  	</table>