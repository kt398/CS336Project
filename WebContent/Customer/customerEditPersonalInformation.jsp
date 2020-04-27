<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="test.*,java.sql.ResultSet"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Personal Information</title>
<link rel="stylesheet" type="text/css"
	href="../css/customerEditPersonalInformation.css">
<link rel="stylesheet" type="text/css" href="../css/navBar.css">
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
		DbManager manager = new DbManager();
		Results r = manager.getCustomerInformation((String) session.getAttribute("username"));
		ResultSet rs = r.getResultSet();
		rs.next();
		String email = "\"" + rs.getString("email") + "\"";
	%>
	<div class="information">
		<h1 class="heading">Edit Personal Information</h1>
		<form class="input" method="post"
			action="customerEditPersonalInformation.jsp">
			<label for="firstName">First Name</label> <input type="text"
				name="firstName" value="<%out.print(rs.getString("firstName"));%>"
				required> <label for="lastName">Last Name</label> <input
				type="text" name="lastName"
				value="<%out.print(rs.getString("lastName"));%>" required> <label
				for="username">Username</label> <input type="text" name="username"
				value="<%out.print(rs.getString("username"));%>" readonly> <label
				for="email">Email</label> <input type="text" name="email"
				value="<%out.print(rs.getString("email"));%> " readonly> <label
				for="address">Address</label> <input type="text" name="address"
				value="<%out.print(rs.getString("address"));%>"> <label
				for="city">City</label> <input type="text" name="city"
				value="<%out.print(rs.getString("city"));%>" required> <label
				for="state">State</label> <input type="text" name="state"
				value="<%out.print(rs.getString("state"));%>"> <label
				for="zip">Zip</label> <input type="text" name="zip"
				value="<%out.print(rs.getString("zip"));%>" required> <label
				for="creditCard">Credit Card Number</label> <input type="text"
				name="creditCard" value="<%out.print(rs.getString("creditCard"));%>"
				required> <label for="phone">Phone Number</label> <input
				type="text" name="phone"
				value="<%out.print(rs.getString("phone"));%>" required> <input
				type="submit" value="submit">
		</form>
		<%
			if (request.getParameter("firstName") != null) {
				String firstName, lastName, username, address, city, state, zip, creditCard, phone;
				firstName = "\"" + request.getParameter("firstName") + "\"";
				lastName = "\"" + request.getParameter("lastName") + "\"";
				username = "\"" + request.getParameter("username") + "\"";
				address = "\"" + request.getParameter("address") + "\"";
				city = "\"" + request.getParameter("city") + "\"";
				state = "\"" + request.getParameter("state") + "\"";
				zip = "\"" + request.getParameter("zip") + "\"";
				creditCard = "\"" + request.getParameter("creditCard") + "\"";
				phone = "\"" + request.getParameter("phone") + "\"";
				manager.updateCustomerInformation(firstName, lastName, email, username, address, city, state, zip,
						creditCard, phone);
		%>
		<script>
			window.location.href = "customerPersonalInformation.jsp";
		</script>
		<%
			}
		%>
	</div>
</body>
</html>