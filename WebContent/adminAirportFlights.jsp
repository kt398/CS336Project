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
		<a href="adminHome.jsp" >Home Page</a>
		<a href="adminCustomerTable.jsp" >Customer Information</a>
		<a href="adminSalesReport.jsp" >Sales Report</a>
		<a href="adminListFlights.jsp" >List of all Flights</a>
		<a href="#" >List of Reservations</a>
		<a href="#" >Summary listing of Revenue</a>
		<a href="adminAirportFlights.jsp" >Flights for Airports</a>
		<a href="login.jsp">Logout</a>
	</nav>
	<%
		DbManager db = new DbManager();
		Results r = db.getAllAirports();
		while (r == null) {
			r = db.getAllAirports();
		}
		ResultSet rs = r.getResultSet();
	%>
	<section class="airportFlights">
		<h1>Flights for Airports</h1>
		<form method="post" class="selectAirport" action="adminAirportFlights.jsp">
			<p>Select an Airport:</p>
			<select name="airport">
				<option>	</option>
				<%
					String s;
					while (rs.next()) {
						s = rs.getString("id");
				%>
				<option><%=s%></option>
				<%}%>
			</select>
			<button>List all flights</button>
		</form>
		<% 
		if(request.getParameter("airport")!= null){
			Results flights = db.getAirportFlights(request.getParameter("airport"));
			ResultSet fl = flights.getResultSet();
			%>
			<h1>Showing Flights for Airport: <%=request.getParameter("airport")%></h1>
			<table id="airportFlightsTable" class="display">
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
				while(fl.next()){
					%>
					<tr>
					<%
					for(int i=1;i<=8;i++){
						%><td><%=fl.getString(i)%></td>	
					<%
					}
					%>
					</tr>
				<%}%>
				</tbody>
			</table>
		<%}%>
	</section>
	
</body>


<script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
<script type="text/javascript" src="//cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
        $("#airportFlightsTable").DataTable({
    		"lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "All"]]
		});
	});
	
</script>

</html>