
	<script>
	var invoiceTable;
	var dataTableLoaded=false;
	var invoiceID;
	function populateInvoices (customerID){
		invoiceID=customerID;
		if(!dataTableLoaded){
			invoiceTable=$('#invoiceTable').DataTable( {
		    	  "ajax": {
		    		    "url": "../Invoice/webapi/invoice/customerInvoices/"+invoiceID,
		    		    "dataSrc":""
		    		  },
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
		    dom: 'frtip',
		    select:true
		    } );
			dataTableLoaded=true;
		}else{
			invoiceTable.destroy();	
			dataTableLoaded=false;
			populateInvoices(customerID);
		}
		
	}
	</script>
<div class="modal fade" id="viewinvoices" tabindex="-1"  role="dialog">
	<div class="modal-dialog modal-dialog-scrollable modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header" style="background: rgba(25, 94, 148, 1);color:white">
				<h4 class="modal-title"> invoice </h4>
			</div>	
			<div class="modal-body">
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
			  </div>
			 </div> 	
			</div>
		</div>
		 