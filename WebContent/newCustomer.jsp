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
<meta charset="ISO-8859-1">
<title>New Customer</title>
<link rel="stylesheet" type="text/css" href="css/login.css">
</head>
<body>
	<div class="form">
		<h1>Enter your information</h1>
		<form class="input" method="post" action="checkCustomer.jsp">
			<input type="text" placeholder="First Name" name="firstName" required />
			<input type="text" placeholder="Last Name" name="lastName" required />
			<input type="text" placeholder="Address" name="address" required />
			<input type="text" placeholder="City" name="city" required /> 
			<input type="text" placeholder="State" name="state" required /> 
			<input type="number" placeholder="Zip Code" name="zip" required /> 
			<input type="tel" placeholder="Phone Number" name="phone" />
			<button>create</button>
		</form>
	</div>

</body>
</html>