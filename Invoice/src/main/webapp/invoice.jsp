
	<script>
	var invoiceData;
	var invoiceTable;
	$(document).ready(function() {
		invoiceTable=$('#invoiceTable').DataTable( {
	    	  "ajax": {
	    		    "url": "../Invoice/webapi/invoice",
	    		    "dataSrc":""
	    		  },responsive:true,
	    columns:[
	    	{data:"invoiceNo"},
	    	{data:"creationDate"},
	    	{data:"customerName"},
	    	{data:"status"},
	    	{ 
	            "data": "invoiceID",
	            "render": function(data, type, row, meta){
	               if(type === 'display'){
	                   data = '<a data-toggle="modal" onclick="javascript:populateModal('+data+');" data-target="#viewinvoice"><img src="invoice.png" width="20" height="20"/></a>';
	               }
	               return data;
	            }
	         } 
	    ],
	    dom: '<"etoolbar">frtip',
	    initComplete: function(){
	        $("div.etoolbar")
	           .html('<a class="btn" data-toggle="modal" data-target="#createInvoice"><img src="add.png" width="27" height="27"/> Add invoice </a>');           
	     }
	    } );

		
	} );
	</script>
	<jsp:include page="invoiceform.jsp" />
	<jsp:include page="customerlist.jsp" />
	<jsp:include page="customerform.jsp" />
	<jsp:include page="viewinvoice.jsp" />
	<jsp:include page="productlist.jsp" />

	<br><br>
	<h2><img src="invoice.png" width="50" height="50"/>&nbsp;&nbsp;&nbsp;Invoice</h2>
	<br><br>
	<table id="invoiceTable" class="table table-striped table-bordered" style="width:100%">
        <thead>
            <tr>
                <th>Invoice Number</th>
                <th>Creation Date</th>
                <th>Customer Name</th>
                <th>Status</th>
                <th>View Invoice</th>
            </tr>
        </thead>
  	</table>