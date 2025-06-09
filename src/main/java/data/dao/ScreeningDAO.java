package data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import data.dto.ScreeningDTO;
import mysql.db.DBConnect;

public class ScreeningDAO {
	DBConnect db = new DBConnect();

	private static ScreeningDAO dao = new ScreeningDAO();
	private ScreeningDAO() {
	}

	public static ScreeningDAO getInstance() {
		return dao;
	}

	//극장갯수
	public List<HashMap<String, String>> getTheaterCount(String movie_id){
		List<HashMap<String, String>> list = new ArrayList<HashMap<String,String>>();
		Connection conn = db.getConnection();
		PreparedStatement pst = null;
		ResultSet rs = null;
		String sql ="select t.region, count(distinct t.id) as theater_count\r\n"
				+ "from screening s\r\n"
				+ "join auditorium a on  a.id = s.auditorium_id\r\n"
				+ "join theater t on a.theater_id = t.id\r\n"
				+ "join movie m on s.movie_id = m.id\r\n"
				+ "where s.movie_id = ?\r\n"
				+ "group by t.region";

		try {
			pst = conn.prepareStatement(sql);
			pst.setString(1, movie_id);
			rs=pst.executeQuery();

			while(rs.next()) {
				HashMap<String, String> map = new HashMap<String, String>();
				map.put("region", rs.getString("region"));
				map.put("theater_count",rs.getString("theater_count"));

				list.add(map);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(rs, pst, conn);
		}

		return list;
	};

	//극장을 선택하면 모든 정보 나타내기(시간시간, 좌석수 등등)
	public List<HashMap<String, String>> getTheaterScreeningInfo(String movie_id,String theaterName){
		List<HashMap<String, String>> list = new ArrayList<HashMap<String,String>>();
		Connection conn = db.getConnection();
		PreparedStatement pst = null;
		ResultSet rs = null;
		String sql = "select\r\n"
				+ " s.start_time, \r\n"
				+ "s.id as screening_id, \r\n"
				+ "m.poster_url as poster, \r\n"
				+ " m.title,\r\n"
				+ " a.name as auditorium_name,\r\n"
				+ " m.runtime,\r\n"
				+ " t.name as theater_name,\r\n"
				+ " count(DISTINCT seat.id) as total_seat,\r\n"
				+ " count(DISTINCT r.id) as reserved_seatcount,\r\n"
				+ " count(distinct seat.id) - count(DISTINCT sr.id) as remaining_seat\r\n"
				+ "from screening s\r\n"
				+ "join movie m on s.movie_id = m.id\r\n"
				+ "join auditorium a on s.auditorium_id = a.id\r\n"
				+ "join theater t on a.theater_id = t.id\r\n"
				+ "join seat on seat.auditorium_id = a.id\r\n"
				+ "left join reservation r on r.screening_id = s.id\r\n"
				+ "left join seat_reserved sr on sr.reservation_id = r.id\r\n"
				+ "where s.movie_id =? and t.name = ?\r\n"
				+ "group by s.id  order by s.start_time";

		try {
			pst = conn.prepareStatement(sql);
			pst.setString(1, movie_id);
			pst.setString(2, theaterName);
			rs = pst.executeQuery();
			while(rs.next()) {
				HashMap<String, String> map = new HashMap<String, String>();

				map.put("start_time",rs.getString("start_time"));
				map.put("screening_id",rs.getString("screening_id"));
				map.put("poster",rs.getString("poster"));
				map.put("title",rs.getString("title"));
				map.put("auditorium_name",rs.getString("auditorium_name"));
				map.put("runtime",rs.getString("runtime"));
				map.put("theater_name",rs.getString("theater_name"));
				map.put("total_seat",rs.getString("total_seat"));
				map.put("reserved_seatcount",rs.getString("reserved_seatcount"));
				map.put("remaining_seat",rs.getString("remaining_seat"));

				list.add(map);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(rs, pst, conn);
		}
		return list;
	};
	
	// 상영스케줄 중복확인
	public boolean checkScheduleOverlap(String auditoriumId, Timestamp endTime, Timestamp startTime)
	{
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean isOverlap = false;
		
		String sql = "select count(*) from screening s " +
	             "join movie m ON s.movie_id = m.id " +
	             "where s.auditorium_id = ? " +
	             "and s.start_time < ? " +
	             "and (s.start_time + interval (m.runtime + 20) minute) > ?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, auditoriumId);
			pstmt.setTimestamp(2, endTime);
			pstmt.setTimestamp(3, startTime);
			
			rs = pstmt.executeQuery();
			
			if(rs.next())
			{
				// 0보다 크면 조회되는 스케줄이 있다는 것
				isOverlap = rs.getInt(1) > 0;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			db.dbClose(null, pstmt, conn);
		}
		
		return isOverlap;
	}
	
	// 상영스케줄 추가
	public void insertScreening(ScreeningDTO dto)
	{
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		
		String sql = "insert into screening values (null, ?, ?, ?, ?)";
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getMovie_id());
			pstmt.setString(2, dto.getAuditorium_id());
			pstmt.setTimestamp(3, dto.getStart_time());
			pstmt.setInt(4, dto.getPrice());
			
			pstmt.execute();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			db.dbClose(pstmt, conn);
		}
	}
}