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
		String newPwd = request.getParameter("password");
		DbManager db = new DbManager();
		int status = db.newAdmin(newName, newPwd);

		switch (status) {
			case 1 :
	%>
	<script>
		alert("New Admin successfully created!");
		window.location.href= "adminHome.jsp";
	</script>
	<%
		break;
			case -1 :
	%>
	<script>
		alert("Username already exists");
		window.location.href = "adminLogin.jsp";
	</script>
	<%
		default :
	%>
	<script>
		alert("Database connection issue, failed to create account");
		window.location.href = "adminLogin.jsp";
	</script>
	<%
		break;
		}
	%>

</body>


</html>