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
<link rel="stylesheet" type="text/css" href="//cdn.datatables.net/1.10.20/css/jquery.dataTables.min.css"/>

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

	<section class="allFlights">
		<h1>List of All Flights</h1>
		<%
		DbManager db = new DbManager();
		Connection con = db.getConnection();
		String query = "SELECT * FROM goTo limit 50000"; //LIMITED TO 50000 couldn't load 100,000 entries
		Statement stmt = con.createStatement();
		ResultSet rs = stmt.executeQuery(query);
		rs.setFetchSize(1000);
		%>
		<table id="flightTable" class="display" style="display:none">
			<thead>
				<tr>
					<th>Flight Num.</th>
					<th>Airline</th>
					<th>Origin</th>
					<th>Destination</th>
					<th>Distance</th>
					<th>Day of Week</th>
					<th>Arrival Time</th>
					<th>Departure Time</th>
				</tr>
			</thead>
			<tbody>
		<% 
		while(rs.next()){
		%>
			<tr>
				<%for(int i=1; i<=8; i++){%>
					<td><%=rs.getString(i)%></td>
				<%}%>
			</tr>
		<%
		}
		rs.close();
		%>
		</tbody>
		</table>
		
	</section>
	

<script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
<script type="text/javascript" src="//cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
<script type="text/javascript">
    $(document).ready(function(){
        $("#flightTable").DataTable({
    		"lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "All"]]
		});
    	$("#flightTable").fadeIn();
    });    
</script>

</html>