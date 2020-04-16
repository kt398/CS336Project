<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="test.*,java.sql.ResultSet"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<script type="text/javascript">
		function compareAirports(theForm) {
			if (theForm.origin.value == theForm.destination.value) {
				alert('Origin and Destination are the same!');
				return false;
			} else {
				window.location.href = "makeResrvationListAirports.jsp";
			}
		}
	</script>
	<nav>
		<ul>
			<li><a class="top" href="../login.jsp">Home</a></li>
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
		ResultSet rs = manager.getAllAirports();
		while(rs==null){
			rs=manager.getAllAirports();
		}
	%>
	<div class="box">
		<h1 class="header1">Enter Information</h1>
		<form onSubmit="compareAirports(this)">
			<h2>From:</h2>
			<br> <select class="origin">
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










		</form>
	</div>


</body>
</html>