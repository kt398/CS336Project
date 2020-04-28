
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page
	import="test.*,java.sql.ResultSet,java.sql.ResultSetMetaData,java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css"
	href="https://cdn.datatables.net/v/dt/dt-1.10.20/datatables.min.css" />
<link rel="stylesheet" type="text/css" href="../css/navBar.css">
<link rel="stylesheet" type="text/css"
	href="../css/makeReservationListReservations.css">
<title>Return Flights</title>
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
		ArrayList<Integer> list = new ArrayList<Integer>();
		String _numPassengers = request.getParameter("numPassengers");
		int numLegs = 1;//1 for 1,2 for 2,-1 for different date
		int numPassengers = Integer.parseInt(_numPassengers);
		boolean isRoundTrip = false;

		String origin = request.getParameter("origin");
		String destination = request.getParameter("destination");
		String date = request.getParameter("date");

		DbManager db = new DbManager();
		Results r = db.getFlights(date, origin, destination);
		ResultSet rs = r.getResultSet();

		if (!rs.first()) {
			numLegs = 2;
			r.closeConnection();
			r = db.getTwoLegFlights(date, origin, destination);
		}

		else {
			rs.beforeFirst();
		}
		rs = r.getResultSet();
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
		double fare = 0;
		ReservationData res = (ReservationData) session.getAttribute("reservation");
		Legs leg = new Legs();
		Legs leg2 = new Legs();
		double flightClass = res.flightClassMult;
	%>

	<div class="box">
		<%
			if (numLegs == 1) {
		%>
		<section class="reservations">
			<h1 class="header">Return Flights</h1>
			<table id="reservation1" class="display">
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
								list.add((int) (Math.random() * 50) - 25);
							out.print((Math.floor((flightClass*numPassengers * rs.getInt(i) * dateMultiplier) / 100) * 100)+list.get(list.size()-1));
										fare = ((Math.floor((flightClass * numPassengers * rs.getInt(i) * dateMultiplier) / 100)
												* 100));
							%>
						</td>
						<td style="text-align: center">

							<form id="reservationConfirmation1" method="post"
								action="dataStorage.jsp">
								<input type="hidden" name="origin" value="<%=origin%>">
								<input type="hidden" name="destination" value="<%=destination%>">
								<input type="hidden" name="numPassengers"
									value="<%=numPassengers%>"> <input type="hidden"
									name="date" value="<%=date%>"> <input type="hidden"
									name="fromReturnFlight" value="fromReturnFlight"> <input
									id="rowNum" type="hidden" name="rowNumber"> <a
									type="submit" href="#"> <img
									src="https://image.flaticon.com/icons/svg/61/61456.svg"
									height="10" width="10">
								</a>
							</form>
						</td>
					</tr>
					<%
						}
							res.t_fare += fare;
					%>
				</tbody>
			</table>
		</section>
		<%
			} else if (numLegs == 2) {
		%>
		<section class="reservations">
			<h1 class="header">Possible Flights</h1>
			<table id="reservation2" class="display">
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
							list.add((int) (Math.random() * 50) - 25);
							out.print((Math.floor((flightClass*numPassengers * rs.getInt(i) * dateMultiplier) / 100) * 100)+list.get(list.size()-1));
										fare = ((Math.floor((numPassengers * rs.getInt(i) * dateMultiplier) / 100) * 100));
							%>
						</td>
						<td style="text-align: center">

							<form id="reservationConfirmation2" method="post"
								action="dataStorage.jsp">
								<input type="hidden" name="origin" value="<%=origin%>">
								<input type="hidden" name="destination" value="<%=destination%>">
								<input type="hidden" name="numPassengers"
									value="<%=numPassengers%>"> <input type="hidden"
									name="date" value="<%=date%>"> <input type="hidden"
									name="fromReturnFlight" value="fromReturnFlight"> <input
									type="hidden" name="multipleLegs" value="multipleLegs">
								<input id="rowNum" type="hidden" name="rowNumber"> <a
									type="submit" href="#"> <img
									src="https://image.flaticon.com/icons/svg/61/61456.svg"
									height="10" width="10">
								</a>
							</form>
						</td>
					</tr>
					<%
						}
							res.t_fare += fare;
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
		$("#reservation1").DataTable({
			"lengthMenu" : [ [ 10, 25, 50, -1 ], [ 10, 25, 50, "All" ] ]
		});
		$("#reservation2").DataTable({
			"lengthMenu" : [ [ 10, 25, 50, -1 ], [ 10, 25, 50, "All" ] ]
		});
	});

	$('#reservationConfirmation1 a')
			.click(
					function() {
<%session.setAttribute("reservation", res);
			leg.fromAirport = origin;
			leg.toAirport = destination;
			leg.flightDate = date;
			session.setAttribute("leg1", leg);
			session.setAttribute("randomPrices", list);%>
	$('#rowNum').val(
								$(this).parent().closest("tr").index('tr'));
						//alert($('#rowNum').val());
						$('#reservationConfirmation1').submit();

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
						//alert($('#rowNum').val());
						$('#reservationConfirmation2').submit();
					});
</script>
</html>