<link href="jquery.signaturepad.css" rel="stylesheet">
<style>

.modal-dialog {
 
          width: 800px;
 
          height:300px;
 
        }
</style>
	
	<script>
	
	var productList;
	var position=2;
	var isCustomerTaxable=true;
	
	$(document).ready(function() {
		//alert("Populating Products");
		populateProductDropDown('#selectProduct1');
		
	} );
	
	function populateProductDropDown(dropDownID){
		
		let dropdown = $(dropDownID);

		dropdown.empty();

		dropdown.append('<option selected="true" disabled>Choose Product</option>');
		dropdown.prop('selectedIndex', 0);

		const url = '../Invoice/webapi/product';

		// Populate dropdown with list of provinces
		$.getJSON(url, function (data) {
			productList=data;
		  $.each(data, function (key, entry) {
		    dropdown.append($('<option></option>').attr('value', entry.productID).text(entry.productName));
		  })
		});
		
	}
	
	function fillQty(id){

		_productID=document.getElementById("selectProduct"+id).value;
		
		var	result;		
			
		for (var i = 0; i < productList.length; i++){
			  if (productList[i].productID == _productID){
			     result=productList[i];
			     break;
			  }
			}			
			
			
		document.getElementById("price"+id).value=result.price;
		
		calculateAmount(id);

		calculateTax(id);	
	
	}
	
	function calculateTax(id){
		if(isCustomerTaxable!=0)
		{
			document.getElementById("californiaTax").value=0;
			document.getElementById("salesTax").value=0;
			
			totalAmount=0;
			//alert(position);
	
			for(var k=1;k<=position;k++){
			
				try {
					_productID=document.getElementById("selectProduct"+k).value;
					}
					catch(err) {
					  continue;
					}
				
	 			var amount=parseFloat(document.getElementById("amount"+k).value);
	 			totalAmount+=amount;
				
				var	result;		
					
				for (var i = 0; i < productList.length; i++){
					  if (productList[i].productID == _productID){
					     result=productList[i];
					     break;
					  }
					}	
				
				for(var i=0;i<result.taxIDs.length;i++){
					if(result.taxIDs[i].taxID==1){
		
						var salesTax=parseFloat(document.getElementById("salesTax").value);
			 			var salesTaxPercentage=parseFloat(result.taxIDs[i].percentage);
						
			 			amount=amount*salesTaxPercentage;
			 			
						salesTax=salesTax+amount;
						
						totalAmount+=salesTax;
						
						document.getElementById("salesTax").value=salesTax.toFixed(2);
			
					}else if (result.taxIDs[i].taxID==2){
						var californiaTax=parseFloat(document.getElementById("californiaTax").value);
						var californiaTaxPercentage=parseFloat(result.taxIDs[i].percentage);
						
			 			amount=amount*californiaTaxPercentage;
			 			
			 			californiaTax=californiaTax+amount;
			 			totalAmount+=californiaTax;
						
						document.getElementById("californiaTax").value=californiaTax.toFixed(2);
						
					}
				}
			}
			var labourCost=parseInt(document.getElementById("labourCost").value);
			totalAmount=totalAmount+labourCost;
			
			var recyclingCharges=parseInt(document.getElementById("recyclingCharges").value);
			totalAmount+=recyclingCharges;
			
			document.getElementById("totalAmount").value=totalAmount.toFixed(2);
		}
		
	}
	
	
	function calculateAmount(id){
		
		var unitPrice=document.getElementById("price"+id).value;
		var quantity=document.getElementById("quantity"+id).value
		
		if(unitPrice!=""){
			document.getElementById("amount"+id).value=unitPrice*quantity;
		}
		calculateTax(id);
	}
	
	function addRow(){
		var table = document.getElementById("products");
		var row = table.insertRow(position);
		
		var cell1 = row.insertCell(0);
		var cell2 = row.insertCell(1);
		var cell3 = row.insertCell(2);
		var cell4 = row.insertCell(3);
		var cell5 = row.insertCell(4);
		
		cell1.innerHTML = "<select class='form-control' id='selectProduct"+position+"' onchange='javascript:fillQty("+position+")'></select>";
		cell2.innerHTML="<input class='form-control' type='number' id='quantity"+position+"' onchange='javascript:calculateAmount("+position+")' value='0'/>";
		cell3.innerHTML="<input class='form-control' type='text' id='price"+position+"' value='0' readonly/>";
		cell4.innerHTML="<input class='form-control' type='number' id='amount"+position+"' value='0'/>";
		cell5.innerHTML="<a class='delete' title='Delete' data-toggle='tooltip' href='javascript:deleteRow("+position+")''><i class='material-icons'>&#xE872;</i></a>";
		
		populateProductDropDown("#selectProduct"+position);

		position=position+1;
		
	}
	
	function deleteRow(rowID){
		document.getElementById("products").deleteRow(rowID);
		//position=position-1;
	}

	function saveEstimate(){
		
		sign=document.getElementById("output").value;
		alert(sign);
		
		formData="";
		//alert("i am here");
		customerName=document.getElementById("customerName").value.split("-");
		
		// Customer Car Details//
		customerID=customerName[0];	
		model=document.getElementById("model").value;
		plateNo=document.getElementById("plateNo").value;
		odoMeter=document.getElementById("odometer").value;
		make=document.getElementById("make").value;
		
		// Summary Data
		salesTax=document.getElementById("salesTax").value;
		californiaTax=document.getElementById("californiaTax").value;
		labourCost=document.getElementById("labourCost").value;
		recyclingCharges=document.getElementById("recyclingCharges").value;
		totalAmount=document.getElementById("totalAmount").value;
		
		
		formData="{\"car\":{\"customerID\":"+ customerID;
		formData+=",\"model\":\""+ model +"\"";
		formData+=",\"plateNo\":\""+ plateNo +"\"";
		formData+=",\"odoMeter\":\""+ odoMeter +"\"";
		formData+=",\"make\":\""+ make +"\"},";
		
		//alert(formData);
		
		formData+="\"estimateProducts\":[";
		// Estimate Product Details
 		for(index=1;index<=position;index++){
			try {
				productID=document.getElementById("selectProduct"+index).value;
				quantity=document.getElementById("quantity"+index).value;
				price=document.getElementById("price"+index).value;
				amount=document.getElementById("amount"+index).value;
				
				if(index>1)
					formData+=",";
				
				formData+="{";
				formData+="\"productID\":"+productID;
				formData+=",\"quantity\":"+quantity;
				formData+=",\"amount\":"+amount;
				formData+=",\"price\":"+price;
				
				formData+=",\"product\":{\"productID\":"+ productID +"}";
				
				formData+="}";
			}
			catch(err) {
				continue;
			}
		} 
		formData+="]";
		
		formData+=",\"customer\":{\"customerID\":"+customerID+"}";
		
		formData+=",\"salesTax\":"+salesTax;
		formData+=",\"californiaTax\":"+californiaTax;
		formData+=",\"labourCost\":"+labourCost;
		formData+=",\"recyclingCharges\":"+recyclingCharges;
		formData+=",\"totalAmount\":"+totalAmount;
		
		formData+="}";
		
		document.getElementById("odometer").value=formData;
		
		//Submitting Request
		  var xhttp = new XMLHttpRequest();
		  xhttp.onreadystatechange = function() {
		    if (this.readyState == 4 && this.status == 200) {
		    	if(this.responseText=="1"){
		     		//document.getElementById("result").innerHTML = "Successfully added the Product!!!"
		     		//resetForm();
		     		alert("Estimate Added Successfully");
		     		document.getElementById("resetButton").click();
		     		$("#estimateTable").DataTable().ajax.reload();
		     		$('#createEstimate').modal('hide');

		    	}
	     		else{
	     			//document.getElementById("result").innerHTML ="Cannot add Customer at this time!!!";
	     		}
		     	
		     		
		     
		    }
		  };
		  xhttp.open("POST", "../Invoice/webapi/estimate", true);
		  xhttp.setRequestHeader("Content-Type", "application/json");
		  xhttp.send(formData); 
		
		
	}

	
	</script>



<div class="modal fade" id="createEstimate" role="dialog">
<form action="#" id="estimateForm" name="estimateForm">
	<div class="modal-dialog modal-dialog-scrollable modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header" style="background: rgba(25, 94, 148, 1);color:white">
				<h4 class="modal-title"> Create New Estimate </h4>
			</div>	
			<div class="modal-body yScroll">
				<div class="container">
					<div class="row">
						<div class="col-md-12">
							<div class="input-group mb-3">
								<input type="text" class="form-control" name="customerName" id="customerName" placeHolder="Select Customer" required readonly/>
								<div class="input-group-append">
									<button type="button" class="btn btn-outline-secondary" data-toggle="modal" data-target="#customerList">Search</button>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-md-6">
							<div class="form-group form-group-sm">
							<label for="model">Car Model</label>
							<input type="text" class="form-control input-sm" name="model" id="model" placeHolder="Car Model" required/>
							</div>
						</div>
						<div class="col-md-6">
							<div class="form-group form-group-sm">
							<label for="plateNo">License Plate</label>
							<input type="text" class="form-control input-sm" name="plateNo" id="plateNo" placeHolder="Car License Plate" required/>
							</div>
						</div>
					</div>				
					<div class="row">
						<div class="col-md-6">
							<div class="form-group form-group-sm">
							<label for="model">ODO Meter</label>
							<input type="number" class="form-control input-sm" name="odometer" id="odometer" placeHolder="ODO Meter Reading" required/>
							</div>
						</div>
						<div class="col-md-6">
							<div class="form-group form-group-sm">
							<label for="make">Make</label>
							<input type="text" class="form-control input-sm" name="make" id="make" placeHolder="Car Make" required/>
							</div>
						</div>
					</div>					
				</div>
			<br><br>	
			<div class="container"> 
			<button type="button" class="btn btn-info add-new" onclick="javascript:addRow()"><i class="fa fa-plus"></i>Add Product</button>
				<table id="products" class="table table-condensed">
			        <thead>
			            <tr>
			                <th>Product</th>
			                <th>Quantity</th>
			                <th>Unit Price</th>
			                <th>Amount	</th>
			                <th>&nbsp;&nbsp;</th>
			            </tr>
			        </thead>
			        	<tr>
			            	<td><select class="form-control" id="selectProduct1" onchange="javascript:fillQty('1')"><option> Choose Product </option></select></td>
			            	<td><input class="form-control" type="number" id="quantity1" onchange="javascript:calculateAmount('1')" value="0"/></td>
			            	<td><input class="form-control" type="text" id="price1" value="0" readonly/></td>
			            	<td><input class="form-control" type="number" id="amount1" value="0"/></td>
			            	<td>&nbsp;</td>
			            </tr>

				</table>
				
			</div>
		<div class="container">
			<div class="row">
			<div class="col-8">&nbsp;</div>
				<div class="col-4 align-items-end">
					<div class="input-group input-group-sm mb-3">
					  <div class="input-group-prepend">
					    <span class="input-group-text" id="inputGroup-sizing-sm">Sales Tax  </span>
					  </div>
					  <input class="form-control" type="text" id="salesTax" name="salesTax" value="0" readonly/>
					</div>				
				</div>
			</div>	

			<div class="row">
			<div class="col-8">&nbsp;</div>
				<div class="col-4">
					<div class="input-group input-group-sm mb-3">
					  <div class="input-group-prepend">
					    <span class="input-group-text" id="inputGroup-sizing-sm">California Tax</span>
					  </div>
					  <input class="form-control" type="text" id="californiaTax" name="californiaTax" value="0" readonly/>
					</div>				
				</div>
			</div>	

			<div class="row">
			<div class="col-8">&nbsp;</div>
				<div class="col-4">
					<div class="input-group input-group-sm mb-3">
					  <div class="input-group-prepend">
					    <span class="input-group-text" id="inputGroup-sizing-sm">Labour Cost</span>
					  </div>
					  <input class="form-control" type="text" id="labourCost" name="labourCost" value="0" onchange="javascript:calculateTax(0)"/>
					</div>				
				</div>
			</div>			

			<div class="row">
			<div class="col-8">&nbsp;</div>
				<div class="col-4">
					<div class="input-group input-group-sm mb-3">
					  <div class="input-group-prepend">
					    <span class="input-group-text" id="inputGroup-sizing-sm">Recycling Charges</span>
					  </div>
					  <input class="form-control" type="text" id="recyclingCharges" name="recyclingCharges" value="0" onchange="javascript:calculateTax(0)"/>
					</div>				
				</div>
			</div>	

			<div class="row">
			<div class="col-8">&nbsp;</div>
				<div class="col-4">
					<div class="input-group input-group-sm mb-3">
					  <div class="input-group-prepend">
					    <span class="input-group-text" id="inputGroup-sizing-sm">Total Amount</span>
					  </div>
					  <input class="form-control" type="text" id="totalAmount" name="totalAmount" value="0" readonly/>
					</div>				
				</div>
			</div>	

  <div class="sigPad">
    <ul class="sigNav">
      <li class="drawIt"><a href="#draw-it" class="current">Draw It</a></li>
      <li class="clearButton"><a href="#clear">Clear</a></li>
    </ul>
    <div class="sig sigWrapper">
      <div class="typed"></div>
      <canvas class="pad" width="400" height="400"></canvas>
      <input type="hidden" id="output" name="output" class="output">
     </div>
  </div>

		</div>			

		</div>
      <div class="modal-footer">
      <input type="reset" id="resetButton" class="btn btn-secondary" />
       <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" onclick="javascript:saveEstimate();">Save changes</button>
      </div>
	</div>
</div>
</form>

  <script src="jquery.signaturepad.js"></script>
  <script>
    $(document).ready(function() {
      $('.sigPad').signaturePad();
    });
  </script>
  <script src="json2.min.js"></script>
</div>