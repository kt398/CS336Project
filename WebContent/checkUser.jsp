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
<title>Checking user credentials</title>
<link rel="stylsheet" href="css/checkUser.css" />
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
</head>

<body>

	<%
		String newName = request.getParameter("username");
		String newPwd = request.getParameter("password");
		//System.out.println(newName + "," + newPwd);
		DbManager db = new DbManager();
		int status = db.checkUserPass(newName, newPwd);

		switch (status) {
			case -2 :
	%>
	<script>
		alert("Database connection issue.");
		window.location.href = "login.jsp";
	</script>
	<%
		break;
			case 1 :
				session.setAttribute("password", newPwd);
				session.setAttribute("username", newName);
	%>
	<script>
		window.location.href="Customer/customerHome.jsp"
	</script>
	<%
		break;
			default :
	%>
	<script>
		window.location.href = "login.jsp?correct=false";
	</script>
	<%
		break;
		}
	%>

</body>


</html>