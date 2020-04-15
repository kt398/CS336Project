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
		<form class="input" method="post" action="newCustomer.jsp">
			<input type="text" placeholder="First Name" name="firstName" required />
			<input type="text" placeholder="Last Name" name="lastName" required />
			<input type="text" placeholder="Address" name="address" required />
			<input type="text" placeholder="City" name="city" required />
			<input type="text" placeholder="State" name="state" required />
			<input type="number" placeholder="Zip Code" name="zip" required />
			<input type="tel" placeholder="Phone Number" name="phone" />
			<button>create</button>
		</form>
		
		<%
		if(request.getParameter("firstName") != null){
			String email = (String) (session.getAttribute("email"));
			String fname = request.getParameter("firstName");
			String lname = request.getParameter("lastName");
			String address = request.getParameter("address");
			String city = request.getParameter("city");
			String state = request.getParameter("state");
			String zip =  request.getParameter("zip");
			String phone = request.getParameter("phone");
			DbManager db = new DbManager();
			int status = db.newCustomer(fname, lname, email, "0", address, city, state, zip, phone);

			switch (status) {
				case 1 :
			%>
			<script>
				alert("New customer successfully created!");
				window.location.href = "Customer/customerHome.jsp";
	
			</script>
			<%
				break;
					default :
			%>
			<script>
				alert("Databse connection issue, failed to create customer");
				window.location.href = "newCustomer.jsp";
			</script>
			<%
				break;
			}
		}
		%>
	</div>

</body>
</html>