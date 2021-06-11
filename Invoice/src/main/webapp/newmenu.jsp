<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

  	<% 
  		String _page=request.getParameter("show");
  		String pageName="";
  		if(_page!=null){
	  		switch (_page){
	  		case "customer":
	  			pageName="customer.jsp";
	  			break;
	  		case "product":
	  			pageName="productform.jsp";
	  			break;
	  		case "estimate":
	  			pageName="estimate.jsp";
	  			break;	
	  		}
  		}else{
  			pageName="customer.jsp";
  			_page="customer";
  		}
  	%>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Invoice Management</title>

	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"/>
  
	<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/bs4-4.1.1/jq-3.3.1/dt-1.10.24/af-2.3.6/b-1.7.0/b-colvis-1.7.0/r-2.2.7/rg-1.1.2/rr-1.2.7/sc-2.0.3/sb-1.0.1/sp-1.2.2/sl-1.3.3/datatables.min.css"/>
 
	<script type="text/javascript" src="https://cdn.datatables.net/v/bs4-4.1.1/jq-3.3.1/dt-1.10.24/af-2.3.6/b-1.7.0/b-colvis-1.7.0/r-2.2.7/rg-1.1.2/rr-1.2.7/sc-2.0.3/sb-1.0.1/sp-1.2.2/sl-1.3.3/datatables.min.js"></script>

	<link rel="canonical" href="https://getbootstrap.com/docs/5.0/examples/sidebars/">

	<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">

	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
 
 <script src="formToJson.js"></script>
 
 <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
   <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round|Open+Sans">
    
    <style>
      .bd-placeholder-img {
        font-size: 1.125rem;
        text-anchor: middle;
        -webkit-user-select: none;
        -moz-user-select: none;
        user-select: none;
      }
      .yScroll{
			overflow-y:auto;
			height:400px;
		}

      @media (min-width: 768px) {
        .bd-placeholder-img-lg {
          font-size: 3.5rem;
        }
      }
  .table.dataTable  {
    font-family: Verdana, Geneva, Tahoma, sans-serif;
    font-size: 13px;
    
	}
	.etoolbar {
	    float:left;
	}
	.toolbar {
	    float:left;
	}
	table thead{
	  background-color: rgba(25, 94, 148, 1);
	  color:white;
	}  
 
    </style>

	<link href="sidebars.css" rel="stylesheet">
	
<style>
body {
  margin: 0;
  font-family: "Lato", sans-serif;
}

.sidebar {
  margin: 0;
  padding: 0;
  width: 200px;
  background-color: rgba(25, 94, 148, 1);
  position: fixed;
  height: 100%;
  overflow: auto;
}

.sidebar a {
  display: block;
  color: white;
  padding: 16px;
  text-decoration: none;
}
 
.sidebar a.active {
  background-color: white;
  color: black;
}

.sidebar a:hover:not(.active) {
  background-color: #fff;
  color: black;
}

div.content {
  margin-left: 200px;
  padding: 1px 16px;
  height: 1000px;
}

@media screen and (max-width: 700px) {
  .sidebar {
    width: 100%;
    height: auto;
    position: relative;
  }
  .sidebar a {float: left;}
  div.content {margin-left: 0;}
}

@media screen and (max-width: 400px) {
  .sidebar a {
    text-align: center;
    float: none;
  }
}
</style>
</head>
<body>

<div class="sidebar">
<h4><font color="white">BEST AMERICAN TYRES WORK</font></h4>
<br/>
<br/>
  <a class="<%=_page.equals("customer")?"active":""%>" href="newmenu.jsp?show=customer"><img src="customer.png" width="27" height="27"/>&nbsp;&nbsp;Customer</a>
  <a class="<%=_page.equals("product")?"active":""%>" href="newmenu.jsp?show=product"><img src="products.png" width="27" height="27"/>&nbsp;&nbsp;Product</a>
  <a class="<%=_page.equals("estimate")?"active":""%>" href="newmenu.jsp?show=estimate"><img src="estimates.png" width="27" height="27"/>&nbsp;&nbsp;Estimate</a>
  <a class="<%=_page.equals("invoice")?"active":""%>" href="newmenu.jsp?show=invoice"><img src="invoice.png" width="27" height="27"/>&nbsp;&nbsp;Invoice</a>
</div>

<div class="content">
<jsp:include page="<%=pageName%>"/>
</div>

</body>
</html>