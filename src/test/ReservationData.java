package test;

import java.util.ArrayList;

public class ReservationData {
	int resNum;
	public String reservationDate;
	public String goDate;
	public String returnDate;
	public String destination;
	public String origin;
	public int passengers;
	public double t_fare;
	public double b_fee;
	int c_rep;
	public String type;
	public ArrayList<Legs> legs = new ArrayList<Legs>();

	public ReservationData() {
	}

	public void setPassengers(int pass) {
		passengers = pass;
	}

	public int getPassenger() {
		return passengers;
	}

	public void setDate(String Date) {
		reservationDate = Date;
	}

	public String getDate() {
		return reservationDate;
	}
	
}
