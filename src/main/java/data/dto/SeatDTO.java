package data.dto;

public class SeatDTO {
	private String id;
	private String auditorium_id;
	private String seat_row;
	private String seat_col;
	private String seat_no;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getAuditorium_id() {
		return auditorium_id;
	}
	public void setAuditorium_id(String auditorium_id) {
		this.auditorium_id = auditorium_id;
	}
	public String getSeat_row() {
		return seat_row;
	}
	public void setSeat_row(String seat_row) {
		this.seat_row = seat_row;
	}
	public String getSeat_col() {
		return seat_col;
	}
	public void setSeat_col(String seat_col) {
		this.seat_col = seat_col;
	}
	public String getSeat_no() {
		return seat_no;
	}
	public void setSeat_no(String seat_no) {
		this.seat_no = seat_no;
	}
	
	
}
