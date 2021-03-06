<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="test.*,java.sql.ResultSet,java.sql.ResultSetMetaData,java.util.ArrayList"%>


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
		<a class="top topSelected" href="customerHome.jsp">Home</a> <a
			href="customerReservations.jsp">My Reservations</a> <a
			href="customerMakeReservation.jsp">Make Reservation</a> <a
			href="customerPersonalInformation.jsp">Personal Information</a> <a
			class="bot" href="../logout.jsp">Logout</a>
	</nav>
	<%
		ArrayList<Integer> list=new ArrayList<Integer>();
		int numLegs = 1;//1 for 1,2 for 2,-1 for different date
		int numPassengers = Integer.parseInt(request.getParameter("numPassengers"));
		boolean isRoundTrip = false;
		String type = request.getParameter("type");
		if (type.compareTo("roundTrip") == 0)
			isRoundTrip = true;
		String food=request.getParameter("food");
		String origin = request.getParameter("origin");
		String destination = request.getParameter("destination");
		String date = request.getParameter("date");
		String returnDate = "";
		if (type.compareTo("roundTrip") == 0) {
			returnDate = request.getParameter("returnDate");
		}

		DbManager db = new DbManager();
		Results r = db.getFlights(date, origin, destination);
		ResultSet rs = r.getResultSet();
		System.out.println(date);
		if (!rs.first()) {
			numLegs = 2;
			r.closeConnection();
			r = db.getTwoLegFlights(date, origin, destination);
		} else {
			rs.beforeFirst();
		}
		rs = r.getResultSet();
		if (!rs.first()) {
			numLegs=1;
			String dateOffset = db.offsetDate(date, 1);
			System.out.println(dateOffset);
			r = db.getFlights(dateOffset, origin, destination);
			rs = r.getResultSet();
			if (!rs.first()) {
				r = db.getTwoLegFlights(dateOffset, origin, destination);
				rs = r.getResultSet();
			} else {
				rs.beforeFirst();
				date = dateOffset;
			}
		} else{
			rs.beforeFirst();
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
		res.food=food;
		res.setPassengers(numPassengers);
		res.origin = origin;
		res.destination = destination;
		res.type = type;
		res.goDate = date;
		res.returnDate = returnDate;
		Legs leg = new Legs();
		Legs leg2 = new Legs();
		double flightClass = Double.parseDouble(request.getParameter("class"));
		switch (request.getParameter("class")) {
			case "0.9" :
				res.flightClass = "Economy";
				break;
			case "1.0" :
				res.flightClass = "Business";
				break;
			case "1.1" :
				res.flightClass = "First Class";
				break;
		}
		res.flightClassMult = flightClass;
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
							list.add((int)(Math.random()*50)-25);
							out.print((Math.floor((flightClass*numPassengers * rs.getInt(i) * dateMultiplier) / 100) * 100)+list.get(list.size()-1));
							res.t_fare = ((Math.floor((flightClass*numPassengers * rs.getInt(i) * dateMultiplier) / 100) * 100));
							%>
						</td>
						<td style="text-align: center">

							<form id="reservationConfirmation" method="post"
								action="dataStorage.jsp">
								<input type="hidden" name="origin" value="<%=origin%>">
								<input type="hidden" name="destination" value="<%=destination%>">
								<input type="hidden" name="numPassengers"
									value="<%=numPassengers%>"> <input type="hidden"
									name="date" value="<%=returnDate%>"> <input id="rowNum"
									type="hidden" name="rowNumber" value="<%=rs.getRow()%>">
								<a href="#"><img
									src="https://image.flaticon.com/icons/svg/61/61456.svg"
									height="10" width="10"></a>
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
						<td><%=date%></td>
						<%
							int i = 1;
									for (i = 1; i < columnsNumber - 1; i++) {
						%>
						<td><%=rs.getString(i)%></td>
						<%
							}
						%>
						<td>
							<%
							list.add((int)(Math.random()*50)-25);
							out.print((Math.floor((flightClass*numPassengers * rs.getInt(i) * dateMultiplier) / 100) * 100)+list.get(list.size()-1));
							res.t_fare = ((Math.floor((flightClass*numPassengers * rs.getInt(i) * dateMultiplier) / 100) * 100));
							%>
						</td>
						<td style="text-align: center">
							<form id="reservationConfirmation2" method="post"
								action="dataStorage.jsp">
								<input type="hidden" name="origin" value="<%=origin%>">
								<input type="hidden" name="destination" value="<%=destination%>">
								<input type="hidden" name="numPassengers"value="<%=numPassengers%>"> 
								<input type="hidden" name="date" value="<%=returnDate%>"> 
								<input id="rowNum" type="hidden" name="rowNumber" value="<%=rs.getRow()%>">
								<input type="hidden" name="multipleLegs" value="multipleLegs">
								<a href="#"><img
									src="https://image.flaticon.com/icons/svg/61/61456.svg"
									height="10" width="10"></a>
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
			}
		%>
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

	$('#reservationConfirmation a')
			.click(
					function() {
<%session.setAttribute("reservation", res);
			leg.fromAirport = origin;
			leg.toAirport = destination;
			leg.flightDate = date;
			session.setAttribute("leg1", leg);
			session.setAttribute("randomPrices",list);%>
	$('#rowNum').val(
								$(this).parent().closest("tr").index('tr'));
						$('#reservationConfirmation').submit();
					});
	
	$('#reservationConfirmation2 a')
			.click(
					function() {
<%session.setAttribute("reservation", res);
			leg.fromAirport = origin;
			leg.flightDate = date;
			leg2.flightDate = date;
			session.setAttribute("leg1", leg);
			session.setAttribute("leg2", leg2);
			session.setAttribute("randomPrices",list);%>
	$('#rowNum').val(
								$(this).parent().closest("tr").index('tr'));
						$('#reservationConfirmation2').submit();
					});
</script>

</html>