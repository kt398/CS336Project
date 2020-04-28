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
		height:100%;
		margin: 0;
		padding: 0;
	}
	
	#slideshow{
		background-image: url("../images/artur-tumasjan-KZSNMN4VxR8-unsplash.jpg");
		z-index:-1;
		position:absolute;
		width:100%;
		height:100%;
	}
	
	.mySlides{
		display: none;
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
			<div id='slideshow'>
				<img class="mySlides" src="../images/artur-tumasjan-KZSNMN4VxR8-unsplash.jpg">
				<img class="mySlides" src="../images/belinda-fewings-DpwWav9DhKk-unsplash.jpg">
				<img class="mySlides" src="../images/kelsey-knight-SFRw5GChoLA-unsplash.jpg">
				<img class="mySlides" src="../images/ross-parmly-rf6ywHVkrlY-unsplash.jpg">
			</div>
		</nav>
		
</body>

<script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
<script>
	$(document).ready(function(){
		var x = Array();
		$(".mySlides").each(function() {
		  x.push($(this).attr("src"));
		});
		var i = 1;
		setInterval(function(){
			setTimeout(function(){
				var url = x[i++];
				$('#slideshow').fadeOut(2000, function () {
					$('#slideshow').css('background-image','url("'+url+'")');
					$('#slideshow').fadeIn(2000);
				});
				if(i==4) i=0;
			}, 3000);
		}, 8000);
	});
	
</script>
</html>