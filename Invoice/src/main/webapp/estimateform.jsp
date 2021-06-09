<style>

.modal-dialog {
 
          width: 800px;
 
          height:300px;
 
        }
</style>
	
	<script>
	
	var productList;
	var position=2;
	
	$(document).ready(function() {
		populateProductDropDown('#selectProduct1')
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
		
		document.getElementById("californiaTax").value=0;
		document.getElementById("salesTax").value=0;
		
		//alert(position);

		for(var k=1;k<=position;k++){
		
			try {
				_productID=document.getElementById("selectProduct"+k).value;
				}
				catch(err) {
				  continue;
				}
			
 			var amount=parseFloat(document.getElementById("amount"+k).value);
			
			var	result;		
				
			for (var i = 0; i < productList.length; i++){
				  if (productList[i].productID == _productID){
				     result=productList[i];
				     break;
				  }
				}	
			
			for(var i=0;i<result.taxIDs.length;i++){
				if(result.taxIDs[i]==1){
	
					var salesTax=parseFloat(document.getElementById("salesTax").value);
		 			
		 			amount=amount*0.0018;
		 			
					salesTax=salesTax+amount;
					
					document.getElementById("salesTax").value=salesTax.toFixed(2);
		
				}else if (result.taxIDs[i]==2){
					var californiaTax=parseFloat(document.getElementById("californiaTax").value);
		 			
		 			amount=amount*0.0027;
		 			
		 			californiaTax=californiaTax+amount;
					
					document.getElementById("californiaTax").value=californiaTax.toFixed(2);
					
				}
			}
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
	
	</script>

<div class="modal fade" id="createEstimate" tabindex="-1"  role="dialog">
	<div class="modal-dialog modal-dialog-scrollable modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header" style="background: rgba(25, 94, 148, 1);color:white">
				<h4 class="modal-title"> Create New Estimate </h4>
			</div>	
			<div class="modal-body yScroll">
			<div class="jumbotron">
				<div class="container">
				<div class="container text-center">
					<h3>Customer Details</h3>
				</div>
					<div class="row">
						<div class="col-md-12">
							
							<div class="input-group mb-3">
								<input type="text" class="form-control" name="customerName" id="customerName" placeHolder="Select Customer" required/>
								<div class="input-group-append">
									<button type="button" class="btn btn-outline-secondary" data-toggle="modal" data-target="#customerList">Search</button>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-md-6">
							<label for="model">Car Model</label>
							<input type="text" class="form-control input-sm" name="model" id="model" placeHolder="Car Model" required/>
						</div>
						<div class="col-md-6">
							<label for="plateNo">License Plate</label>
							<input type="text" class="form-control input-sm" name="plateNo" id="plateNo" placeHolder="Car License Plate" required/>
						</div>
					</div>				
					<div class="row">
						<div class="col-md-6">
							<label for="model">ODO Meter</label>
							<input type="text" class="form-control input-sm" name="model" id="model" placeHolder="ODO Meter Reading" required/>
						</div>
						<div class="col-md-6">
							<label for="make">Make</label>
							<input type="text" class="form-control input-sm" name="make" id="make" placeHolder="Car Make" required/>
						</div>
					</div>					
				</div>
				</div>
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
			            <tr>
			            	<td><select class="form-control" id="selectProduct1" onchange="javascript:fillQty('1')"><option> Choose Product </option></select></td>
			            	<td><input class="form-control" type="number" id="quantity1" onchange="javascript:calculateAmount('1')" value="0"/></td>
			            	<td><input class="form-control" type="text" id="price1" value="0" readonly/></td>
			            	<td><input class="form-control" type="number" id="amount1" value="0"/></td>
			            	<td><a class="delete" title="Delete" data-toggle="tooltip" href="javascript:deleteRow('1')"><i class="material-icons">&#xE872;</i></a></td>
			            </tr>
			        </thead>
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
			
		</div>			
	

		</div>
      <div class="modal-footer">
       <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div>
	</div>
</div>
</div>