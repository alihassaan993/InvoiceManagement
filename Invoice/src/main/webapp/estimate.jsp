
	<script>
	$(document).ready(function() {
		$('#estimateTable').DataTable( {
	    	  "ajax": {
	    		    "url": "../Invoice/webapi/estimate"
	    		  },
	    columns:[
	    	{data:"estimateNo"},
	    	{data:"creationDate"},
	    	{data:"customerName"}
	    ],
	    dom: '<"etoolbar">frtip',
	    select:true
	    } );
		 $("div.etoolbar").html('<button class="btn" data-toggle="modal" data-target="#createEstimate">Add New</button>');
	} );
	</script>
	<jsp:include page="estimateform.jsp" />  
	<jsp:include page="customerlist.jsp" />
	<jsp:include page="customerform.jsp" />  

	<table id="estimateTable" class="table table-striped table-bordered" style="width:100%">
        <thead>
            <tr>
                <th>Quotation Number</th>
                <th>Creation Date</th>
                <th>Customer Name</th>
            </tr>
        </thead>
  	</table>