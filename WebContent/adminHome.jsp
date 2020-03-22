<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

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
			<li><a href="#">Customer Information</a></li>
			<li><a href="#">Sales Report</a></li>
			<li><a href="#">List of all Flights</a></li>
			<li><a href="#">List of Reservations</a></li>
			<li><a href="#">Summary listing of Revenue</a></li>
			<li><a href="#">Flights for Airports</a></li>
		</ul>
	</nav>
	
	<div class="welcome">
		<p>Welcome!</p>
	</div>
	
	<div class="newAdmin">
		<p>Create a new administrative account</p>
		<form class="newAdmin" method="post" action="newAdmin.jsp">
			<input type="text" placeholder="username" name="username">
			<input type="password" placeholder="password" name="password">
			<button>Create</button>
		</form>
	</div>
	
	<div class="customerData">
	<p>Change customer database</p>
		<div class="container">
			<form action=""><input type="submit" value="Add" /></form>
			<form action=""><input type="submit" value="Delete" /></form>
			<form action=""><input type="submit" value="Edit" /></form>
		</div>
	</div>
	
	<div class="salesReport">
		<p>Sales Report</p>
	</div>
	
	<div class="allFlights">
		<p>List of all Flights</p>
	</div>
	
	<div class="listReservations">
		<p>List of all Reservations</p>
	</div>
	
	<div class="listingRevenue">
		<p>Summary listing of Revenue</p>
	</div>
	
	<div class="airportFlights">
		<p>Flights for Airports</p>
	</div>
	
</body>

<script type="text/javascript">
	$(document).ready(function(){
		
	});	
</script>

</html>