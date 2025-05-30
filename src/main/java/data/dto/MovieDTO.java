package data.dto;

import java.sql.Timestamp;

public class MovieDTO {

	private String id;
	private String title;
	private String synopsis;
	private Timestamp release_date;
	private String certification;
	private int runtime;
	private String studio;
	private String distributor;
	private String poster_url;

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getSynopsis() {
		return synopsis;
	}
	public void setSynopsis(String synopsis) {
		this.synopsis = synopsis;
	}
	public Timestamp getRelease_date() {
		return release_date;
	}
	public void setRelease_date(Timestamp release_date) {
		this.release_date = release_date;
	}
	public String getCertification() {
		return certification;
	}
	public void setCertification(String rating) {
		this.certification = rating;
	}
	public int getRuntime() {
		return runtime;
	}
	public void setRuntime(int runtime) {
		this.runtime = runtime;
	}
	public String getStudio() {
		return studio;
	}
	public void setStudio(String studio) {
		this.studio = studio;
	}
	public String getDistributor() {
		return distributor;
	}
	public void setDistributor(String distributor) {
		this.distributor = distributor;
	}
	public String getPoster_url() {
		return poster_url;
	}
	public void setPoster_url(String poster_url) {
		this.poster_url = poster_url;
	}
}
