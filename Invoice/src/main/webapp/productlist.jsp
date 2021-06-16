	<script>
	var id;
	$(document).ready(function() {
		$('#productTable').DataTable( {
	    	  "ajax": {
	    		    "url": "../Invoice/webapi/product",
	    		    "dataSrc":""
	    		  },
	    		  columns:[
	    			  {data:"productID"},
	    			  {data:"productName"},
	    			  {data:"description"},
	    			  {data:"cost"},
	    			  {data:"price"}
	    		  ],
	    		    dom: 'frtip',
	    		    select:true
	    		    } );

 				$('#productTable').on('click','tr',function(){
 					var table=$('#productTable').DataTable();
 					var data=table.row(this).data();
					//productList=data;
 					document.getElementById("selectProduct"+id).value=data.productID+"-"+data.productName;
 					document.getElementById("price"+id).value=data.price;
 					//alert(data.taxIDs.length);
  					if(data.taxIDs.length>0){
 						for(index=0;index<data.taxIDs.length;index++){
 							if(data.taxIDs[index].taxID=="2"){
 								document.getElementById("salesTaxPercentage"+id).value=data.taxIDs[index].percentage;
 							}else if(data.taxIDs[index].taxID=="1"){
 								document.getElementById("californiaTaxPercentage"+id).value=data.taxIDs[index].percentage;
 							} 
 						}
 					} 
 					
 					//fillQty('1');
 					//alert(data.isTaxable);
 					if(data.isTaxable==0)
 						isproductTaxable=false;
 					else
 						isproductTaxable=true;
 					$('#productList').modal('hide');
 				});
	
	} );
	
	function setSelectBox(_selectBox){
		//alert(_selectBox);
		id=_selectBox;
	}

	</script>
<div class="modal fade" id="productList" role="dialog">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header" style="background: rgba(25, 94, 148, 1);color:white">
				<h4 class="modal-title"> Select product </h4>
			</div>	
			<div class="modal-body">

	<table id="productTable" class="table table-striped table-bordered" style="width:100%">
        <thead>
            <tr>
            	<th>Product ID</th>
                <th>Product Name</th>
                <th>Description</th>
                <th>Cost</th>
                <th>Unit Price</th>
            </tr>
        </thead>
  	</table>
  </div>
  </div>
 </div>
</div>
  	