<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="test.*,java.sql.ResultSet"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css"
	href="../css/makeReservationLocationDate.css">
<link rel="stylesheet" type="text/css" href="../css/navBar.css">
</head>
<body>
	<nav class="navbar">
		<a class="top topSelected" href="customerHome.jsp">Home</a> <a
			href="customerReservations.jsp">My Reservations</a> <a
			href="customerMakeReservation.jsp">Make Reservation</a> <a
			href="customerPersonalInformation.jsp">Personal Information</a> <a
			class="bot" href="../logout.jsp">Logout</a>
	</nav>
	<%
		String t = request.getParameter("type");
		String type = "\"" + t + "\"";
		DbManager manager = new DbManager();
		Results r = manager.getAllAirports();
		while (r == null) {
			r = manager.getAllAirports();
		}
		ResultSet rs = r.getResultSet();
	%>
	<div class="box">
		<h1 class="header">Enter Information</h1>
		<form method="post" action="makeReservationListReservations.jsp">
			<h2>Number of Passengers</h2>
			<input type="number" placeholder= "0" name="numPassengers" required>
			<h2>From:</h2>
			<select class="origin" onchange="test(value)" name="origin"
				required>
				<option value="   ">
					<%
						String s;
						String ss;
						while (rs.next()) {
							s = rs.getString("id");
							ss = "\"" + s + "\"";
					%>
				
				<option><%=s%></option>
				<%
					}
				%>
			</select>
			<h2>To:</h2>
			<select class="destination" name="destination" required>
				<option value="   ">
					<%
						rs.beforeFirst();
						while (rs.next()) {
							s = rs.getString("id");
							ss = "\"" + s + "\"";
					%>
				
				<option><%=s%></option>
				<%
					}
				%>
			</select>
			<h2>Date</h2>
			<input type="date" class="date" placeholder="YYYY-MM-DD" required
				name="date">
			<%
				if (t.compareTo("roundTrip") == 0) {
			%>
			
			<h2>Return Date</h2>
			
			<input type="date" class="date" placeholder="YYYY-MM-DD" required
				name="returnDate">
			<%
				}
			%>
			
			<h2>Class</h2>
			<select class="class" name="class" required>
				<option value="0.9">Economy</option>
				<option value="1.0">Business</option>
				<option value="1.1">First Class</option>
			</select>
			
			<h2>Dietary Restrictions</h2>
			<select class="food" name="food" required>
				<option value="Regular">None</option>
				<option value="Vegetarian">Vegetarian</option>
				<option value="Vegan">Vegan</option>
			</select>
			<input type="hidden" name="type" value=<%out.print(type);%>>
			
			<button value="Continue">Continue</button>
		</form>
	</div>
	<script
		src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
	<script type="text/javascript">
		$('.box form').submit(
				function() {
					var today = new Date();
					if (today.getMonth() + 1 < 10)
						var date = today.getFullYear() + '-0'
								+ (today.getMonth() + 1) + '-'
								+ today.getDate();
					else
						var date = today.getFullYear() + '-'
								+ (today.getMonth() + 1) + '-'
								+ today.getDate();
					if ($('.origin').val() == $('.destination').val()) {
						alert('Origin and Destination are the same!');
						return false;
					} else if ($('.date').val() < date) {
						alert('Invalid Date Entry');
						return false;
					} else {
						$('.box form').submit();
						return false;
					}
				});
	</script>
</body>
</html>