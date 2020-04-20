 <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="test.*,java.sql.ResultSet,java.sql.ResultSetMetaData"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/dt/dt-1.10.20/datatables.min.css" />
<link rel="stylesheet" type="text/css" href="../css/navBar.css">
<link rel="stylesheet" type="text/css" href="../css/makeReservationListReservations.css">
<title>Insert title here</title>
</head>
<body>
	<nav class="navbar">
		<a class="top topSelected" href="customerHome.jsp">Home</a> <a
			href="customerReservations.jsp">My Reservations</a> <a
			href="customerMakeReservation.jsp">Make Reservation</a> <a
			href="customerPersonalInformation.jsp">Personal Information</a> <a
			href="customerFlightPreferences.jsp">Flight Preferences</a> <a
			class="bot" href="../logout.jsp">Logout</a>
	</nav>
	<%
	
		DbManager db = new DbManager();
		ReservationData res = (ReservationData)session.getAttribute("reservation");
		res.b_fee = Math.floor(res.t_fare*.05 * 100) / 100;
		session.setAttribute("reservation",res);
	%>
	<div class="box">
	
		<section class="reservations">
			<h1>Confirm Reservation</h1>
			<p>Type: <%if(res.type.compareTo("roundTrip")==0) out.print("Round Trip"); else out.print("One Way");%></p>
			<p>Booking Fee: <%=res.b_fee%></p>
			<p>Travel Fee: <%=res.t_fare%></p>
			<h1>Total Price: <%=res.t_fare+res.b_fee%></h1>	
			
		
			
			<table id="legs" class="display">
				<thead>
					<tr>
						<th>Leg</th>
						<th>Flight Date</th>
						<th>Origin</th>
						<th>Destination</th>
						<th>Flight Num</th>
						<th>Airline</th>
						<th>Departure Time</th>
						<th>Arrival Time</th>
					</tr>
				</thead>
				<tbody>
					<%
					for(int i=0;i<res.legs.size();i++){
						%>
						<tr>
							<td><%=i+1%></td>
							<td><%=res.legs.get(i).flightDate%></td>
							<td><%=res.legs.get(i).fromAirport%></td>
							<td><%=res.legs.get(i).toAirport%></td>
							<td><%=res.legs.get(i).flightNumber%></td>
							<td><%=res.legs.get(i).airline%></td>
							<td><%=res.legs.get(i).departureTime%></td>
							<td><%=res.legs.get(i).arrivalTime%></td>
						</tr>
						<% 
					}
					%>
				</tbody>
			</table>
		
			<form method="post" action="insertReservationData.jsp">
				<h2>Enter the CCV code for your credit card number linked to
					your account</h2>
				<input type="number" name="ccv"> 
				<input type="submit" value="Confirm your Reservation">
			</form>
		</section>

	</div>
</body>

<script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
<script type="text/javascript" src="https://cdn.datatables.net/v/dt/dt-1.10.20/datatables.min.js"></script>
<script type="text/javascript">

	$(document).ready(function() {
		 $('#legs').DataTable();
	});
	
</script>
</html>