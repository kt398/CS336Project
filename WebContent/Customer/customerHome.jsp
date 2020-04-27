<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Home Page</title>
<link rel="stylesheet" type="text/css" href="../css/customerHome.css">
<link rel="stylesheet" type="text/css" href="../css/navBar.css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<style>
	html,body{
		height: 100%;
		margin: 0;
	}
	.mySlides{
		display:none;
		width:100%;
		height: 95%;
		object-fit: cover;
	}
</style>
</head>
<body>
	<nav class="navbar">
		<a class="top topSelected" href="customerHome.jsp">Home</a> <a
			href="customerReservations.jsp">My Reservations</a> <a
			href="customerMakeReservation.jsp">Make Reservation</a> <a
			href="customerPersonalInformation.jsp">Personal Information</a> 
		<a class="bot" href="../logout.jsp">Logout</a>
	</nav>
	
	<img class="mySlides" src="../images/artur-tumasjan-KZSNMN4VxR8-unsplash.jpg">
	<img class="mySlides" src="../images/belinda-fewings-DpwWav9DhKk-unsplash.jpg">
	<img class="mySlides" src="../images/kelsey-knight-SFRw5GChoLA-unsplash.jpg">
	<img class="mySlides" src="../images/ross-parmly-rf6ywHVkrlY-unsplash.jpg">
</body>

<script>
	var slideIndex = 0;
	carousel();
	
	function carousel() {
	  var i;
	  var x = document.getElementsByClassName("mySlides");
	  for (i = 0; i < x.length; i++) {
	    x[i].style.display = "none";
	  }
	  slideIndex++;
	  if (slideIndex > x.length) {slideIndex = 1}
	  x[slideIndex-1].style.display = "block";
	  setTimeout(carousel, 2000); // Change image every 2 seconds
	}
</script>
</html>