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

	\
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
			<li><a class="bot" href="login.jsp">Logout</a></li>
		</ul>
	</nav>
	<%
		DbManager manager = new DbManager();
		Results r = manager.getAllAirports();
		while (r == null) {
			r = manager.getAllAirports();
		}
		ResultSet rs = r.getResultSet();
	%>
	<div class="box">
		<h1 class="header1">Enter Information</h1>
		<form onSubmit="compareAirports(this)">
			<h2>From:</h2>
			<br> <select class="origin">
				<option value=" ">
					<%
						String s;
						String ss;
						while (rs.next()) {
							s = rs.getString("id");
							ss = "\"" + s + "\"";
					%>
				
				<option value=<%out.print(ss);%>>
					<%
						out.print(s);
					%>
				</option>
				<%
					}
				%>
			</select>
			<h2>Destination:</h2>
			<br> <select class="destination">
				<option value="   ">
					<%
						rs.beforeFirst();
						while (rs.next()) {
							s = rs.getString("id");
							ss = "\"" + s + "\"";
					%>
				
				<option value=<%out.print(ss);%>>
					<%
						out.print(s);
					%>
				</option>
				<%
					}
				%>
			</select>
			<h2>Date</h2>
			<input type="date" class="date" value="YYYY-MM-DD" required>


			<input type="submit" class="button" value="Continue">
		</form>
	</div>

	<script type="text/javascript">
				$('.box form').submit(function(){
					alert('here');
					var today=new Date();
					var date = today.getFullYear()+'-'+(today.getMonth()+1)+'-'+today.getDate();
					if (form.origin.value == form.destination.value) {
						alert('Origin and Destination are the same!');
					} else if(form.date.value<date){
						alert('Invaide Date Entry');
					} else {
						window.location.href = "customerHome.jsp";
					}
				}

	</script>
</body>
</html>
