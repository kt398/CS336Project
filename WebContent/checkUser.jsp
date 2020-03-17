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
		String newPwd = request.getParameter("password");
		
		System.out.println(newName+","+newPwd);
		
		DbManager test = new DbManager();
		Connection con = test.getConnection();
		
		int status = test.checkUserPass(con,newName,newPwd);
		
		switch(status){
		case -2:
			%>
			<script>
				alert("Databse connection issue.");
				window.location.href="login.jsp";
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
				window.location.href="login.jsp";
			</script>
			<%
			break;
		}
	 %>
	
</body>


</html>