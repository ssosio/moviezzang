package data.dao;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import data.dto.ReviewDTO;
import mysql.db.DBConnect;

public class ReviewDAO {
	DBConnect db = new DBConnect();
	private static ReviewDAO dao = new ReviewDAO();
	
	private ReviewDAO() {
		
	}
	
	public static ReviewDAO getInstance() {
		return dao;
	}
	
	
	
	public int insertReview(ReviewDTO dto) {
		// NOW()를 사용하여 현재 시간을 자동으로 입력
		String sql = "INSERT INTO review (id, movie_id, user_id, content, rating, created_at) VALUES (null, ?, ?, ?, ?, NOW())";
		Connection conn = db.getConnection();;
		PreparedStatement pstmt = null;
		
		try {
		
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getMovieId());
			pstmt.setString(2, dto.getUserId());
			pstmt.setString(3, dto.getContent());
			pstmt.setInt(4, dto.getRating());
	
			
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			db.dbClose(pstmt, conn);
		}
		return 0;
	}
	
	
	// 리뷰 목록 조회 메서드
	public List<ReviewDTO> getReviewsByMovieId(String movieId) {
	    List<ReviewDTO> list = new ArrayList<>();
	    String sql = "SELECT user_id, content, rating, created_at FROM review WHERE movie_id = ? ORDER BY created_at DESC";

	    Connection conn = db.getConnection();
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;

	    try {
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, movieId);
	        rs = pstmt.executeQuery();

	        while (rs.next()) {
	            ReviewDTO dto = new ReviewDTO();
	            dto.setUserId(rs.getString("user_id"));
	            dto.setContent(rs.getString("content"));
	            dto.setRating(rs.getInt("rating"));
	            dto.setCreatedAt(rs.getTimestamp("created_at")); // Date/Time 객체면 Timestamp로

	            list.add(dto);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        db.dbClose(rs, pstmt, conn);
	    }

	    return list;
	}

	
	
}