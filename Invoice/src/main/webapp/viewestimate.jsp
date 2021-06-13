<script>


/* $(document).ready(function() {

} ); */
var estimateTable;
var dataTableLoaded=false;
var estimateID;
function populateEstimate(id){
	estimateID=id;
	if(!dataTableLoaded){
	 estimateTable=$('#viewEstimateTable').DataTable( {
	  	  "ajax": {
	  		    "url": "../Invoice/webapi/estimate/"+id,
	  		    "dataSrc":"estimateProducts",
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
		
		estimateData=estimateTable.ajax.json();
		document.getElementById("customerdata").innerHTML=estimateData.customerName + "<br>" + estimateData.mobilePhone + "<br>" + estimateData.email;

		document.getElementById("quotationdata").innerHTML= "Estimate No.:" + estimateData.estimateNo + "<br>" + "Estimate Date:" + estimateData.creationDate + "<br>" + "Billing Address:" + estimateData.billingAddress;
		
		document.getElementById("salesTaxDetails").innerHTML=estimateData.salesTax;
		document.getElementById("californiaTaxDetails").innerHTML=estimateData.californiaTax;
		document.getElementById("labourCostDetails").innerHTML=estimateData.labourCost;
		document.getElementById("recyclingChargesDetails").innerHTML=estimateData.recyclingCharges;
		document.getElementById("totalAmountDetails").innerHTML=estimateData.totalAmount;
		//alert(estimateData.totalAmount);
		dataTableLoaded=true;
	}else{

		estimateTable.destroy();	
		dataTableLoaded=false;
		populateEstimate(id);
	}
}

function generateInvoice(){
	var requestSTR; 
	requestSTR+="{\"estimateID\":"+ estimateID +"}";

	  var xhttp = new XMLHttpRequest();
	  xhttp.onreadystatechange = function() {
	    if (this.readyState == 4 && this.status == 200) {
	    	var response=JSON.parse(this.responseText);
	    	if(response.result=="Success"){
	    		

	    		//document.getElementById("viewinvoice").style.display="block";
	    		$('#viewinvoice').modal();
	    		//populateModal(response.invoiceID);	    		
	    		//alert("Successfully generated the invoice "+ response.invoiceID);
	    	}
     		else{
     			alert("Not able to generate Invoice");
     		}
	     	
	     		
	     
	    }
	  };
	  xhttp.open("POST", "../Invoice/webapi/estimate/generateInvoice/"+estimateID, false);
	  xhttp.setRequestHeader("Content-Type", "application/json");
	  xhttp.send(); 
}


</script>
<div class="modal fade" id="viewEstimate" tabindex="-1"  role="dialog">
	<div class="modal-dialog modal-dialog-scrollable modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header" style="background: rgba(25, 94, 148, 1);color:white">
				<h4 class="modal-title"> Estimate </h4>
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
	
	<table id="viewEstimateTable" class="table  table-striped table-bordered dataTable" style="width:100%">
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
       <button type="button" class="btn btn-primary" onclick="javascript:generateInvoice();">Generate Invoice</button>
      </div>	
  </div>
  </div>
</div>  	