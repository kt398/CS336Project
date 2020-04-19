package test;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;
import java.util.Calendar;
import java.util.TimeZone;

import javax.servlet.*;

public class DbManager {

	public Connection getConnection() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Travel_Reservations", "root",
					"adminadmin");
			return con;
		} catch (Exception e) {
			System.out.println(e);
			return null;
		}
	}

	public void closeConnection(Connection con) {
		try {
			con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * Checks if the inputted username and password is in the database
	 * 
	 * @param username User inputted username
	 * @param password User inputted password
	 * @throws e if there was a problem retreiving data from the database
	 * @return 0 if a field is empty, -1 if username or password is incorrect,-2 for
	 *         database connection issues, 1 if success
	 *
	 */
	public int checkUserPass(String username, String password) {
		Connection con = getConnection();
		if (con == null) {
			return -2;
		}
		if (username.equals("") || password.equals("")) {
			closeConnection(con);
			return 0;
		}
		try {
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery("Select password from Accounts where username='" + username + "'");
			if (!rs.next()) {
				closeConnection(con);
				return -1;
			}
			String s = rs.getString("Password");
			if (s.equals(password)) {
				closeConnection(con);
				return 1;
			}
			closeConnection(con);
			return -1;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return -2;
		}
	}

	/**
	 * 
	 * @param username New Username
	 * @param password New Password
	 * @return -2 if problem connecting to the database, -1 the username exists, 0
	 *         if a field is empty, 1 if successfully created and customer exists,
	 *         and 2 if successfully created and customer does not exist
	 */
	public int newUser(String username, String password, String email) {

		Connection con = getConnection();
		if (con == null) {
			return -2;
		}
		if (username.equals("") || password.equals("")) {
			closeConnection(con);

			return 0;
		}
		try {
			int userExists = userExists(con, username);
			if (userExists == -1 || userExists == -2) {
				closeConnection(con);
				return -1;
			}
			Statement stmt = con.createStatement();
			stmt.executeUpdate("insert into Accounts (username, accNum, password) values ('" + username + "',0,'"
					+ password + "')");
			ResultSet rs = stmt.executeQuery("select accNum from Accounts where username='" + username + "'");
			rs.next();
			int accountNum = rs.getInt(1);
			stmt.executeQuery("set foreign_key_checks=0");
			stmt.executeUpdate("insert into owns (email, accNum) values ('" + email + "'," + accountNum + ")");
			stmt.executeQuery("set foreign_key_checks=1");

			if (emailExists(con, email)) {
				closeConnection(con);
				return 1;

			}
			closeConnection(con);
			return 2;
			// ResultSet rs= stmt.executeQuery("Select password from Accounts where
			// username='"+username+"'");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			closeConnection(con);
			return -2;
		}
	}

	private boolean emailExists(Connection con, String email) {
		try {
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery("select * from Customers where email='" + email + "'");
			if (!rs.next()) {
				return false;
			}
			return true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}

	/**
	 * 
	 * @param username User inputted username
	 * @return 1 if the username exists, -1 if it doesn't exist, and -2 if there is
	 *         a database connection error
	 */
	public int userExists(Connection con, String username) {
		if (con == null) {
			return -2;
		}
		try {
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery("Select * from Accounts where username='" + username + "'");
			if (rs.next()) {
				return -1;
			}
			return 1;

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return -2;
		}
	}

	/**
	 * 
	 * @param username User inputted username
	 * @return 1 if the username exists, -1 if it doesn't exist, and -2 if there is
	 *         a database connection error
	 */
	public int adminExists(String username) {
		Connection con = getConnection();
		if (con == null) {
			return -2;
		}
		try {
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery("Select * from Manager where username='" + username + "'");
			if (rs.next()) {
				return -1;
			}
			return 1;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return -2;
		}
	}

	/**
	 * 
	 * @param username User inputted username
	 * @param password User inputted password
	 * @return -2 if there is a database connection error, - if username exists, and
	 */
	public int newAdmin(String username, String password) {
		Connection con = getConnection();
		if (con == null) {
			return -2;
		}
		if (username.equals("") || password.equals("")) {
			closeConnection(con);
			return 0;
		}
		try {
			int adminExists = userExists(con, username);
			if (adminExists == -1 || adminExists == -2) {
				closeConnection(con);
				return -1;
			}
			Statement stmt = con.createStatement();
			stmt.executeUpdate("insert into Manager (employeeNum, password, username) values (0,'" + password + "','"
					+ username + "')");
			closeConnection(con);
			return 1;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			closeConnection(con);
			return -2;
		}
	}

	public int adminUserPass(String username, String password) {
		Connection con = getConnection();
		if (con == null) {
			return -2;
		}
		if (username.equals("") || password.equals("")) {
			closeConnection(con);
			return 0;
		}
		try {
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery("Select password from Manager where username='" + username + "'");
			if (!rs.next()) {
				closeConnection(con);
				return -1;
			}
			String s = rs.getString("Password");
			if (s.equals(password)) {
				closeConnection(con);
				return 1;
			}
			closeConnection(con);
			return -1;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return -2;
		}
	}

	public int newCustomer(String fname, String lname, String email, String ccNum, String address, String city,
			String state, String zip, String phone) {
		Connection con = getConnection();
		if (con == null) {
			return -2;
		}
		try {
			LocalDate timeOfCreation = LocalDate.now();
			Statement stmt = con.createStatement();
			String statement = "insert into Customers (firstName, lastName, email, creationDate, creditCard, address, city, state, zip, phone) values ('"
					+ fname + "','" + lname + "','" + email + "','" + timeOfCreation + "','" + ccNum + "','" + address
					+ "','" + city + "','" + state + "','" + zip + "','" + phone + "')";
			stmt.executeUpdate(statement);
			closeConnection(con);
			return 1;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			closeConnection(con);
			return -2;
		}
		// return 0;
	}

	/**
	 * 
	 * Gets the customer information for the given username and password
	 * 
	 * @param username username of the currently open account
	 * @param password password of the currently open account
	 * @return A string with each attribute seperated by "$/"
	 */
	public Results getCustomerInformation(String username) {
		ResultSet rs = null;
		Connection con = getConnection();
		if (con == null) {
			return null;
		}
		try {
			Statement stmt = con.createStatement();
			String statement = "Select * from Accounts a JOIN owns o ON a.accNum=o.accNum JOIN customers c ON o.email=c.email WHERE a.username=\""
					+ username + "\"";
			rs = stmt.executeQuery(statement);
		} catch (SQLException e) {
			e.printStackTrace();
			closeConnection(con);
			return null;
		}
		Results r = new Results(rs, con);
		return r;
	}

	public int updateCustomerInformation(String firstName, String lastName, String email, String username,
			String address, String city, String state, String zip, String creditCard, String phone) {
		Connection con = getConnection();
		if (con == null) {
			return -2;
		}
		try {
			Statement stmt = con.createStatement();
			String statement = "UPDATE Customers SET firstName=" + firstName + ", lastName=" + lastName + ", address="
					+ address + ", city=" + city + ", state=" + state + ", zip=" + zip + ", creditCard=" + creditCard
					+ ", phone=" + phone + " WHERE email=" + email;
			boolean s = stmt.execute(statement);
			int x = stmt.executeUpdate(statement);
		} catch (SQLException e) {
			e.printStackTrace();
			closeConnection(con);
			return -2;
		}
		closeConnection(con);
		return 0;
	}

	public Results getAllAirports() {
		Connection con = getConnection();
		if (con == null) {
			return null;
		}
		try {
			Statement stmt = con.createStatement();
			String statement = "Select id from Airports";
			ResultSet rs = stmt.executeQuery(statement);
			// closeConnection(con);
			Results r = new Results(rs, con);
			return r;
		} catch (SQLException e) {
			e.printStackTrace();
			closeConnection(con);
			return null;
		}
		
	}

	public int getDayFromDate(String date) {
		int year = Integer.parseInt(date.substring(0, 4));
		int month = Integer.parseInt(date.substring(5, 7)) - 1;
		int day = Integer.parseInt(date.substring(8));
		Calendar c = Calendar.getInstance();
		c.set(year, month, day);
		return c.get(Calendar.DAY_OF_WEEK);

	}

	public Results getFlights(String date, String from, String to) {
		int dayOfWeek = getDayFromDate(date);
		to = "\"" + to + "\"";
		from = "\"" + from + "\"";
		Results r = null;
		Connection con = getConnection();
		try {
			Statement stmt = con.createStatement();
			String statement = "SELECT airline,flightNum,departureTime,arrivalTime,fare FROM goTo JOIN fares on fares.distance=goTo.distance WHERE goTo.originAirportID="
					+ from + "AND goTo.DestinationAirportID=" + to + "AND workingDay=" + dayOfWeek +" order by flightNum asc";
			ResultSet rs = stmt.executeQuery(statement);
			r = new Results(rs, con);
		} catch (SQLException e) {
			e.printStackTrace();
			closeConnection(con);
			return null;
		}

		return r;
	}

	public Results getAirportFlights(String airport) {
		Results r = null;
		Connection con = getConnection();
		try {
			Statement stmt = con.createStatement();
			String query = "SELECT * from goTo WHERE goTo.originAirportID =\"" + airport
					+ "\" OR goTo.destinationAirportID =\"" + airport + "\"";
			ResultSet rs = stmt.executeQuery(query);
			r = new Results(rs, con);
		} catch (SQLException e) {
			e.printStackTrace();
			closeConnection(con);
			return null;
		}
		return r;
	}

	public Results getMonthReservations(String date) {
		Results r = null;
		Connection con = getConnection();
		try {
			Statement stmt = con.createStatement();
			String query = "SELECT date,bFee,tFare FROM Reservations WHERE Reservations.date LIKE '%" + date + "%'";
			ResultSet rs = stmt.executeQuery(query);
			r = new Results(rs, con);
		} catch (SQLException e) {
			e.printStackTrace();
			closeConnection(con);
			return null;
		}
		return r;
	}

	public void makeNewReservation(String username, String password, ReservationData data, Legs[] listOfLegs) {

	}

	public int findDaysDifference(String date) {
		System.out.println(date);
		int year = Integer.parseInt(date.substring(0, 4));
		int month = Integer.parseInt(date.substring(5, 7)) - 1;
		int day = Integer.parseInt(date.substring(8));
		Calendar c = Calendar.getInstance();
		c.set(Calendar.MONTH, month);
		c.set(Calendar.YEAR, year);
		c.set(Calendar.DATE, day);
		java.util.Date d1 = c.getTime();
		return (int) Math.abs((d1.getTime() - System.currentTimeMillis()) / (1000 * 60 * 60 * 24));
	}

	public Results getTwoLegFlights(String date, String from, String to) {
		int dayOfWeek = getDayFromDate(date);
		to = "\"" + to + "\"";
		from = "\"" + from + "\"";
		Results r = null;
		Connection con = getConnection();
		try {
			Statement stmt = con.createStatement();
			String statement = "select g1.originAirportID,g1.airline,g1.flightNum,g1.departureTime,g1.arrivalTime,g1.destinationAirportID,g2.airline,g2.flightNum,g2.departureTime,g2.arrivalTime,g2.destinationAirportID,(f1.fare+f2.fare),(g1.distance+g2.distance) "
					+ "from (goTo g1 join fares f1 on g1.distance=f1.distance),(goTo g2 join fares f2 on g2.distance=f2.distance) "
					+ "where g1.originAirportID=" + from + "AND g2.destinationAirportID=" + to
					+ "and g1.destinationAirportID=g2.originAirportID and g1.arrivalTime<g2.departureTime and g1.workingday=g2.workingday and g1.workingday="
					+ dayOfWeek + " order by (g1.distance+g2.distance) asc limit 15";
			ResultSet rs = stmt.executeQuery(statement);
			r = new Results(rs, con);
		} catch (SQLException e) {
			e.printStackTrace();
			closeConnection(con);
			return null;
		}
		return r;
	}

	public int addAllReservationData(ReservationData r,String username) {
		Connection con = getConnection();
		if (con == null) {
			return -2;
		}
		try {
			LocalDate timeOfCreation = LocalDate.now();
			String timeCreate = "\"" + timeOfCreation + "\"";
			Statement stmt = con.createStatement();
			String statement = "select accounts.accNum from Accounts where Accounts.username=\""+username+"\"";
			ResultSet rs=stmt.executeQuery(statement);
			rs.next();
			String accNum=rs.getString("accNum");
			rs.close();
			if(r.type.compareTo("roundTrip")==0)
				statement="insert into reservations (date, passengers, tripType, bFee, tFare,resNum) values ("+timeCreate+","+r.passengers+",\"Round-Trip\","+r.b_fee+","+r.t_fare+",0)";
			else {
				statement="insert into reservations (date, passengers, tripType, bFee, tFare,resNum) values ("+timeCreate+","+r.passengers+",\"One-Way\","+r.b_fee+","+r.t_fare+",0)";
			}
			stmt.executeUpdate(statement,Statement.RETURN_GENERATED_KEYS);
			System.out.println(statement);
			rs = stmt.getGeneratedKeys();
			int resNum;
			rs.next();
			resNum = rs.getInt(1);
			System.out.println("ResNum: " + resNum);
			statement="insert into Contain (resNum,accNum) values ("+resNum+","+accNum+")";
			stmt.executeUpdate(statement);
			
		       for(int i=0;i<r.legs.size();i++) {
	                statement="insert into legs (legID,legDate) values(0,\""+r.legs.get(i).flightDate+"\")";
	                stmt.executeUpdate(statement,Statement.RETURN_GENERATED_KEYS);
	                rs= stmt.getGeneratedKeys();
	                rs.next();
	                int legID = rs.getInt(1);
	                System.out.println("legid: " +legID);
	                statement="insert into Have (legID,resNum) values("+legID+","+resNum+")";
	                stmt.executeUpdate(statement);
	                statement="insert into Associated (legID, flightNum, airline) values ("+legID+",\""+r.legs.get(i).flightNumber+"\",\""+r.legs.get(i).airline+"\")";
	                stmt.executeUpdate(statement);
	                int workingDays=this.getDayFromDate(r.legs.get(i).flightDate);
	                statement="select goToID from goTo where flightNum='"+r.legs.get(i).flightNumber+"' and "
	                		+ "airline='"+r.legs.get(i).airline+"' and originAirportID='"+r.legs.get(i).fromAirport+"' and "
            				+ "destinationAirportID='"+r.legs.get(i).toAirport+"' and arrivalTime=\""+r.legs.get(i).arrivalTime+"\" and "
    						+ "departureTime=\""+r.legs.get(i).departureTime+"\" and workingDay="+workingDays;
	                rs=stmt.executeQuery(statement);
	                rs.next();
	                int goToID=rs.getInt("goToID");
	                System.out.println("GOTOID: "+ goToID);
	                statement="insert into goToLegs (goToID,legID) values ("+goToID+","+legID+")";
	                stmt.executeUpdate(statement);
	            }
			closeConnection(con);
			return 1;
		} catch (SQLException e) {
			e.printStackTrace();
			closeConnection(con);
			return -2;
		}
		// return 0;
	}
	
	
	public Results getCustomerReservations(String username) {
		Connection con = getConnection();
		Results r = null;
		try {
			Statement stmt = con.createStatement();
			String query = "select legDate,originAirportID,destinationAirportID,flightNum,airline,departureTime,arrivalTime,class,seatNum "
					+ "from goTo NATURAL JOIN goToLegs NATURAL JOIN Legs NATURAL JOIN Have Natural JOIN Reservations "
					+ "NATURAL JOIN Contain WHERE Contain.accNum IN (select accNum from Accounts where Accounts.username=\""+username+"\")";
			ResultSet rs = stmt.executeQuery(query);
			r = new Results(rs, con);
		} catch (SQLException e) {
			e.printStackTrace();
			closeConnection(con);
		}
		return r;
	}
}