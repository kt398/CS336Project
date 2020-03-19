<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
<title>Home Page [Admin]</title>
<link rel="stylesheet" type="text/css" href="">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>

<body>
	<p>Create a new administrative account</p>
	<form class="newAdmin" method="post" action="newAdmin.jsp">
		<input type="text" placeholder="username" name="username">
		<input type="password" placeholder="password" name="password">
		<button>Create</button>
	</form>
</body>

</html>