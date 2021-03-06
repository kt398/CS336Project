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
<title>Creating new user...</title>
<link rel="stylsheet" href="css/newUser.css" />
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
</head>
<body>
	<%
		String newName = request.getParameter("username");
		String newEmail = request.getParameter("email");
		String newPwd = request.getParameter("password");
		session.setAttribute("email", newEmail);
		session.setAttribute("password", newPwd);
		session.setAttribute("username", newName);
		DbManager db = new DbManager();
		int status = db.newUser(newName, newPwd, newEmail);

		switch (status) {
			case 1 :
	%>
	<script>
		alert("New account successfully created!");//Customer exists
		window.location.href = "adminHome.jsp";
	</script>
	<%
		break;
			case 2 :
	%>
	<script>
		alert("New account successfully created! Please fill out information");//Customer doesn't exist
		window.location.href = "newCustomerAdmin.jsp";
	</script>
	<%
		break;
			case -1 :
	%>
	<script>
		alert("Username already exists");
		window.location.href = "adminHome.jsp";
	</script>
	<%
		case -2 :
	%>
	<script>
		alert("Database connection issue, failed to create account");
		window.location.href = "adminHome.jsp";
	</script>
	<%
		break;
		}
	%>

</body>


</html>