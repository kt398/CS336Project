<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import = "test.*,java.sql.Connection,
 java.sql.DriverManager,
 java.sql.ResultSet,
 java.sql.SQLException,
 java.sql.Statement" %>
0

<!DOCTYPE html>
<html>

<head>
	<title>Creating new user...</title>
	<link rel="stylsheet" href="css/newUser.css"/>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"/>
</head>

<body>
	
	<%
		String newName = request.getParameter("username");
		String newEmail = request.getParameter("email");
		String newPwd = request.getParameter("password");
		
		DbManager test = new DbManager();
		Connection con = test.getConnection();
		
		int status = test.newUser(con,newName,newPwd);
		
		switch(status){
		case 1:
			%>
			<script>
				alert("New user successfully created!");
			</script>
			<%
			break;
		case -1:
			%>
			<script>
				alert("Username already exists");
				window.location.href="login.jsp";
			</script>
			<%
		default:
			%>
			<script>
				alert("Databse connection issue, failed to create account");
				window.location.href="login.jsp?signup";
			</script>
			<%
			break;
		}
	 %>
	
</body>


</html>