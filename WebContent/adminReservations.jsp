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
<title>List of Reservations</title>
<link rel="stylesheet" type="text/css" href="css/adminHome.css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css"
	href="//cdn.datatables.net/1.10.20/css/jquery.dataTables.min.css" />
</head>

<body>
	<nav class="navbar">
		<a href="adminHome.jsp">Home</a> <a href="adminCustomerTable.jsp">Customers</a>
		<a href="adminSalesReport.jsp">Sales Report</a> <a
			href="adminListFlights.jsp">All Flights</a> <a
			href="adminReservations.jsp">Reservations</a> <a href="#">Revenue
			Summary</a> <a href="adminAirportFlights.jsp">Airport Flights</a> <a
			href="login.jsp">Logout</a>
	</nav>

	<section class="listReservations">
		<h1>List of Reservations</h1>
		<form name="searchByEmail" method="post"
			action="adminReservations.jsp">
			<p>Enter Customer email</p>
			<input type="text" name="val" required>
			<button>Find Reservations!</button>
		</form>
		<br>
		<form name="searchByEmail" method="post"
			action="adminReservations.jsp">
			<p>Enter Flight Number and Airline ID</p>
			<input type="text" name="flightNum" required> <input
				type="text" name="airlineID" required>
			<button>Find Reservations!</button>
		</form>
		<%
			if (request.getParameter("val") != null) {
				DbManager db = new DbManager();
				Connection con = db.getConnection();
				String query = "SELECT date, passengers, cRep,bFee,tFare,resNum FROM Customers NATURAL JOIN Owns NATURAL JOIN Reservations WHERE customer.email=\""
						+ request.getParameter("val") + "\"";
				Statement stmt = con.createStatement();
				ResultSet rs = stmt.executeQuery(query);
		%>
		<div id="emailTable">
			<table id="customerTable" class="display">
				<thead>
					<tr>
						<th>Reservation Date</th>
						<th>Number Of Passengers</th>
						<th>Customer Representative ID</th>
						<th>Booking Fee</th>
						<th>Travel Fare</th>
						<th>Reservation Number</th>
					</tr>
				</thead>
				<tbody>
					<%
						while (rs.next()) {
					%>
					<tr>
						<%
							for (int i = 1; i <= 6; i++) {
						%>
						<td><%=rs.getString(i)%></td>
						<%
							}
						%>
						<td style="text-align: center">
							<%
								}
							%>
						
				</tbody>
			</table>

		</div>
		<%
			}
		%>

		<%
			if (request.getParameter("val3") != null) {
				DbManager db = new DbManager();
				Connection con = db.getConnection();
				String query = "SELECT date, passengers, cRep,bFee,tFare,resNum FROM flights NATURAL JOIN associated NATURAL JOIN legs NATURAL JOIN have NATURAL JOIN reservations WHERE flights.flightNum=\""
						+ request.getParameter("airline") + "\" AND flights.airlineID=\""
						+ request.getParameter("airlineID");
				Statement stmt = con.createStatement();
				ResultSet rs = stmt.executeQuery(query);
		%>
		<div id="emailTable">
			<table id="customerTable" class="display">
				<thead>
					<tr>
						<th>Reservation Date</th>
						<th>Number Of Passengers</th>
						<th>Customer Representative ID</th>
						<th>Booking Fee</th>
						<th>Travel Fare</th>
						<th>Reservation Number</th>
					</tr>
				</thead>
				<tbody>
					<%
						while (rs.next()) {
					%>
					<tr>
						<%
							for (int i = 1; i <= 6; i++) {
						%>
						<td><%=rs.getString(i)%></td>
						<%
							}
						%>
						<td style="text-align: center">
							<%
								}
							%>
				</tbody>
			</table>
		</div>
		<%
			}
		%>
	</section>
	<script
		src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
	<script type="text/javascript"
		src="//cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
	<script type="text/javascript">

    $(document).ready(function(){
        $("#").DataTable({
    		"lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "All"]]
		});
    });    
	$('.searchByEmail').submit(function(){
		$('#emailTable').show();
		$('#flightsTable').hide();
	}
	$('.searchByFlight').submit(function(){
		$('#emailTable').hide();
		$('#flightsTable').show();
	}
</script>
</html>