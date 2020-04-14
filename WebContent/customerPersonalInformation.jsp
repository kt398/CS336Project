<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="test.*,java.sql.ResultSet"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Personal Information</title>
<link rel="stylesheet" type="text/css" href="css/customerPersonalInformation.css">
<link rel="stylesheet" type="text/css" href="css/navBar.css">
</head>
<body>
	<nav class="navbar">
		<ul>
			<li><a class="top" href="customerHome.jsp">Home</a></li>
			<li><a href="customerReservations.jsp">My Reservations</a></li>
			<li><a href="customerMakeReservations.jsp">Make Reservation</a></li>
			<li><a class="selected" href="customerPersonalInformation.jsp">Personal
					Information</a></li>
			<li><a href="customerFlightPreferences.jsp">Flight
					Preferences</a></li>
			<li><a class="bot" href="login.jsp">Logout</a></li>
		</ul>
	</nav>
	<div class="information">
		<h1 class="heading">Make Reservation</h1>
		<ul class="items">
			<li>First Name</li>
			<li>Last Name</li>
			<li>Username</li>
			<li>Email</li>
			<li>Address</li>
			<li>City</li>
			<li>State</li>
			<li>Zip</li>
			<li>Credit Card Number</li>
			<li>Phone Number</li>
			<li>Account Creation Date</li>
		</ul>
		<%
		DbManager manager=new DbManager();
		ResultSet rs=manager.getCustomerInformation((String)session.getAttribute("username"),(String)session.getAttribute("password"));
		rs.next();
		%>
		<ul class="items2">
			<li><%out.print(rs.getString("firstName"));%></li>
			<li><%out.print(rs.getString("lastName"));%></li>
			<li><%out.print(session.getAttribute("username"));%></li>
			<li><%out.print(rs.getString("email"));%></li>
			<li><%out.print(rs.getString("address"));%></li>
			<li><%out.print(rs.getString("city"));%></li>
			<li><%out.print(rs.getString("state"));%></li>
			<li><%out.print(rs.getString("zip"));%></li>
			<li><%out.print(rs.getString("creditCard"));%></li>
			<li><%out.print(rs.getString("phone"));%></li>
			<li><%out.print(rs.getString("creationDate"));%></li>
		</ul>
		<a href="customerEditPersonalInformation.jsp" class="button">Edit Personal Information</a>
	</div>
</body>
</html>