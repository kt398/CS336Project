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
<link rel="stylesheet" type="text/css"
	href="//cdn.datatables.net/1.10.20/css/jquery.dataTables.min.css" />

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
	<section class="activeFlights">
		<%
			DbManager manager = new DbManager();
			Connection con = manager.getConnection();
			String statement = "select airline,flightNum,count(airline) as 'Bookings' from goToLegs NATURAL JOIN goTo group by airline,flightNum order by 'Bookings' desc";
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(statement);
		%>
		<div class="table" style="text-align: center">
			<table id="flightTable" class="display">
				<thead>
					<tr>
						<th>Airline</th>
						<th>Flight Number</th>
						<th>Bookings</th>
					</tr>
				</thead>
				<%
					while (rs.next()) {
				%>

				<tr>
					<%
						for (int i = 1; i <= 3; i++) {
					%>
					<td><%=rs.getString(i)%></td>
					<%
						}
					%>
					<td style="text-align: center">
						<%
							}
							con.close();
						%>
					
			</table>










		</div>
	</section>

	<script
		src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
	<script type="text/javascript"
		src="//cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#flightTable").DataTable({
				"lengthMenu" : [ [ 10, 25, 50, -1 ], [ 10, 25, 50, "All" ] ]
			});
			$("#flightTable").fadeIn();
		});
	</script>
</html>