package data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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

	//movie_id로 DTO반환
	public List<HashMap<String, String>> getScreeningDatas(String movie_id){
		List<HashMap<String, String>> list = new ArrayList<HashMap<String,String>>();
		Connection conn = db.getConnection();
		PreparedStatement pst = null;
		ResultSet rs = null;
		String sql ="select t.region, t.name as theater_name , a.name as auditorium_name , s.start_time,\r\n"
						+ "(select count(*) from seat st where a.id = st.auditorium_id ) AS total_seat,\r\n"
						+ "(select count(*) \r\n"
						+ "from seat_reserved str \r\n"
						+ "join reservation rs on str.reservation_id = rs.id \r\n"
						+ "where rs.screening_id = s.id) AS reserved_seats\r\n"
						+ "from screening s\r\n"
						+ "join auditorium a on a.id = s.auditorium_id\r\n"
						+ "join movie m on s.movie_id = m.id\r\n"
						+ "join theater t on t.id = a.theater_id\r\n"
						+ "where s.movie_id =?";

		try {
			pst = conn.prepareStatement(sql);
			pst.setString(1, movie_id);
			rs = pst.executeQuery();

			while(rs.next()) {

				HashMap<String, String> map = new HashMap<String, String>();
				map.put("region", rs.getString("region"));
				map.put("theater_name", rs.getString("theater_name"));
				map.put("auditorium_name", rs.getString("auditorium_name"));
				map.put("start_time", rs.getString("start_time"));
				map.put("total_seat", rs.getString("total_seat"));
				map.put("reserved_seats", rs.getString("reserved_seats"));

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
				+ " m.title,\r\n"
				+ " a.name as auditorium_name,\r\n"
				+ " m.runtime,\r\n"
				+ " t.name as theater_name,\r\n"
				+ " count(DISTINCT seat.id) as total_seat,\r\n"
				+ " count(DISTINCT r.id) as reserved_seatcount,\r\n"
				+ " count(distinct seat.id) - count(DISTINCT sr.id) as remaining_seats\r\n"
				+ "from screening s\r\n"
				+ "join movie m on s.movie_id = m.id\r\n"
				+ "join auditorium a on s.auditorium_id = a.id\r\n"
				+ "join theater t on a.theater_id = t.id\r\n"
				+ "join seat on seat.auditorium_id = a.id\r\n"
				+ "left join reservation r on r.screening_id = s.id\r\n"
				+ "left join seat_reserved sr on sr.reservation_id = r.id\r\n"
				+ "where s.movie_id =? and t.name = ?\r\n"
				+ "group by s.id";

		try {
			pst = conn.prepareStatement(sql);
			pst.setString(1, movie_id);
			pst.setString(2, theaterName);
			rs = pst.executeQuery();
			while(rs.next()) {
				HashMap<String, String> map = new HashMap<String, String>();

				map.put("start_time",rs.getString("start_time"));
				map.put("title",rs.getString("title"));
				map.put("auditorium_name",rs.getString("auditorium_name"));
				map.put("runtime",rs.getString("runtime"));
				map.put("theater_name",rs.getString("theater_name"));
				map.put("total_seat",rs.getString("total_seat"));
				map.put("reserved_seatcount",rs.getString(" reserved_seatcount"));
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

}