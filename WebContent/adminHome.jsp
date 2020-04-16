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
</head>

<body>
	<nav class="navbar">
		<ul>
			<li><a class="adminHome" href="#" >Home Page</a></li>
			<li><a class="newAdmin" href="#" >Add Admin</a></li>
			<li><a class="customerData" href="#" >Customer Information</a></li>
			<li><a class="salesReport" href="#" >Sales Report</a></li>
			<li><a class="allFlights" href="#" >List of all Flights</a></li>
			<li><a class="listReservations" href="#" >List of Reservations</a></li>
			<li><a class="listingRevenue" href="#" >Summary listing of Revenue</a></li>
			<li><a class="airportFlights" href="#" >Flights for Airports</a></li>
		</ul>
	</nav>
	
	<section class="adminHome">
		<h1>Welcome!</h1>
	</section>
	
	<section class="newAdmin">
		<p>Create a new Administrative Account</p>
		<div class="container">
			<form class="newAdmin" method="post" action="newAdmin.jsp">
				<input type="text" placeholder="username" name="username">
				<input type="password" placeholder="password" name="password">
				<button>Create</button>
			</form>
		</div>
		
	</section>
	
	<section class="customerData">
		<h1>Customer Database</h1>

		<div class="container">
			<form method="post" action="newUserAdmin.jsp">
				<input type="text" placeholder="username" name="username">
				<input type="text" placeholder="password" name="password">
				<input type="email" placeholder="email" name="email">
				<button>Add new user</button>
			</form>
		</div>

		<%
		DbManager db = new DbManager();
		Connection con = db.getConnection();
		String query = "SELECT * FROM Customers";
		Statement stmt = con.createStatement();
		ResultSet rs = stmt.executeQuery(query);
		%>
		<table id="customerTable">
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
				<th>Phone Number</th>
				<th>Edit</th>
				<th>Delete</th>
			</tr>
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
		%>
		</table>
	</section>
	
	
	<section class="salesReport">
		<h1>Sales Report</h1>
	</section>
	
	<section class="allFlights">
		<h1>List of all Flights</h1>
	</section>
	
	<section class="listReservations">
		<h1>List of all Reservations</h1>
	</section>
	
	<section class="listingRevenue">
		<h1>Summary listing of Revenue</h1>
	</section>
	
	<section class="airportFlights">
		<h1>Flights for Airports</h1>
	</section>
	
</body>

<script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
<script type="text/javascript">

    $(document).ready(function(){
        $("section").hide();
        $(".adminHome").show();
    });    
    
    $('nav a').click(function(){
        $("section").hide();
        $("section."+$(this).attr('class')).show();
    });
    
    $('#deleteCustomerForm a').click(function(){
    	var values = $(this).closest("tr");  
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