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
<title>Rutgers cs336 Project</title>
<link rel="stylesheet" type="text/css" href="css/login.css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>

<body>
	<h1>Admin Login Page</h1>
	<div class="form">
		<form class="login" method="post" action='adminLogin.jsp'>
			<input type="text" placeholder="username" name="username" /> <input
				type="password" placeholder="password" name="password" />
			<button>login</button>
			<p class="message">
				Regular user? <a href="login.jsp">Log in here</a>
			</p>
		</form>
		<%
			if(request.getParameter("username")!= null){
				String username = request.getParameter("username");
				String password = request.getParameter("password");
				System.out.println(username+","+password);
				DbManager db = new DbManager();
				Connection con = db.getConnection();
				
				int status = db.adminUserPass(username,password);
				
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
						window.location.href="adminHome.jsp";
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
			}
		%>
	</div>
</body>
</html>