package test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
public class DbManager {
	
	
	public Connection getConnection() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/Travel_Reservations", "root", "adminadmin");
			return con;
		}catch(Exception e) {
			System.out.println(e);
			return null;
		}
	}
	/**
	 * Checks if the inputted username and password is in the database
	 * @param con Connection to the database
	 * @param username User inputted username
	 * @param password User inputted password
	 * @throws e if there was a problem retreiving data from the database
	 * @return 0 if a field is empty, -1 if username or password is incorrect,-2 for database connection issues, 1 if success
	 *
	 */
	public int checkUserPass(Connection con,String username,String password) {
		if(username.equals("")||password.equals("")){
			return 0;
		}
		try {
			Statement stmt = con.createStatement();
			ResultSet rs=stmt.executeQuery("Select password from Accounts where username='"+username+"'");
			if(!rs.next()) {
				return -1;
			}
			do {
				String s=rs.getString("Password");
				if(s.equals(password)) {
					return 1;
				}
				return -1;
			}while(rs.next());
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return -2; 
		}
	}
	
	
	public int newUser(Connection con,String username,String password) {
		if(username.equals("") || password.equals("")){
			return 0;
		}
		try {
			int userExists = userExists(con,username);
			if(userExists == -1 || userExists == -2)
				return -1;
			Statement stmt = con.createStatement();
			//ResultSet rs= stmt.executeQuery("Select password from Accounts where username='"+username+"'");
			stmt.executeUpdate("insert into Accounts (username, accountNumber, password) values ('"+username+"',0,'"+password+"')");
			return 1;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return -2; 
		}
	}
	
	
    /**
     * 
     * @param con Connection to database
     * @param username User inputted username
     * @return 1 if the username exists, -1 if it doesn't exist, and -2 if there is a database connection error
     */
    public int userExists(Connection con,String username) {
        try {
            Statement stmt = con.createStatement();
            ResultSet rs=stmt.executeQuery("Select * from Accounts where username='"+username+"'");
            if(rs.next()) {
                return -1;
            }
            return 1;

        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            return -2; 
        }
    }
	
}