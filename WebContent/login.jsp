<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>


<!DOCTYPE html>
<html>
<head>
<title>Rutgers cs336 Project</title>
<link rel="stylesheet" type="text/css" href="css/login.css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>

<body>
	<h1>Rutgers cs366 Project</h1>
	<div class="login-page">
		<div class="form">
			<form class="register" method="post" action="newUser.jsp">
				<input type="text" placeholder="username" name="username" required /> <input
					type="password" placeholder="password" name="password" required/> <input
					type="email" placeholder="email" name="email" required/>
				<button>create</button>
				<p class="message">
					Already registered? <a href="#">Sign In</a>
				</p>
			</form>

			<form class="login" method="post" action="checkUser.jsp">
				<input type="text" placeholder="username" name="username" /> <input
					type="password" placeholder="password" name="password" />
				<button>login</button>
				<p class="message">
					Not registered? <a href="#">Create an account</a>
				</p>
				<p class="message">
					System Admin? <a href="adminLogin.jsp">Sign in as Admin</a>
			</form>
		</div>
	</div>

	<script
		src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
	<script type="text/javascript">
		$(document).ready(function() {
			if (window.location.href.indexOf('signup') != -1) {
				$('.login').hide();
				$('.register').show();
			} else {
				$('.login').show();  
				$('.register').hide();
			}
		});

		$('.message a').click(function() {
			$('form').animate({
				height : "toggle",
				opacity : "toggle"
			}, "slow");
		});
	</script>

</body>
</html>