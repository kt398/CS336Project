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
		<a href="adminHome.jsp" >Home</a>
		<a href="adminCustomerTable.jsp" >Customers</a>
		<a href="adminSalesReport.jsp" >Sales Report</a>
		<a href="adminListFlights.jsp" >All Flights</a>
		<a href="adminActiveFlights.jsp">Active Flights</a>
		<a href="adminReservations.jsp" >Reservations</a>
		<a href="adminRevenueCustomerFlightDestination.jsp" >Revenue Summary</a>
		<a href="adminAirportFlights.jsp" >Airport Flights</a>
		<a href="login.jsp">Logout</a>
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
	
</body>


<script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
<script type="text/javascript">

	
</script>

</html>