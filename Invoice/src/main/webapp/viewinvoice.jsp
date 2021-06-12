<script>


/* $(document).ready(function() {

} ); */
var invoiceTable;
var dataTableLoaded=false;
var invoiceID;

function populateModal(id){
	invoiceID=id;
	if(!dataTableLoaded){
	 invoiceTable=$('#viewInvoiceTable').DataTable( {
	  	  "ajax": {
	  		    "url": "../Invoice/webapi/invoice/"+id,
	  		    "dataSrc":"invoiceProducts",
	  		  	"async": false
	  		  },
	    columns:[
	    	{data:"productName"},
	    	{data:"description"},
	    	{data:"quantity"},
	    	{data:"price"},
	    	{data:"amount"}
	    ],
	    dom: ''
	    } );
		
		invoiceData=invoiceTable.ajax.json();

		if(invoiceData.status=="Paid")
			document.getElementById("customerdata").innerHTML="<img src='paid.png' width='60' heign='60'><br>";	
		else
			document.getElementById("customerdata").innerHTML="";
		document.getElementById("customerdata").innerHTML+=invoiceData.customerName + "<br>" + invoiceData.mobilePhone + "<br>" + invoiceData.email;
		document.getElementById("quotationdata").innerHTML= "invoice No.:" + invoiceData.invoiceNo + "<br>" + "invoice Date:" + invoiceData.creationDate + "<br>" + "Billing Address:" + invoiceData.billingAddress;
		
		document.getElementById("salesTaxDetails").innerHTML=invoiceData.salesTax;
		document.getElementById("californiaTaxDetails").innerHTML=invoiceData.californiaTax;
		document.getElementById("labourCostDetails").innerHTML=invoiceData.labourCost;
		document.getElementById("recyclingChargesDetails").innerHTML=invoiceData.recyclingCharges;
		document.getElementById("totalAmountDetails").innerHTML=invoiceData.totalAmount;
		//alert(invoiceData.totalAmount);
		dataTableLoaded=true;
	}else{

		invoiceTable.destroy();	
		dataTableLoaded=false;
		populateModal(id);
	}
}

function payInvoice(){
	  var xhttp = new XMLHttpRequest();
	  xhttp.onreadystatechange = function() {
	    if (this.readyState == 4 && this.status == 200) {
	    	if(this.responseText=="1"){
	    		//window.location.href = 'newmenu.jsp';
	    		populateModal(invoiceID);
	    	}
     		else{
     			alert("System have some issue. Please contact the administrator.");
     		}
	     	
	     		
	     
	    }
	  };
	  xhttp.open("POST", "../Invoice/webapi/invoice/"+invoiceID, false);
	  xhttp.setRequestHeader("Content-Type", "application/json");
	  xhttp.send(); 

}


</script>
<div class="modal fade" id="viewinvoice" tabindex="-1"  role="dialog">
	<div class="modal-dialog modal-dialog-scrollable modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header" style="background: rgba(25, 94, 148, 1);color:white">
				<h4 class="modal-title"> invoice </h4>
			</div>	
			<div class="modal-body">
	
	
	<table class="table table-striped table-bordered dataTable" style="height:150px">
		<tr>
			<td id="customerdata">
			</td>
			<td id="quotationdata">
			</td>
		</tr>
	</table>		
	
	<table id="viewInvoiceTable" class="table  table-striped table-bordered dataTable" style="width:100%">
        <thead>
            <tr>
                <th>Product Name</th>
                <th>Description</th>
                <th>Quantity</th>
                <th>Unit Price</th>
                <th>Amount</th>
            </tr>
        </thead>
  	</table>
  	<table class="table table-striped table-bordered dataTable">
		<tr>
			<td align="right">
				Sales Tax
			</td>
			<td id="salesTaxDetails">
			</td>
		</tr>
		<tr>
			<td align="right">
				California Tax
			</td>
			<td id="californiaTaxDetails">
			</td>
		</tr>
		<tr>
			<td align="right">
				Labour Cost
			</td>
			<td id="labourCostDetails">
			</td>
		</tr>
		<tr>
			<td align="right">
				Recycling Charges
			</td>
			<td id="recyclingChargesDetails">
			</td>
		</tr>
		<tr>
			<td align="right">
				Total Amount
			</td>
			<td id="totalAmountDetails">
			</td>
		</tr>
	</table>
  	</div>
      <div class="modal-footer">
       <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
       <button type="button" class="btn btn-primary" onclick="javascript:window.print();">Print</button>
       <button type="button" class="btn btn-primary" onclick="javascript:payInvoice();">Paid</button>
      </div>	
  </div>
  </div>
</div>  	