package test;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;

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
			stmt.executeUpdate("insert into owns (cEmail, accNum) values ('"+email+"',"+ accountNum + ")");

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
			stmt.executeUpdate("insert into Manager (employeeNum, password, username) values (0,'"+password+"','"+username+"')");
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
	public int newCustomer(String fname, String lname, String email, int ccNum, String address, String city, String state, int zip, int phone) {
        Connection con = getConnection();
        if (con == null) {
            return -2;
        }
        try {            
            LocalDate timeOfCreation = LocalDate.now();
            Statement stmt = con.createStatement();
            String statement = "insert into Customers (firstName, lastName, email, creationDate, creditCard, address, city, state, zip, phone, integer) values ('"
                    + fname + "','" + lname + "','" + email + "','" + timeOfCreation +  "','" + ccNum + "','" + address + "','" + city + "','" + state
                    + "','" + zip + "','" + phone + ")";
            System.out.println(statement);
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
}