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
<title>Home Page [Admin]</title>
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
		<a href="adminActiveFlights.jsp">Active Flights</a>
		<a href="adminReservations.jsp" >Reservations</a>
		<a href="adminRevenueCustomerFlightDestination.jsp" >Revenue Summary</a>
		<a href="adminAirportFlights.jsp" >Airport Flights</a>
		<a href="login.jsp">Logout</a>
	</nav>
	
	<section class="customerData">
		<%
		DbManager db = new DbManager();
		Results mvc = db.getMostValuableCustomer();
		ResultSet valuedCustomer = mvc.getResultSet();
		//what is going on?
		if(valuedCustomer.next()){
		%>
		<h1>OUR MOST VALUABLE CUSTOMER!!!</h1>
		<div id="valuedCustomer" style="width:50%;margin:0 auto;display:flex;justify-content:space-around;color:deepskyblue;">
			<p><b>Email:</b> <%=valuedCustomer.getString(1)%></p>
			<p><b>Username:</b> <%=valuedCustomer.getString(2)%></p>
			<p><b>First Name:</b> <%=valuedCustomer.getString(3)%></p>
			<p><b>Last Name:</b> <%=valuedCustomer.getString(4)%></p>
			<p><b>Phone:</b> <%=valuedCustomer.getString(5)%></p>
			<p><b>SUM:</b> $<%=valuedCustomer.getString(6)%></p>
		</div>
		<%} %>
		<h1>Customer Database</h1>
		<%
		Connection con = db.getConnection();
		String query = "SELECT * FROM Customers";
		Statement stmt = con.createStatement();
		ResultSet rs = stmt.executeQuery(query);
		%>
		<table id="customerTable" class="display">
			<thead>
				<tr>
					<th>Username</th>
					<th>First Name</th>
					<th>Last Name</th>
					<th>Email</th>
					<th>Creation Date</th>
					<th>C.C. Num.</th>
					<th>Address</th>
					<th>City</th>
					<th>State</th>
					<th>Zip</th>
					<th>Phone</th>
					<th>Edit</th>
					<th>Delete</th>
				</tr>
			</thead>
			<tbody>
		<% 
		while(rs.next()){
		%>
			<tr>
				<%
				String getUser = "Select username, password from Accounts a JOIN owns o ON a.accNum=o.accNum JOIN customers c ON o.email=c.email WHERE c.email=\""+rs.getString(3)+"\"";
				Statement stmt2 = con.createStatement();
				ResultSet rs2 = stmt2.executeQuery(getUser);
				rs2.next();
				%>
				<td><b><%=rs2.getString(1)%></b></td>
				<%
				for(int i=1; i<11; i++){
				%>
					<td><%=rs.getString(i)%></td>
				<%
				}
				%>
				<td style="text-align:center"><form id="editCustomerForm" method="post" action="adminEditCustomer.jsp">
					<input id="custUser" style="display:none" name="username">
				<a href="#">
					<img src="https://image.flaticon.com/icons/svg/61/61456.svg" height="10" width="10">
				</a></form></td>
				
				<td style="text-align:center"><form id="deleteCustomerForm" method="post" action="adminDeleteCustomer.jsp">
					<input style="display:none" name="email"></input>
				<a href="#">
					<img src="https://cdn3.iconfinder.com/data/icons/iconano-text-editor/512/005-X-512.png" height="10" width="10">
				</a></form></td>
			</tr>
		<%
		}
		rs.close();
		%>
		</tbody>
		</table>
		
		<h1>Add New User!</h1>
		<div class="container">
			<form method="post" action="newUserAdmin.jsp">
				<input type="text" placeholder="username" name="username">
				<input type="text" placeholder="password" name="password">
				<input type="email" placeholder="email" name="email">
				<button>Add</button>
			</form>
		</div>
	</section>
	

<script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
<script type="text/javascript" src="//cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
<script type="text/javascript">

    $(document).ready(function(){
        $("#customerTable").DataTable({
    		"lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "All"]]
		});
    });    

    $('#deleteCustomerForm a').click(function(){
    	var values = $(this).closest("tr");  
    	alert(values.find("td:eq(3)").text());
    	$('#deleteCustomerForm input').attr('value',values.find("td:eq(3)").text());
    	document.getElementById('deleteCustomerForm').submit();
    });
    
    $('#editCustomerForm a').click(function(){
    	var values = $(this).closest("tr");
    	$('#editCustomerForm input').attr('value',values.find("td:eq(0)").text());
    	document.getElementById('editCustomerForm').submit();
    });
</script>

</html>