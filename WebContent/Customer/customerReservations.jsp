<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="test.*,java.sql.ResultSet"%>

	
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Home Page</title>
<link rel="stylesheet" type="text/css" href="../css/customerHome.css">
<link rel="stylesheet" type="text/css" href="../css/navBar.css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="//cdn.datatables.net/1.10.20/css/jquery.dataTables.min.css"/>

</head>
<body>
	<nav class="navbar">
		<a class="top topSelected" href="customerHome.jsp">Home</a> <a
			href="customerReservations.jsp">My Reservations</a> <a
			href="customerMakeReservation.jsp">Make Reservation</a> <a
			href="customerPersonalInformation.jsp">Personal Information</a> <a
			class="bot" href="../logout.jsp">Logout</a>
	</nav>
	<%
	DbManager db = new DbManager();
	
	Results reservations = db.getCustomerReservations((String)session.getAttribute("username"));
	ResultSet res = reservations.getResultSet();
	%>
	<h1>Flights for Reservation</h1>
	<%
	while(res.next()){
	%>
	<div>
		<p>Date Purchased: <%=res.getString(1)%></p>
		<p>Number of Passengers: <%=res.getString(2)%></p>
		<p>Trip Type: <%=res.getString(3)%></p>
		<p>Booking Fee: $<%=res.getString(4)%></p>
		<p>Travel Fare: $<%=res.getString(5)%></p>
	</div>
	
	<table class="reservations" class="display">
		<thead>
			<tr>
				<th>Date</th>
				<th>Origin</th>
				<th>Destination</th>
				<th>Flight Num.</th>
				<th>Airline</th>
				<th>Departure Time</th>
				<th>Arrival Time</th>
				<th>Class</th>
				<th>Dietary Restriction</th>
			</tr>
		</thead>
		<%
		Results legs = db.getCustomerReservationsLegs((String)session.getAttribute("username"), res.getInt(6));
		ResultSet legsData = legs.getResultSet();
		%>
		<tbody>
		<%while(legsData.next()){ %>
			<tr>
				<%for(int i=1; i<=9;i++){ %>
					<td><%=legsData.getString(i)%></td>
				<%} %>
			</tr>
		</tbody>
		<%}%>
	</table>
	<%
	}%> 
</body>


<script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
<script type="text/javascript" src="//cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
<script>
	$(".reservations").DataTable({
		"lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "All"]]
	});
</script>
</html>