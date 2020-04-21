<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="test.*,java.sql.ResultSet"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title></title>
</head>
<body>
	<%
		DbManager manager = new DbManager();
		Results r = (Results) session.getAttribute("Results");
		ReservationData resData = (ReservationData) session.getAttribute("resData");
	%>
	<nav class="navbar">
		<a class="top topSelected" href="customerHome.jsp">Home</a> <a
			href="customerReservations.jsp">My Reservations</a> <a
			href="customerMakeReservation.jsp">Make Reservation</a> <a
			href="customerPersonalInformation.jsp">Personal Information</a> <a
			href="customerFlightPreferences.jsp">Flight Preferences</a> <a
			class="bot" href="../logout.jsp">Logout</a>
	</nav>
	<div class="box">
		<h1 class="header">Confirm Your Reservation</h1>
		<h2>
			Total Fares:<%
			
		%>
		</h2>
		<form action="">
			<h2>Enter the ccv code for your credit card number linked to
				your account</h2>
			<input type="number" name="ccv"> <input type="submit"
				value="Confirm your Reservation">
		</form>
	</div>
	<script
		src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
	<script type="text/javascript">
		$('.box form').submit(
			if(('.ccv').val().length==3){
				<%manager.makeNewReservation((String) session.getAttribute("username"),
					(String) session.getAttribute("password"), (ReservationData) session.getAttribute("resData"), null);%>
			}			
	</script>

</body>

</html>