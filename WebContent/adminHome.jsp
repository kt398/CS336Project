<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page
	import="test.*,java.sql.Connection,
 java.sql.DriverManager,
 java.sql.ResultSet,
 java.sql.SQLException,
 java.sql.Statement"%>

<!DOCTYPE html>
<html>
<head>
<title>Home Page [Admin]</title>
<link rel="stylesheet" type="text/css" href="css/adminHome.css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>

<body>
	<nav class="navbar">
		<ul>
			<li><a class="adminHome" href="adminHome.jsp" >Home Page</a></li>
			<li><a class="newAdmin" href="adminCreateAdmin.jsp" >Add Admin</a></li>
			<li><a class="customerData" href="adminCustomerTable.jsp" >Customer Information</a></li>
			<li><a class="salesReport" href="adminSalesReport.jsp" >Sales Report</a></li>
			<li><a class="allFlights" href="adminListFlights.jsp" >List of all Flights</a></li>
			<li><a class="listReservations" href="#" >List of Reservations</a></li>
			<li><a class="listingRevenue" href="#" >Summary listing of Revenue</a></li>
			<li><a class="airportFlights" href="adminAirportFlights.jsp" >Flights for Airports</a></li>
			<li><a href="login.jsp">Logout</a></li>
		</ul>
	</nav>
	
	<section class="adminHome">
		<h1>Welcome!</h1>
	</section>
	
	<section class="newAdmin">
		<p>Create a new Administrative Account</p>
		<div class="container">
			<form class="newAdmin" method="post" action="newAdmin.jsp">
				<input type="text" placeholder="username" name="username">
				<input type="password" placeholder="password" name="password">
				<button>Create</button>
			</form>
		</div>
		
	</section>
	

	<section class="listReservations">
		<h1>List of all Reservations</h1>
	</section>
	
	<section class="listingRevenue">
		<h1>Summary listing of Revenue</h1>
	</section>
	
</body>


<script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
<script type="text/javascript">

	
</script>

</html>