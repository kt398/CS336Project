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
 	<h1>Edit <%=request.getParameter("username")%> Information</h1>
 
 		<%
		DbManager manager = new DbManager();
 		Results r=manager.getCustomerInformation(request.getParameter("username"));
		ResultSet rs =r.getResultSet();
		rs.next();
		String email="\""+rs.getString("email")+"\"";
	%>
	<div class="information">
		<form class="input" method="post"
			action="adminEditCustomer.jsp">
			<label for="firstName">First Name</label> <input type="text"
				name="firstName" value="<%out.print(rs.getString("firstName"));%>">
			<label for="lastName">Last Name</label> <input type="text"
				name="lastName" value="<%out.print(rs.getString("lastName"));%>">
			<label for="username">Username</label> <input type="text"
				name="username" value="<%out.print(rs.getString("username"));%>"
				readonly="readonly"> 
			<label for="email">Email</label> <input
				type="text" name="email"
				value="<%out.print(rs.getString("email"));%> " readonly="readonly">
			<label for="address">Address</label> <input type="text"
				name="address" value="<%out.print(rs.getString("address"));%>">
			<label for="city">City</label> <input type="text" name="city"
				value="<%out.print(rs.getString("city"));%>"> <label
				for="state">State</label> 
				<input type="text" name="state" value="<%out.print(rs.getString("state"));%>"> 
			<label for="zip">Zip</label> 
				<input type="text" name="zip" value="<%out.print(rs.getString("zip"));%>"> 
			<label for="creditCard">Credit Card Number</label> 
				<input type="text" name="creditCard" value="<%out.print(rs.getString("creditCard"));%>">
			<label for="phone">Phone Number</label> 
				<input type="text" name="phone" value="<%out.print(rs.getString("phone"));%>">
			<input type="submit" value="submit">
		</form>
		<%
			if (request.getParameter("firstName") != null) {
				String firstName,lastName,username,address,city,state,zip,creditCard,phone;
				firstName="\""+request.getParameter("firstName")+"\"";
				lastName="\""+request.getParameter("lastName")+"\"";
				username="\""+request.getParameter("username")+"\"";
				address="\""+request.getParameter("address")+"\"";
				city="\""+request.getParameter("city")+"\"";
				state="\""+request.getParameter("state")+"\"";
				zip="\""+request.getParameter("zip")+"\"";
				creditCard="\""+request.getParameter("creditCard")+"\"";
				phone="\""+request.getParameter("phone")+"\"";
				manager.updateCustomerInformation(firstName,lastName,email,username,address,city,state,zip,creditCard,phone);
				r.closeConnection();
		%>
		<script>	
			window.location.href = "adminHome.jsp";
		</script>
		<% 
			}
		
		%>
	</div>
 </body>
 
 </html>