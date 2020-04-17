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
		<ul>
			<li><a class="top" href="customerHome.jsp">Home</a></li>
			<li><a href="customerReservations.jsp">My Reservations</a></li>
			<li><a class="selected" href="customerMakeReservation.jsp">Make
					Reservation</a></li>
			<li><a href="customerPersonalInformation.jsp">Personal
					Information</a></li>
			<li><a href="customerFlightPreferences.jsp">Flight
					Preferences</a></li>
			<li><a class="bot" href="../login.jsp">Logout</a></li>
		</ul>
	</nav>
	<%
		String type="\""+request.getParameter("type")+"\"";
		DbManager manager = new DbManager();
		Results r = manager.getAllAirports();
		while (r == null) {
			r = manager.getAllAirports();
		}
		ResultSet rs = r.getResultSet();
	%>
	<div class="box">
		<h1 class="header1">Enter Information</h1>
		<form method="post" action="makeReservationListReservations.jsp">
			<h2>From:</h2>
			<br> <select class="origin" onchange="test(value)" name="origin">
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
			<h2>Destination:</h2>
			<br> <select class="destination" name="destination">
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
			<input type="date" class="date" placeholder="YYYY-MM-DD" required name="date">
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
					} else if ($('.date').val() < date) {
						alert('Invaide Date Entry');
					} else {
						$('.box form').submit();
						return false;
					}
				});

	</script>
</body>
</html>
