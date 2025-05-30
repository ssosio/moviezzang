package data.dto;

import java.sql.Timestamp;

public class ScreeningDTO {


	private String id;
	private String movie_id;
	private String auditorium_id;
	private Timestamp start_time;
	private int price;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getMovie_id() {
		return movie_id;
	}
	public void setMovie_id(String movie_id) {
		this.movie_id = movie_id;
	}
	public String getAuditorium_id() {
		return auditorium_id;
	}
	public void setAuditorium_id(String auditorium_id) {
		this.auditorium_id = auditorium_id;
	}
	public Timestamp getStart_time() {
		return start_time;
	}
	public void setStart_time(Timestamp start_time) {
		this.start_time = start_time;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}


}
