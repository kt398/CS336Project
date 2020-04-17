<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="test.*,java.sql.ResultSet,java.sql.ResultSetMetaData"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css"
	href="https://cdn.datatables.net/v/dt/dt-1.10.20/datatables.min.css" />
<link rel="stylesheet" type="text/css" href="../css/navBar.css">
<link rel="stylesheet" type="text/css"
	href="../css/makeReservationListReservations.css">
<title>Insert title here</title>
</head>
<body>
	<nav class="navbar">
		<ul>
			<li><a class="top" href="customerHome.jsp">Home</a></li>
			<li><a href="customerReservations.jsp">My Reservations</a></li>
			<li><a class="selected" href="customerMakeReservation.jsp">Make
					Reservation</a></li>
			<li><a href="customerPersonalInformation.jsp">Personal
					Information</a></li>
			<li><a href="customerFlightPreferences.jsp">Flight
					Preferences</a></li>
			<li><a class="bot" href="../login.jsp">Logout</a></li>
		</ul>
	</nav>
	<%
		String numPassengers=request.getParameter("numPassengers");
		String type=request.getParameter("type");
		type="?type="+type;
		System.out.println(type);
		String origin=request.getParameter("origin");
		String destination=request.getParameter("destination");
		String date=request.getParameter("date");
		DbManager db = new DbManager();
		Results r=db.getReservations(date, origin, destination);
		ResultSet rs=r.getResultSet();
		ResultSetMetaData rsmd = rs.getMetaData();
		int columnsNumber = rsmd.getColumnCount();
	%>
	<div class="box">
		<section class="reservations">
			<h1 class="header">Possible Flights</h1>
			<table id="reservations" class="display">
				<thead>
					<tr>
						<th>From</th>
						<th>Destination</th>
						<th>Date</th>
						<th>Airline</th>
						<th>Flight Number</th>
						<th>Departure Time</th>
						<th>Arrival Time</th>
						<th>Cost</th>
						<th>Select</th>
					</tr>
				</thead>
				<tbody>
					<% 
		while(rs.next()){
		%>
					<tr>
						<td><%=origin%></td>
						<td><%=destination%></td>
						<td><%=date%></td>
						<%
				for(int i=1; i<=columnsNumber; i++){
				%>
						<td><%=rs.getString(i)%></td>
						<%
				}
				%>
						<td style="text-align: center"><form id="reservationConfirmation"
								method="post" action="customerReservationConfirmation.jsp">
								<input id="custUser" style="display: none" name="username">
								<a type="submit" href="customerReservationConfirmation.jsp<%=type%>"> <img
									src="https://image.flaticon.com/icons/svg/61/61456.svg"
									height="10" width="10">
								</a>
							</form></td>
					</tr>
					<%
						
						}%>
				</tbody>
			</table>
		</section>
	</div>
</body>
<script
	src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
<script type="text/javascript"
	src="https://cdn.datatables.net/v/dt/dt-1.10.20/datatables.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#reservations").DataTable({
			"lengthMenu" : [ [ 10, 25, 50, -1 ], [ 10, 25, 50, "All" ] ]
		});
	});
</script>
</html>