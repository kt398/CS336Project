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
	<%
		DbManager manager=new DbManager();
		ResultSet rs=manager.getCustomerInformation((String)session.getAttribute("username"),(String)session.getAttribute("password"));
		rs.next();
	%>
	<div class="information">
		<form class="input" method ="post" action="updateCustomerInformation.jsp">
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
		<ul class="items2">
			<li>
				<input type="text"name="firstName" value="<%out.print(rs.getString("firstName"));%>"></li>
			<li>
				<input type="text"name="lastName" value="<%out.print(rs.getString("lastName"));%>"></li>
			<li>
				<input type="text"name="username" value="<%out.print(rs.getString("username"));%>" readonly="readonly"></li>
			<li>
				<input type="text"name="email" value="<%out.print(rs.getString("email"));%> " readonly="readonly"></li>
			<li>
				<input type="text"name="address" value="<%out.print(rs.getString("address"));%>"></li>
			<li>
				<input type="text"name="city" value="<%out.print(rs.getString("city"));%>"></li>
			<li>
				<input type="text"name="state" value="<%out.print(rs.getString("state"));%>"></li>
			<li>
				<input type="text"name="zip" value="<%out.print(rs.getString("zip"));%>"></li>			
			<li>
				<input type="text"name="creditCard" value="<%out.print(rs.getString("creditCard"));%>"></li>
			<li>
				<input type="text"name="phone" value="<%out.print(rs.getString("phone"));%>"></li>
			<li>
				<input type="text"name="creationDate" value="<%out.print(rs.getString("creationDate"));%>" readonly="readonly"></li>
		</ul>
		</form>
	</div>
</body>
</html>