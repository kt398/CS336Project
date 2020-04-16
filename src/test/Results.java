package test;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Results {
	ResultSet rs;
	Connection con;

	public Results(ResultSet rs, Connection con) {
		this.rs=rs;
		this.con=con;
	}

	public void closeConnection() {
		try {
			con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public ResultSet getResultSet() {
		return rs;
	}
}
