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
<title>List of Reservations</title>
<link rel="stylesheet" type="text/css" href="css/adminHome.css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="//cdn.datatables.net/1.10.20/css/jquery.dataTables.min.css"/>
</head>

<body>
	<nav class="navbar">
		<a href="adminHome.jsp" >Home</a>
		<a href="adminCustomerTable.jsp" >Customers</a>
		<a href="adminSalesReport.jsp" >Sales Report</a>
		<a href="adminListFlights.jsp" >All Flights</a>
		<a href="adminReservations.jsp" >Reservations</a>
		<a href="#" >Revenue Summary</a>
		<a href="adminAirportFlights.jsp" >Airport Flights</a>
		<a href="login.jsp">Logout</a>
	</nav>
	
	<section class="listReservations">
		<h1>List of Reservations</h1>
		<form method="post" action="adminReservations.jsp">
			<p>Enter Customer or Flight Number:</p>
			<input type="text" name="val">
			<button>Find Reservations!</button>
		</form>
		<%
		if(request.getParameter("val")!=null){
			DbManager db = new DbManager();
			Connection con = db.getConnection();
			String query = "SELECT FROM Customers NATURAL JOIN Owns NATURAL JOIN Contain NATURAL JOIN Reservations NATURAL JOIN Have NATURAL JOIN Legs NATURAL JOIN Associated";
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(query);
		}
		%>
	</section>
	

<script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
<script type="text/javascript" src="//cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
<script type="text/javascript">

    $(document).ready(function(){
        $("#").DataTable({
    		"lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "All"]]
		});
    });    

</script>

</html>