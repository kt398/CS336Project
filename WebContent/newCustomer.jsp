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
		<form class="input" method="post" action="customerHome.jsp">
			<input type="text" placeholder="First Name" name="firstName" /> <input
				type="text" placeholder="Last Name" name="lastName" /> <input
				type="text" placeholder="Address" name="address" /> <input
				type="text" placeholder="City" name="city" /> <input type="text"
				placeholder="State" name="state" /> <input type="number"
				placeholder="Zip Code" name="zip" /> <input type="tel"
				placeholder="Phone Number" name="phone" />
			<button>create</button>
		</form>
	</div>
</body>
</html>