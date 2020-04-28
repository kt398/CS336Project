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
<link rel="stylesheet" type="text/css" href="//cdn.datatables.net/1.10.20/css/jquery.dataTables.min.css" />
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
		<a href="logout.jsp">Logout</a>
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
			DbManager db = new DbManager();
			Connection con = db.getConnection();
			if (request.getParameter("val") != null) {
				String query = "SELECT date, passengers, cRep,bFee,tFare,resNum FROM Customers NATURAL JOIN Owns NATURAL JOIN contain NATURAL JOIN Reservations WHERE Customers.email=\""
						+ request.getParameter("val") + "\"";
				Statement stmt = con.createStatement();
				ResultSet rs = stmt.executeQuery(query);
		%>
		<div id="emailTable">
			<table id="reservationByEmail" class="display">
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
						}
						%>
					</tr>	
				</tbody>
			</table>

		</div>
		<%
			}
		%>

		<%
			if (request.getParameter("flightNum") != null) {
				String query = "SELECT date, passengers, cRep,bFee,tFare,resNum FROM flights NATURAL JOIN associated NATURAL JOIN legs NATURAL JOIN have NATURAL JOIN reservations WHERE flights.flightNum=\""
						+ request.getParameter("flightNum") + "\" AND flights.airline=\""
						+ request.getParameter("airlineID") + "\"";
				Statement stmt = con.createStatement();
				ResultSet rs = stmt.executeQuery(query);
		%>
		<div id="flightsTable">
			<table id="reservationByFlightNum" class="display">
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
						}
						%>
					</tr>
				</tbody>
			</table>
		</div>
		<%
			}
		%>
	</section>
<script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
<script type="text/javascript" src="//cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
<script type="text/javascript">
		$(document).ready(function() {
			$("#reservationByEmail").DataTable({
				"lengthMenu" : [ [ 10, 25, 50, -1 ], [ 10, 25, 50, "All" ] ]
			});

			$("#reservationByFlightNum").DataTable({
				"lengthMenu" : [ [ 10, 25, 50, -1 ], [ 10, 25, 50, "All" ] ]
			});
		});

		$('.searchByEmail').submit(function() {
			$('#emailTable').show();
			$('#flightsTable').hide();
			return false;
		});
		$('.searchByFlight').submit(function() {
			$('#emailTable').hide();
			$('#flightsTable').show();
			return false;
		});
	</script>
</html>