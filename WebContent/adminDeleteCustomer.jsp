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
 <body>
 	<%
 	DbManager db = new DbManager();
	Connection con = db.getConnection();
	String email = request.getParameter("email");
	System.out.println(email);
	try {
		Statement stmt = con.createStatement();
		stmt.executeUpdate("DELETE Accounts, Customers FROM Accounts NATURAL JOIN Owns NATURAL JOIN Customers WHERE Customers.email=\""+email+"\"");
		System.out.println("deleted " + email);
		%>
		<script>
			window.location.href="adminHome.jsp";
		</script>
		<%
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
 	%>
 </body>
 
 </html>