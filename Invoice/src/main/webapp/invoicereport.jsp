<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/pdfmake.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/vfs_fonts.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/v/bs5/jq-3.3.1/jszip-2.5.0/dt-1.10.25/af-2.3.7/b-1.7.1/b-colvis-1.7.1/b-html5-1.7.1/b-print-1.7.1/cr-1.5.4/date-1.1.0/fc-3.3.3/fh-3.1.9/kt-2.6.2/r-2.2.9/rg-1.1.3/rr-1.2.8/sc-2.0.4/sb-1.1.0/sp-1.3.0/sl-1.3.3/datatables.min.js"></script>

	<script>
	var invoiceReportTable;
	var idataTableLoaded=false;
	$(document).ready(function() {
		populateInvoices();

	});
	
	function populateInvoices(){
		if(!idataTableLoaded){
			invoiceReportTable=$('#invoiceReport').DataTable( {
		    	  "ajax": {
		    		    "url": "../Invoice/webapi/invoice",
		    		    "dataSrc":""
		    		  },
		    columns:[
		    	{data:"invoiceNo"},
		    	{data:"creationDate"},
		    	{data:"customerName"},
		    	{data:"totalAmount"}, 
		    	{data:"status"},
		    	{data:"createdBy"}
		    ],dom: 'Bfrtip',
		    buttons: ['excel','print','pdf'],
		    select:true
		    } );
			idataTableLoaded=true;
		}else{
			invoiceReportTable.destroy();	
			idataTableLoaded=false;
			populateInvoices();
		}
		
	}
	
	</script>

	<table id="invoiceReport" class="table table-striped table-bordered" style="width:100%">
        <thead>
            <tr>
                <th>Invoice Number</th>
                <th>Creation Date</th>
                <th>Customer Name</th>
                <th>Invoice Amount</th>
                <th>Status</th>
                <th>Created By</th>
            </tr>
        </thead>
  	</table>
