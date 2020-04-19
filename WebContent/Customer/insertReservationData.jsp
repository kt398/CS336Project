 <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="test.*,java.sql.ResultSet,java.sql.ResultSetMetaData"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href="../css/navBar.css">

<title>Insert title here</title>
</head>
<body>
	<%
	DbManager db = new DbManager();
	ReservationData res = (ReservationData)session.getAttribute("reservation");
	String username = (String)session.getAttribute("username");
	db.addAllReservationData(res,username);
	%>
	<script>
		window.location.href = "customerHome.jsp";
	</script>
</body>

<script type="text/javascript">

</script>
</html>