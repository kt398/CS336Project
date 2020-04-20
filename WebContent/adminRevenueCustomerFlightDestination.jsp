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
<meta charset="ISO-8859-1">
<title>Revenue</title>
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
	<section class="listRevenues">
		<h1>List Revenues for Customer, Destination, or Flight</h1>
		<form name="searchByEmail" method="post"
			action="adminRevenueCustomerFlightDestination.jsp">
			<p>Enter Customer email</p>
			<input type="text" name="email" required>
			<button>Find Revenue!</button>
		</form>
		<form name="searchByFlight" method="post"
			action="adminRevenueCustomerFlightDestination.jsp">
			<p>Enter Flight Number and Airline ID</p>
			<input type="text" name="airlineID" required>
			<button>Find Revenue!</button>
		</form>
		<form name="searchByDestination" method="post"
			action="adminRevenueCustomerFlightDestination.jsp">
			<p>Enter Destination City</p>
			<input type="text" name="destination" required>
			<button>Find Revenue!</button>
		</form>
		<%
			DbManager db = new DbManager();
			Connection con = db.getConnection();
			if (request.getParameter("email") != null) {
				int totalFare = 0;
				String query = "SELECT firstName,lastName,email, date,bFee,tFare FROM Customers NATURAL JOIN Owns NATURAL JOIN contain NATURAL JOIN Reservations WHERE Customers.email=\""
						+ request.getParameter("email") + "\"";
				Statement stmt = con.createStatement();
				ResultSet rs = stmt.executeQuery(query);
		%>
		<div id="revenueByCustomer">
			<table id="revenue" class="display">
				<thead>
					<tr>
						<th>Customer Name</th>
						<th>Customer Email</th>
						<th>ReservationDate</th>
						<th>Booking Fee</th>
						<th>Travel Fare</th>
						<th>Total Fare</th>
					</tr>
				</thead>
				<tbody>
					<%
						while (rs.next()) {
					%>
					<tr>
						<td><%=rs.getString(1) + ", " + rs.getString(2)%></td>
						<%
							for (int i = 3; i <= 6; i++) {
						%>
						<td><%=rs.getString(i)%></td>
						<%
							}
									int totalFeeForRes = rs.getInt(5) + rs.getInt(6);
						%>
						<td><%=totalFeeForRes%></td>
						<td style="text-align: center"></td>
					</tr>
					<%
						totalFare += totalFeeForRes;
							}
					%>

				</tbody>
			</table>
			<br>
			<h1>
				Total Revenue: $<%=totalFare%></h1>
		</div>
		<%
			}
		%>





		<%
			if (request.getParameter("destination") != null) {
				String q1 = "select id from airports where city='" + request.getParameter("destination") + "'";

				Statement stmt = con.createStatement();
				ResultSet rs = stmt.executeQuery(q1);
				rs.next();
				String airportCode = rs.getString(1);
				String query = "select flightNum,airline,bFee,tFare from goTo natural Join goToLegs natural Join have natural join reservations where destinationAirportID=\""
						+ airportCode + "\"";
				rs = stmt.executeQuery(query);
				int totalFare = 0;
		%>
		<div id="flightsTable">
			<table id="revenue1" class="display">
				<thead>
					<tr>
						<th>Destination City</th>
						<th>Flight Number</th>
						<th>Airline</th>
						<th>Booking Fee</th>
						<th>Travel Fare</th>
						<th>Total Fare</th>
					</tr>
				</thead>
				<tbody>
					<%
						while (rs.next()) {
								int totalReservationFare = 0;
					%>
					<tr>
						<td><%=request.getParameter("destination")%></td>
						<%
							for (int i = 1; i <= 4; i++) {
						%>
						<td><%=rs.getString(i)%></td>
						<%
							}
									totalReservationFare = rs.getInt(3) + rs.getInt(4);
									totalFare += totalReservationFare;
						%>
						<td>$<%=totalReservationFare%></td>


						<td style="text-align: center"></td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
			<h1>
				Total Revenue: $<%=totalFare%></h1>
		</div>

		<%
			}
		%>
		<%
			if (request.getParameter("airlineID") != null) {
				Statement stmt = con.createStatement();
				String query = "select airline,flightNum,bFee,tFare from  goTo natural Join goToLegs natural Join have natural join reservations where airline='"
						+ request.getParameter("airlineID") + "'";
				ResultSet rs = stmt.executeQuery(query);
		%>
		<div id="flightsTable">
			<table id="revenue2" class="display">
				<thead>
					<tr>
						<th>Airline</th>
						<th>Flight Number</th>
						<th>Booking Fee</th>
						<th>Travel Fare</th>
						<th>Total Fare</th>
					</tr>
				</thead>
				<tbody>
					<%
						int totalFare = 0;
							while (rs.next()) {
								int totalReservationFare = 0;
					%>
					<tr>
						<%
							for (int i = 1; i <= 4; i++) {
						%>
						<td><%=rs.getString(i)%></td>
						<%
							}
									totalReservationFare = rs.getInt(3) + rs.getInt(4);
									totalFare += totalReservationFare;
						%>
						<td>$<%=totalReservationFare%></td>


						<td style="text-align: center"></td>
					</tr>
					<%
						}
					%>


				</tbody>
			</table>
			<h1>
				Total Revenue: $<%=totalFare%></h1>
		</div>

		<%
			}
		%>
	</section>


</body>
<script
	src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
<script type="text/javascript"
	src="//cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
<script type="text/javascript">
		$(document).ready(function() {
			$("#revenue").DataTable({
				"lengthMenu" : [ [ 10, 25, 50, -1 ], [ 10, 25, 50, "All" ] ]
			}); 
			$(document).ready(function() {
				$("#revenue1").DataTable({
					"lengthMenu" : [ [ 10, 25, 50, -1 ], [ 10, 25, 50, "All" ] ]
				}); 
			$(document).ready(function() {
				$("#revenue2").DataTable({
					"lengthMenu" : [ [ 10, 25, 50, -1 ], [ 10, 25, 50, "All" ] ]
				}); 

</script>
</html>