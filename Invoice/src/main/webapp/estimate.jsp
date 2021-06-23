
	<script>
	var estimateData;
	var estimateTable;
	$(document).ready(function() {
		estimateTable=$('#estimateTable').DataTable( {
	    	  "ajax": {
	    		    "url": "../Invoice/webapi/estimate",
	    		    "dataSrc":""
	    		  },responsive:true,
	    columns:[
	    	{data:"estimateNo"},
	    	{data:"creationDate"},
	    	{data:"customerName"},      
	    	{ 
	            "data": "estimateID",
	            "render": function(data, type, row, meta){
	               if(type === 'display'){
	                   data = '<a data-toggle="modal" onclick="javascript:populateEstimate('+data+');" data-target="#viewEstimate"><img src="estimates.png" width="20" height="20"/></a>';
	               }
	               return data;
	            }
	         } 
	    ],
	    dom: '<"etoolbar">frtip',
	    initComplete: function(){
	        $("div.etoolbar")
	           .html('<a class="btn" data-toggle="modal" data-target="#createEstimate"><img src="add.png" width="27" height="27"/> Add Estimate </a>');           
	     },  
	    select:true
	    } );

		
	} );
	</script>
	<jsp:include page="estimateform.jsp" />  
	<jsp:include page="customerlist.jsp" />
	<jsp:include page="customerform.jsp" />
	<jsp:include page="viewestimate.jsp" />
	<jsp:include page="viewinvoice.jsp" />	
	<jsp:include page="productlist.jsp" />
	<br><br>
	<h2><img src="estimates.png" width="50" height="50"/>&nbsp;&nbsp;&nbsp;Estimate</h2>
	<br><br>
	<table id="estimateTable" class="table table-striped table-bordered" style="width:100%">
        <thead>
            <tr>
                <th>Estimate Number</th>
                <th>Creation Date</th>
                <th>Customer Name</th>
                <th>View Estimate</th>
            </tr>
        </thead>
  	</table>