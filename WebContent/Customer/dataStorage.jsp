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
<title></title>
<link rel="stylsheet" href="css/checkUser.css" />
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
</head>

<body>

	<%
		DbManager db = new DbManager();
		
		ReservationData res = (ReservationData) session.getAttribute("reservation");
		String origin = request.getParameter("origin");
		String destination = request.getParameter("destination");
		String date = request.getParameter("date");
		int numPassengers = Integer.parseInt(request.getParameter("numPassengers"));
		boolean roundTrip = res.type.compareTo("roundTrip")==0;
		
		if(request.getParameter("multipleLegs")==null){
			Legs leg = (Legs)session.getAttribute("leg1");
			Results prevLegInfo = db.getFlights(date,origin,destination);
			ResultSet rs = prevLegInfo.getResultSet();
			rs.absolute(Integer.parseInt(request.getParameter("rowNumber")));
			leg.flightNumber = rs.getInt(2);
			leg.airline = rs.getString(1);
			leg.departureTime = rs.getString(3);
			leg.arrivalTime = rs.getString(4);
			res.legs.add(leg);
		}else{
			Legs leg1 = (Legs)session.getAttribute("leg1");
			Legs leg2 = (Legs)session.getAttribute("leg2");
			Results multiLegs = db.getTwoLegFlights(date, origin, destination);
			ResultSet rs = multiLegs.getResultSet();
			rs.absolute(Integer.parseInt(request.getParameter("rowNumber")));
			leg1.toAirport = rs.getString(6);
			leg1.flightNumber = rs.getInt(3);
			leg1.airline = rs.getString(2);
			leg1.departureTime = rs.getString(4);
			leg1.arrivalTime = rs.getString(5);
			res.legs.add(leg1);
			
			leg2.fromAirport = rs.getString(6);
			leg2.toAirport = destination;
			leg2.flightNumber = rs.getInt(8);
			leg2.airline = rs.getString(7);
			leg2.departureTime = rs.getString(9);
			leg2.arrivalTime = rs.getString(10);
			res.legs.add(leg2);
		}
		
		%>
			<form id="roundTrip" method="post" action="returnFlight.jsp">
				<input type="hidden" name="origin" value="<%=destination%>">
				<input type="hidden" name="destination" value="<%=origin%>">
				<input type="hidden" name="date" value="<%=date%>">
				<input type="hidden" name="numPassengers" value="<%=numPassengers%>">
			</form>
			
</body>
<script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
<script>
	$(document).ready(function(){
		if(<%=roundTrip && request.getParameter("fromReturnFlight")==null%>){
			$('#roundTrip').submit();
		}else{
			window.location.href="confirmReservation.jsp";			
		}
	});  
</script>

</html>