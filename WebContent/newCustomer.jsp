<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>New Customer</title>
<link rel="stylesheet" type="text/css" href="css/login.css">
</head>
<body>
	<div class="form">
		<h1>Enter your information</h1>
		<form class="input" method="post">
			<input type="text" placeholder="First Name" name="firstName" required />
			<input type="text" placeholder="Last Name" name="lastName" required />
			<input type="text" placeholder="Address" name="address" required />
			<input type="text" placeholder="City" name="city" required /> <input
				type="text" placeholder="State" name="state" required /> <input
				type="number" placeholder="Zip Code" name="zip" required /> <input
				type="tel" placeholder="Phone Number" name="phone" />
			<button>create</button>
		</form>
		<%
			String name = request.getParameter("firstName");
			String password= request.getParameter("lastName");
			String address=request.getParameter("address");
			String city=request.getParameter("city");
			String state=request.getParameter("address");
			int zip=Integer.parseInt(request.getParameter("zip"));
			int phone=Integer.parseInt(request.getParameter("phone"));
			
		%>
	</div>
</body>
</html>