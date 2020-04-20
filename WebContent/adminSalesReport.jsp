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
	
	<section class="salesReport">
		<h1>Sales Report</h1>
		<form method="post" class="selectAirport" action="adminSalesReport.jsp">
			<p>Enter Month:</p>
			<input id="month" type="month"	name="month">
			<button>Display Sales Report</button>
		</form>
		
		<%
		if(request.getParameter("month")!=null){
			DbManager db = new DbManager();
			Results r = db.getMonthReservations(request.getParameter("month"));
			while (r == null) {
				r = db.getAllAirports();
			}
			ResultSet rs = r.getResultSet();
			int monthlyTotal = 0;
			%>
			<table id="salesTable" class="display">
				<thead>
					<tr>
						<th>Date</th>
						<th>Booking Fee</th>
						<th>Travel Fare</th>
						<th>Total</th>
					</tr>
				</thead>
				<tbody>
				<%
				while(rs.next()){
					%>
					 <tr>
						<%
						monthlyTotal+=rs.getInt(3)+rs.getInt(2);
						for(int i=1; i<=3; i++){
						%>
							<td><%=rs.getString(i)%></td>
						<%
						}
						%>
							<td><%=rs.getInt(3)+rs.getInt(2)%></td>
					</tr>
				<%}%>
				</tbody>
			</table>
		<h1>MONTHLY TOTAL: <%=monthlyTotal%></h1>
		<%}%>
	</section>
	
</body>


<script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
<script type="text/javascript" src="//cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
		$(document).ready(function(){
	        $("#salesTable").DataTable({
	    		"lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "All"]]
			});
	    });   
	});
	
	$('.selectAirport').submit(function(){
		var d = new Date();
		var date;
		if (d.getMonth() + 1 < 10){
			date = (d.getFullYear() +'-0'+ (d.getMonth()+1));
		}else{
		 	date = (d.getFullYear() +'-'+ (d.getMonth()+1));
		}
		if($('#month').val()>date){
			alert("Invalid month entry");
			window.href.location="adminSalesReport.jsp";
		}
	});
	
</script>

</html>