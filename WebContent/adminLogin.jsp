<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

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
		<form class="login" method="post" action="adminCheck.jsp">
			<input type="text" placeholder="username" name="username" /> <input
				type="password" placeholder="password" name="password" />
			<button>login</button>
			<p class="message">
				Regular user? <a href="login.jsp">Log in here</a>
			</p>
		</form>
	</div>
</body>
</html>