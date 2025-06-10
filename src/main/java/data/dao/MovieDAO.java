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

		String sql = "insert into movie values(null, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

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
			pstmt.setString(11, dto.getGenre());

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
		String sql = "insert into movie values(null, ?, ?, ?, ?, ?, ?, null, ?, ?, ?, ?)";
		
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
				
				// 장르는 또다른 JSON배열로 저장되므로 String으로 변환하는 추가 과정이 필요
				JSONArray genres = (JSONArray) jobj.get("genres");
				
				if (genres != null) 
				{
					// , 로 구분해서 저장
				    String genresStr = String.join(",", genres);
				    pstmt.setString(10, genresStr);
				} 
				else 
				{
				    pstmt.setString(10, "준비중");
				}
				
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
				dto.setSynopsis(rs.getString("synopsis"));
				dto.setRelease_date(rs.getDate("release_date"));
				dto.setCertification(rs.getString("certification"));
				dto.setRuntime(rs.getInt("runtime"));
				dto.setStudio(rs.getString("studio"));
				dto.setDistributor(rs.getString("distributor"));
				dto.setPoster_url(rs.getString("poster_url"));
				dto.setScore(rs.getFloat("score"));
				dto.setLocal_score(rs.getFloat("local_score"));
				dto.setGenre(rs.getString("genre"));

				list.add(dto);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			db.dbClose(rs, pstmt, conn);
		}

		return list;
	}

	// 영화 검색용		// 특정 문자열을 포함하는 제목을 가진 영화목록 출력
	public List<MovieDTO> getDatasByTitle(String keyword)
	{
		List<MovieDTO> list = new ArrayList<MovieDTO>();

		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "select * from movie where title like ?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%" + keyword + "%");
			rs = pstmt.executeQuery();
			
			while(rs.next())
			{
				MovieDTO dto = new MovieDTO();

				dto.setId(rs.getString("id"));
				dto.setTitle(rs.getString("title"));
				dto.setSynopsis(rs.getString("synopsis"));
				dto.setRelease_date(rs.getDate("release_date"));
				dto.setCertification(rs.getString("certification"));
				dto.setRuntime(rs.getInt("runtime"));
				dto.setStudio(rs.getString("studio"));
				dto.setDistributor(rs.getString("distributor"));
				dto.setPoster_url(rs.getString("poster_url"));
				dto.setScore(rs.getFloat("score"));
				dto.setLocal_score(rs.getFloat("local_score"));
				dto.setGenre(rs.getString("genre"));

				list.add(dto);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			db.dbClose(rs, pstmt, conn);
		}
		
		return list;
	}
	
	// ID 기준으로 영화 1개 조회 (*)
	public MovieDTO getMovieById(String id) {
	    Connection conn = db.getConnection();
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    MovieDTO dto = null;

	    String sql = "SELECT * FROM movie WHERE id = ?";

	    try {
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, id);
	        rs = pstmt.executeQuery();

	        if (rs.next()) {
	            dto = new MovieDTO();
	        	dto.setId(rs.getString("id"));
				dto.setTitle(rs.getString("title"));
				dto.setSynopsis(rs.getString("synopsis"));
				dto.setRelease_date(rs.getDate("release_date"));
				dto.setCertification(rs.getString("certification"));
				dto.setRuntime(rs.getInt("runtime"));
				dto.setStudio(rs.getString("studio"));
				dto.setDistributor(rs.getString("distributor"));
				dto.setPoster_url(rs.getString("poster_url"));
				dto.setScore(rs.getFloat("score"));
				dto.setLocal_score(rs.getFloat("local_score"));
				dto.setGenre(rs.getString("genre"));
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        db.dbClose(rs, pstmt, conn);
	    }

	    return dto;
	}
	// 타이틀로조회
	public MovieDTO getMovieBytitle(String title) {
	    Connection conn = db.getConnection();
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    MovieDTO dto = null;

	    String sql = "SELECT * FROM movie WHERE title = ?";

	    try {
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, title);
	        rs = pstmt.executeQuery();

	        if (rs.next()) {
	            dto = new MovieDTO();
	        	dto.setId(rs.getString("id"));
				dto.setTitle(rs.getString("title"));
				dto.setSynopsis(rs.getString("synopsis"));
				dto.setRelease_date(rs.getDate("release_date"));
				dto.setCertification(rs.getString("certification"));
				dto.setRuntime(rs.getInt("runtime"));
				dto.setStudio(rs.getString("studio"));
				dto.setDistributor(rs.getString("distributor"));
				dto.setPoster_url(rs.getString("poster_url"));
				dto.setScore(rs.getFloat("score"));
				dto.setLocal_score(rs.getFloat("local_score"));
				dto.setGenre(rs.getString("genre"));
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        db.dbClose(rs, pstmt, conn);
	    }

	    return dto;
	}
	
	
	// 추천영화 ex) 영화장르가 공포 , 스릴러 , 액션 이라면 공포or스릴러or액션 에 해당하는 요소를 뽑아
	public List<MovieDTO> getRecommends(String id) {
	    List<MovieDTO> list = new ArrayList<>();
	    Connection conn = db.getConnection();
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;

	    String sql = """
	    SELECT DISTINCT m2.id, m2.title, m2.score, m2.poster_url ,m2.genre
	    FROM movie m1
	    JOIN movie m2 ON m1.id != m2.id
	    WHERE m1.id = ?
	      AND (
	        m2.genre LIKE CONCAT('%', SUBSTRING_INDEX(m1.genre, ',', 1), '%')
	        OR m2.genre LIKE CONCAT('%', SUBSTRING_INDEX(SUBSTRING_INDEX(m1.genre, ',', 2), ',', -1), '%')
	        OR m2.genre LIKE CONCAT('%', SUBSTRING_INDEX(SUBSTRING_INDEX(m1.genre, ',', 3), ',', -1), '%')
	      )
	    ORDER BY m2.score DESC
	    LIMIT 5
	    """;

	    try {
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, id);
	        rs = pstmt.executeQuery();

	        while (rs.next()) {
	            MovieDTO dto = new MovieDTO();
	            dto.setId(rs.getString("id"));
	            dto.setTitle(rs.getString("title"));
	            dto.setScore(rs.getFloat("score"));
	            dto.setPoster_url(rs.getString("poster_url"));
	            dto.setGenre(rs.getString("genre"));
	            list.add(dto);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        db.dbClose(rs, pstmt, conn);
	    }
	    return list;
	}
	
	
	
	
	
	
	
	
	
	
	// 특정 영화의 평균 평점 계산 (리뷰 기반)
	public double getAverageRating(String movieId) {
	   Connection conn = db.getConnection();
	   PreparedStatement pstmt = null;
	   ResultSet rs = null;
	   double averageRating = 0.0;

	   String sql = "SELECT AVG(rating) as avg_rating FROM review WHERE movie_id = ?";

	   try {
	       pstmt = conn.prepareStatement(sql);
	       pstmt.setString(1, movieId);
	       rs = pstmt.executeQuery();

	       if (rs.next()) {
	           averageRating = rs.getDouble("avg_rating");
	       }

	   } catch (SQLException e) {
	       e.printStackTrace();
	   } finally {
	       db.dbClose(rs, pstmt, conn);
	   }

	   return averageRating;
	}

	// 특정 영화의 평균 평점을 별점(5점 만점)으로 계산
	public double getAverageStars(String movieId) {
	   double averageRating = getAverageRating(movieId);
	   return averageRating / 2.0; // 10점 만점을 5점 만점으로 변환
	}

	// 특정 영화의 리뷰 개수 조회
	public int getReviewCount(String movieId) {
	   Connection conn = db.getConnection();
	   PreparedStatement pstmt = null;
	   ResultSet rs = null;
	   int count = 0;

	   String sql = "SELECT COUNT(*) as review_count FROM review WHERE movie_id = ?";

	   try {
	       pstmt = conn.prepareStatement(sql);
	       pstmt.setString(1, movieId);
	       rs = pstmt.executeQuery();

	       if (rs.next()) {
	           count = rs.getInt("review_count");
	       }

	   } catch (SQLException e) {
	       e.printStackTrace();
	   } finally {
	       db.dbClose(rs, pstmt, conn);
	   }

	   return count;
	}

	// 영화의 local_score 업데이트 (리뷰 평균으로)
	public void updateLocalScore(String movieId) {
	   Connection conn = db.getConnection();
	   PreparedStatement pstmt = null;
	   
	   double averageRating = getAverageRating(movieId);
	   
	   String sql = "UPDATE movie SET local_score = ? WHERE id = ?";

	   try {
	       pstmt = conn.prepareStatement(sql);
	       pstmt.setFloat(1, (float) averageRating);
	       pstmt.setString(2, movieId);
	       pstmt.executeUpdate();

	   } catch (SQLException e) {
	       e.printStackTrace();
	   } finally {
	       db.dbClose(pstmt, conn);
	   }
	}

	// delete
}
