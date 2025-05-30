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

		String sql = "insert into movie values(null, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getSynopsis());
			pstmt.setDate(3, dto.getRelease_date());
			pstmt.setString(4, dto.getCertification());
			pstmt.setInt(5, dto.getRuntime());
			pstmt.setString(6, dto.getStudio());
			pstmt.setString(7, dto.getDistributor());
			pstmt.setString(8, dto.getPoster_url());
			pstmt.setFloat(9, dto.getScore());
			pstmt.setFloat(10, dto.getLocal_score());

			pstmt.execute();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			db.dbClose(pstmt, conn);
		}
	}

	// 관람등급 문자열 변환
	private String convertCertification(String cert)
	{
		if (cert == null || cert.isEmpty())
		{			
			return "준비중";
		}

	    switch(cert) 
	    {
	        case "ALL": 
	        	return "전체관람가";
	        case "12":  
	        	return "12세 이상";
	        case "15":  
	        	return "15세 이상";
	        case "19":  
	        	return "청소년관람불가";
	        default:    
	        	return "준비중";
	    }
	}
	
	public void insertData(JSONArray arr)
	{
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		
		// 배급사는 받아올 수 없어서 null로 일단 삽입
		String sql = "insert into movie values(null, ?, ?, ?, ?, ?, ?, null, ?, ?, ?)";
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			for(Object obj : arr)
			{
				JSONObject jobj = (JSONObject)obj;
				
				pstmt.setString(1, (String)jobj.get("title"));
				pstmt.setString(2, (String)jobj.get("overview"));
				
				// 날짜 타입 변환
				pstmt.setDate(3, Date.valueOf((String)jobj.get("release_date")));
				pstmt.setString(4, this.convertCertification((String)jobj.get("certification")));

				// TMDB는 runtime을 Long 혹은 Integer 타입으로 반환함 (없으면 null)
				// DTO에서 int로 쓰고 싶다면 int로 변환해줘야함
				Object runtime = jobj.get("runtime");
				if(runtime != null)
				{
					pstmt.setInt(5, ((Number) runtime).intValue());
				}
				else
				{
					// null 이라면 0으로 default값
					pstmt.setInt(5, 0);
				}
				
				pstmt.setString(6, (String)jobj.get("studio"));
				pstmt.setString(7, (String)jobj.get("poster"));
				pstmt.setFloat(8, Math.round(((Number) jobj.get("score")).floatValue() * 10) / 10.0f);
				pstmt.setFloat(9, 0.0f);
				
				pstmt.executeUpdate();
			}
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
				dto.setRelease_date(rs.getDate("release_date"));
				dto.setCertification(rs.getString("certification"));
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
