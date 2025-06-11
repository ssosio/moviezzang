package data.dto;

import java.sql.Timestamp;

public class ReservationDTO {

	private String id;
	private String screening_id;
	private String user_id;
	private Timestamp reserved_at;
	private String booked;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getScreening_id() {
		return screening_id;
	}
	public void setScreening_id(String screening_id) {
		this.screening_id = screening_id;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public Timestamp getReserved_at() {
		return reserved_at;
	}
	public void setReserved_at(Timestamp reserved_at) {
		this.reserved_at = reserved_at;
	}
	public String getBooked() {
		return booked;
	}
	public void setBooked(String booked) {
		this.booked = booked;
	}


}
