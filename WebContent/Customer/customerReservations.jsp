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
</head>
<body>
	<nav class="navbar">
		<ul>
			<li><a class="top topSelected" href="customerHome.jsp">Home</a></li>
			<li><a href="customerReservations.jsp" >My Reservations</a></li>
			<li><a href="customerMakeReservation.jsp">Make Reservation</a></li>
			<li><a href="customerPersonalInformation.jsp">Personal Information</a></li>
			<li><a href="customerFlightPreferences.jsp">Flight Preferences</a></li>
			<li><a class="bot" href="../login.jsp">Logout</a></li>
		</ul>
	</nav>
	<%
	DbManager db = new DbManager();
	Results legs = db.getCustomerReservationsLegs((String)session.getAttribute("username"));
	ResultSet legsData = legs.getResultSet();
	
	Results reservations = db.getCustomerReservations((String)session.getAttribute("username"));
	ResultSet res = reservations.getResultSet();
	%>
	<h1>Flights for Reservation</h1>
	<%
	while(res.next()){
	%>
	<div class="reservations">
		<p>Date Purchased: <%=res.getString(1)%></p>
		<p>Number of Passengers: <%=res.getString(2)%></p>
		<p>Trip Type: <%=res.getString(3)%></p>
		<p>Booking Fee: $<%=res.getString(4)%></p>
		<p>Travel Fare: $<%=res.getString(5)%></p>
	</div>
	
	<table>
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
				<th>Seat Num</th>
			</tr>
		</thead>
		
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

</script>
</html>