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
<title>Choose Flight</title>
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
		String _numPassengers = request.getParameter("numPassengers");
		int numLegs = 1;//1 for 1,2 for 2,-1 for different date
		int numPassengers = Integer.parseInt(_numPassengers);
		boolean isRoundTrip=false;
		String type = request.getParameter("type");
		if(type.compareTo("roundTrip")==0)
			isRoundTrip=true;
		System.out.println(isRoundTrip);
		type = "?type=" + type;
		System.out.println(type);
		String origin = request.getParameter("origin");
		String destination = request.getParameter("destination");
		String date = request.getParameter("date");
		String returnDate="";
		if(type.compareTo("?type=roundTrip")==0){
			returnDate=request.getParameter("returnDate");
		}
		DbManager db = new DbManager();
		Results r = db.getFlights(date, origin, destination);
		ResultSet rs = r.getResultSet();
		
		if (!rs.first()) {
			numLegs = 2;
			System.out.println(numLegs);
			r.closeConnection();
			r = db.getTwoLegFlights(date, origin, destination);
		}
		
		else{
			rs.beforeFirst();
		}
		rs=r.getResultSet();
		if (rs == null) {
			numLegs = -1;
		}
		
		ResultSetMetaData rsmd = rs.getMetaData();
		int columnsNumber = rsmd.getColumnCount();
		double dateMultiplier = 1;
		int dayDifference = db.findDaysDifference(date);

		if (dayDifference > 30) {
			dateMultiplier = .8;
		} else if (dayDifference < 3) {
			dateMultiplier = 1.3;
		} else if (dayDifference < 14) {
			dateMultiplier = 1.1;
		}
		ReservationData res = new ReservationData();
		res.setDate(date);
		res.setPassengers(numPassengers);
		res.origin = origin;
		res.destination = destination;
		res.type = type;
		Legs leg=new Legs();
		System.out.println(type);
	%>
	<div class="box">
		<%
			if (numLegs == 1) {
		%>
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
						while (rs.next()) {
					%>
					<tr>
						<td><%=origin%></td>
						<td><%=destination%></td>
						<td><%=date%></td>
						<%
							int i = 1;
									for (i = 1; i < columnsNumber; i++) {
						%>
						<td><%=rs.getString(i)%></td>
						<%
							}
						%>
						<td>
							<%
								out.print(numPassengers * rs.getInt(i) * dateMultiplier);
							%>
						</td>
						<td style="text-align: center">

							<form class="reservationConfirmation" method="post" action="/submit">
								<%if(isRoundTrip){ %>
								<input type="hidden" name="origin" value="<%=destination%>">
								<input type="hidden" name="destination" value="<%=origin%>">
								<input type="hidden" name="numPassengers" value="1"> 
								<input type="hidden" name="date" value="<%=returnDate%>">
								<input id="custUser" type="hidden" style="display: none" name="username"value="<%out.print(rs.getRow());%>">
								<a type="submit" href="returnFlight.jsp"class="button"> 								
								<img
									src="https://image.flaticon.com/icons/svg/61/61456.svg"
									height="10" width="10"></a>
								
								<%}else{%>
								<input id="custUser" type="hidden" style="display: none" name="username"value="<%out.print(rs.getRow());%>">
								<a type="submit" href="customerHome.jsp" class="button"> 								<img
									src="https://image.flaticon.com/icons/svg/61/61456.svg"
									height="10" width="10"></a>
								<%}%>
							</form>
						</td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
		</section>
		<%
			} else if (numLegs == 2) {
		%>
		<section class="reservations">
			<h1 class="header">Possible Flights</h1>
			<table id="reservations" class="display">
				<thead>
					<tr>
						<th>Date</th>
						<th>Leg 1 From</th>
						<th>Leg 1 Airline</th>
						<th>Leg 1 Flight Number</th>
						<th>Leg 1 Departure Time</th>
						<th>Stop Arrival Time</th>
						<th>Stop Airport</th>
						<th>Leg 2 Airline</th>
						<th>Leg 2 Flight Number</th>
						<th>Leg 2 Departure Time</th>
						<th>Destination Arrival Time</th>
						<th>Destination Airport</th>
						<th>Cost</th>
						<th>Select</th>
					</tr>
				</thead>
				<tbody>
					<%
						while (rs.next()) {
					%>
					<tr>

						<%
							int i = 1;
								for (i=1; i <columnsNumber; i++) {
						%>
						<td><%=rs.getString(i)%></td>
						<%
							}
						%>
						<td>
							<%
								out.print( Math.floor((numPassengers * rs.getInt(i) * dateMultiplier)/100)*100);
							%>
						</td>
						<td style="text-align: center">

							<form class="reservationConfirmation" method="post">
								<%if(isRoundTrip){ %>
								<input type="hidden" name="origin" value="<%=destination%>">
								<input type="hidden" name="destination" value="<%=origin%>">
								<input type="hidden" name="numPassengers"
									value="<%=numPassengers%>"> <input type="hidden"
									name="date" value=<%=returnDate%>>
								<%}%>
								<input id="custUser" style="display: none" name="username"
									value="<%out.print(rs.getRow());%>"> <a type="submit"
									href="#" onclick="nextPage()"> <img
									src="https://image.flaticon.com/icons/svg/61/61456.svg"
									height="10" width="10">
								</a>
							</form>
						</td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
		</section>
		<%
		}%>
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
	$('.reservationConfirmation a').click(function(){
		alert('hello');
		<%session.setAttribute("results", r);
		if(!isRoundTrip){
			%>
			form('.reservationConfirmation').submit();
		<%
		}
		else if(isRoundTrip){
		%>	
			form('.reservationConfirmation').submit();
		<%
		}
		%>
	});
</script>

</html>