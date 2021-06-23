<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

	<style>
		td.details-control {
		    background: url('plus.jpg') no-repeat center center;
		    cursor: pointer;
		}
		tr.shown td.details-control {
		    background: url('minus.jpg') no-repeat center center;
		}	
	</style>

	<script>

	function format ( d ) {
	    // `d` is the original data object for the row	    
	    var response='<table cellpadding="5" class="table table-striped table-bordered" cellspacing="0" border="0" style="padding-left:50px;">';
	    response+='<th>Model</th>';
	    response+='<th>Make</th>';
	    response+='<th>OdoMeter</th>';
	    response+='<th>Plate No.</th>';
	    	
	    for(index=0;index<d.cars.length;index++){
	    	response+='<tr>';
	    	response+='<td>';
	    	response+=d.cars[index].model;
	    	response+='</td>';
	    	response+='<td>';
	    	response+=d.cars[index].make;
	    	response+='</td>';
	    	response+='<td>';
	    	response+=d.cars[index].odoMeter;
	    	response+='</td>';
	    	response+='<td>';
	    	response+=d.cars[index].plateNo;
	    	response+='</td>';
	    	response+='</tr>';
	    }
	    
	    response+='</table>';
	    
	    return response;
	}	
	
	$(document).ready(function() {
		
		//alert(getCookie("userID"));
		
		var table = $('#customerTable').DataTable( {
	    	  "ajax": {
	    		    "url": "../Invoice/webapi/customer",
	    		    "dataSrc":""
	    		  },responsive:true,
	    		  columns:[
	    	            {
	    	                "className":      'details-control',
	    	                "orderable":      false,
	    	                "data":           null,
	    	                "defaultContent": ''
	    	            },
	    			  {data:"firstName"},
	    			  {data:"lastName"},
	    			  {data:"email"},
	    			  {data:"mobilePhone"},
		   		    	{ 
		   		            "data": "customerID",
		   		            "render": function(data, type, row, meta){
		   		            	customerID=data;
		   		               if(type === 'display'){
		   		                   data = '<a data-toggle="modal" onclick="javascript:populateInvoices('+customerID+');" data-target="#viewinvoices"><img src="invoice.png" width="20" height="20"/></a>';
		   		               	   data += '&nbsp;&nbsp;<a data-toggle="modal" onclick="javascript:fetchCustomer('+customerID+');" data-target="#editCustomer"><span class="material-icons">mode_edit</span></a>';	
		   		               }
		   		               return data;
		   		            }
		   		         } 
	    		  ],
	    dom: '<"toolbar">frtip',
	    select:false
	    } );
		 $("div.toolbar").html('<a class="btn" data-toggle="modal" data-target="#createCustomer"><img src="add.png" width="27" height="27"/> Add Customer </a>');

	
		   $('#customerTable tbody').on('click', 'td.details-control', function () {
			   //alert('formatting');
		   
			   var tr = $(this).closest('tr');
		        var row = table.row( tr );
			    //alert('Hi');
		        if ( row.child.isShown() ) {
		            // This row is already open - close it
		            row.child.hide();
		            tr.removeClass('shown');
		        }
		        else {
		            // Open this row
		            row.child( format(row.data()) ).show();
		            tr.addClass('shown');
		        }
		    } );
	
	
	} );

	
	
	

	</script>
	<jsp:include page="viewcustomerinvoices.jsp" />  
	<jsp:include page="viewinvoice.jsp" />
	<jsp:include page="customerform.jsp" />
	<jsp:include page="editcustomer.jsp" /> 
	<br><br>
	<h2><img src="customer.png" width="50" height="50"/>&nbsp;&nbsp;&nbsp;Customer</h2>
	<br><br>
	<table id="customerTable" class="table table-striped table-bordered" style="width:100%">
        <thead>
            <tr>
            	<th></th>
                <th>First Name</th>
                <th>Last Name</th>
                <th>Email</th>
                <th>Phone Number</th>
                <th>View Invoices</th>
            </tr>
        </thead>
  	</table>
  	
 
