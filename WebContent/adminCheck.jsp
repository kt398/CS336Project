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
<title>Checking admin credentials</title>
<link rel="stylsheet" href="css/checkUser.css" />
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
</head>

<body>
	<%
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		System.out.println(username+","+password);
		DbManager db = new DbManager();
		Connection con = db.getConnection();
		
		int status = db.adminExists(username);
		
		switch(status){
		case -2:
			%>
			<script>
				alert("Databse connection issue.");
				window.location.href="adminLogin.jsp";
			</script>
			<%
			break;
		case 1:
			%>
			<script>
				alert("Login Successful!");
			</script>
			<%
			break;
		default:
			%>
			<script>
				alert("Login information is incorrect");
				window.location.href="adminLogin.jsp";
			</script>
			<%
			break;
		}	
	%>
</body>
</html>