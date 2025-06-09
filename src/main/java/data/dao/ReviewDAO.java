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
}