<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Home Page</title>
<link rel="stylesheet" type="text/css"
	href="../css/customerMakeReservation.css">
<link rel="stylesheet" type="text/css" href="../css/navBar.css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
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
	<div class="box">
		<h1 class="heading">What Type of Reservation?</h1>
		<a id="b1" href="makeReservationLocationDate.jsp?type=oneWay"
			class="button">One-Way</a> <a id="b2"
			href="makeReservationLocationDate.jsp?type=roundTrip" class="button">Round-Trip</a>
	</div>
</body>
</html>