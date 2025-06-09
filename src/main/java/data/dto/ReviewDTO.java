package data.dto;

import java.sql.Timestamp;

public class ReviewDTO {
    private String id;
    private String movieId;
    private String userId;
    private String content;
    private int rating;
    private Timestamp createdAt;

    // 기본 생성자
    public ReviewDTO() {}

    // 전체 필드를 받는 생성자 (선택 사항)
    public ReviewDTO(String id, String movieId, String userId, String content, int rating, Timestamp createdAt) {
        this.id = id;
        this.movieId = movieId;
        this.userId = userId;
        this.content = content;
        this.rating = rating;
        this.createdAt = createdAt;
    }

    // Getter & Setter

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getMovieId() {
        return movieId;
    }

    public void setMovieId(String movieId) {
        this.movieId = movieId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
}
