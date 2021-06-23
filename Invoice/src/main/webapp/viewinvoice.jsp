<script>


/* $(document).ready(function() {

} ); */
var invoicedTable;
var invoiceDataTableLoaded=false;
var invoiceID;

function populateModal(id){
	invoiceID=id;
	var invoiceData;
	if(!invoiceDataTableLoaded){
		invoicedTable=$('#viewInvoiceTable').DataTable( {
	  	  "ajax": {
	  		    "url": "../Invoice/webapi/invoice/"+id,
	  		    "dataSrc":"invoiceProducts",
	  		  	"async": false
	  		  },	  
	    columns:[
	    	{data:"productName"},
	    	{data:"description"},
	    	{data:"quantity"},
	    	{data:"discount"},
	    	{data:"price"},
	    	{data:"amount"}
	    ],
	    dom: ''
	    } );
		
		invoiceData=invoicedTable.ajax.json();

		if(invoiceData.status=="Paid"){
			document.getElementById("icustomerdata").innerHTML="<img src='paid.png' width='60' height='60'><br>";
			document.getElementById("returnButton").style.display="block";
			document.getElementById("paymentBlock").style.display="none";
		}else if(invoiceData.status=="Return"){
			document.getElementById("returnButton").style.display="none";
			document.getElementById("paymentBlock").style.display="none";			
		}
		else{
			document.getElementById("icustomerdata").innerHTML="";
			document.getElementById("paymentBlock").style.display="block";
			document.getElementById("returnButton").style.display="none";
		}
		document.getElementById("icustomerdata").innerHTML+=invoiceData.customerName + "<br>" + invoiceData.mobilePhone + "<br>" + invoiceData.email;
		document.getElementById("iquotationdata").innerHTML= "invoice No.:" + invoiceData.invoiceNo + "<br>" + "invoice Date:" + invoiceData.creationDate + "<br>" + "Billing Address:" + invoiceData.billingAddress;
		
		document.getElementById("isalesTaxDetails").innerHTML=invoiceData.salesTax;
		document.getElementById("icaliforniaTaxDetails").innerHTML=invoiceData.californiaTax;
		document.getElementById("ilabourCostDetails").innerHTML=invoiceData.labourCost;
		document.getElementById("irecyclingChargesDetails").innerHTML=invoiceData.recyclingCharges;
		document.getElementById("itotalAmountDetails").innerHTML=invoiceData.totalAmount;
		//alert(invoiceData.totalAmount);
		invoiceDataTableLoaded=true;
	
		//alert("Populate table successfully");
	}else{

		invoicedTable.destroy();	
		invoiceDataTableLoaded=false;
		populateModal(id);
	}
}

function payInvoice(paymentMethod){
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
	  requestSTR="{\"invoiceID\":"+invoiceID+",\"paymentMethod\":\""+ paymentMethod +"\"}";
	  xhttp.open("POST", "../Invoice/webapi/invoice/pay", false);
	  xhttp.setRequestHeader("Content-Type", "application/json");
	  xhttp.send(requestSTR); 

}


</script>
<div id="printThis">
<div class="modal fade" id="viewinvoice" tabindex="-1"  role="dialog">
	<div class="modal-dialog modal-dialog-scrollable modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header" style="background: rgba(25, 94, 148, 1);color:white">
				<h4 class="modal-title"> Invoice </h4>
			</div>	
			<div class="modal-body">
	
	<div class="row">
	<div class="col-md-12">
	<table class="table table-striped table-bordered dataTable" style="height:150px">
		<tr>
			<td id="icustomerdata">
			</td>
			<td id="iquotationdata">
			</td>
		</tr>
	</table>
	</div>
	</div>		
	<div class="row">
	<div class="col-md-12">
	<table id="viewInvoiceTable" class="table  table-striped table-bordered dataTable" style="width:100%">
        <thead>
            <tr>
                <th>Product Name</th>
                <th>Description</th>
                <th>Quantity</th>
                <th>Discount</th>
                <th>Unit Price</th>
                <th>Amount</th>
            </tr>
        </thead>
  	</table>
  	</div>
  	</div>
  	<div class="row">
  	<div class="col-md-6">
  		<table>
  			<thead>
	  			<tr>
	  				<th>OTHER COMMENTS</th>
	  			</tr>
  			</thead>
			<tbody>
				<tr>
					<td>
					<p>
					
					CUSTOMER, PLEASE NOTE: Company does not provide any kind of warranty on used tires and no warranty 
					on shaved white wall tires. Company will be not responsible if anything happens to you or your 
					vehicle due to used tires, spoke rims, low profile tires and shaved whitewalls. No returns on 
					mount wheel and tires, used items and special orders. All returns are subject to 25% restocking 
					fees of total amount. And 25% cancellation fee on specials orders of total amount. 
					Also 25% cancellation fee on lay-away orders of total amount. 
					
					</p>
					</td>
				</tr>
			</tbody>
  		</table>
  	</div>
  	<div class="col-md-6">
  	<table class="table table-striped table-bordered dataTable">
		<tr>
			<td align="right">
				Sales Tax
			</td>
			<td id="isalesTaxDetails">
			</td>
		</tr>
		<tr>
			<td align="right">
				California Tax
			</td>
			<td id="icaliforniaTaxDetails">
			</td>
		</tr>
		<tr>
			<td align="right">
				Labour Cost
			</td>
			<td id="ilabourCostDetails">
			</td>
		</tr>
		<tr>
			<td align="right">
				Recycling Charges
			</td>
			<td id="irecyclingChargesDetails">
			</td>
		</tr>
		<tr>
			<td align="right">
				Total Amount
			</td>
			<td id="itotalAmountDetails">
			</td>
		</tr>
	</table>
	</div>
	</div>
  	</div>
      <div class="modal-footer">
       <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
       <button type="button" class="btn btn-primary" id="btnPrint">Print</button>
       <button type="button" class="btn btn-primary" id="returnButton" onclick="javascript:payInvoice('Return');">Return</button>
       <div id="paymentBlock" style="display:none">
       <button type="button" class="btn btn-primary" onclick="javascript:payInvoice('Cash');">Pay By Cash</button>
       <button type="button" class="btn btn-primary" onclick="javascript:payInvoice('Cheque');">Pay By Cheque</button>
       <button type="button" class="btn btn-primary" onclick="javascript:payInvoice('Card');">Pay By Card</button>
      </div>	
      </div>
  </div>
  </div>
</div>  
</div>	
<script>

document.getElementById("btnPrint").onclick = function () {
    printElement(document.getElementById("printThis"));
}

function printElement(elem) {
    var domClone = elem.cloneNode(true);
    
    var $printSection = document.getElementById("printSection");
    
    if (!$printSection) {
        var $printSection = document.createElement("div");
        $printSection.id = "printSection";
        document.body.appendChild($printSection);
    }
    
    $printSection.innerHTML = "";
    $printSection.appendChild(domClone);
    window.print();
}

</script>