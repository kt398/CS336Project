<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

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
            <li><a class="customerData" href="#" >Customer Information</a></li>
            <li><a class="salesReport" href="#" >Sales Report</a></li>
            <li><a class="allFlights" href="#" >List of all Flights</a></li>
            <li><a class="listReservations" href="#" >List of Reservations</a></li>
            <li><a class="listingRevenue" href="#" >Summary listing of Revenue</a></li>
            <li><a class="airportFlights" href="#" >Flights for Airports</a></li>
        </ul>
    </nav>
    
    <section class="adminHome">
        <p>Welcome!</p>
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
        <p>Change Customer Database</p>
        <div class="container">
            <form action=""><input type="submit" value="Add" /></form>
            <form action=""><input type="submit" value="Delete" /></form>
            <form action=""><input type="submit" value="Edit" /></form>
        </div>
    </section>
    
    <section class="salesReport">
        <p>Sales Report</p>
    </section>
    
    <section class="allFlights">
        <p>List of all Flights</p>
    </section>
    
    <section class="listReservations">
        <p>List of all Reservations</p>
    </section>
    
    <section class="listingRevenue">
        <p>Summary listing of Revenue</p>
    </section>
    
    <section class="airportFlights">
        <p>Flights for Airports</p>
    </section>
    
</body>
<script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
<script type="text/javascript">
    $(document).ready(function(){
        $("section").hide();
        $(".adminHome").show();
    });    
    
    $('a').click(function display(id){
        $("section").hide();
        $("section."+$(this).attr('class')).show();
    });
</script>

</html>