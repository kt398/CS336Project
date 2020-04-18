package test;

public class ReservationData {
	int resNum;
	String reservationDate;
	public String destination;
	public String origin;
	int passengers;
	int t_fare;
	int c_rep;
	int b_fee;
	public String type;
	int numLegs;

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

	public void setLegs(int legs) {
		this.numLegs = legs;
	}

	public int getLegs() {
		return numLegs;
	}
}
