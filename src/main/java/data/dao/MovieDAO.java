package data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import data.dto.MovieDTO;
import mysql.db.DBConnect;

public class MovieDAO {
	DBConnect db = new DBConnect();
	private static MovieDAO dao = new MovieDAO();
		
	private MovieDAO()
	{
		
	}
	
	public static MovieDAO getInstance()
	{
		return dao;
	}
	
	// 데이터 삽입
	public void insertData(MovieDTO dto)
	{
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		
		String sql = "insert into movie values(null, ?, ?, ?, ?, ?, ?, ?, ?)";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getSynopsis());
			pstmt.setTimestamp(3, dto.getRelease_date());
			pstmt.setString(4, dto.getRating());
			pstmt.setInt(5, dto.getRuntime());
			pstmt.setString(6, dto.getStudio());
			pstmt.setString(7, dto.getDistributor());
			pstmt.setString(8, dto.getPoster_url());
			
			pstmt.execute();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			db.dbClose(pstmt, conn);
		}
	}
	
	// 모든 영화 데이터 조회		// 개봉일이 늦는 순서대로 출력
	public List<MovieDTO> getAllDatas()
	{
		List<MovieDTO> list = new ArrayList<MovieDTO>();
		
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "select * from movie order by release_date desc";
		
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next())
			{
				MovieDTO dto = new MovieDTO();
				
				dto.setId(rs.getString("id"));
				dto.setTitle(rs.getString("title"));
				dto.setRelease_date(rs.getTimestamp("release_date"));
				dto.setRating(rs.getString("rating"));
				dto.setRuntime(rs.getInt("runtime"));
				dto.setStudio(rs.getString("studio"));
				dto.setDistributor(rs.getString("distributor"));
				dto.setPoster_url(rs.getString("poster_url"));
				
				list.add(dto);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			db.dbClose(rs, pstmt, conn);
		}
		
		return list;
	}
	
	// delete
}
