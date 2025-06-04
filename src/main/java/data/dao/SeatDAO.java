package data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import mysql.db.DBConnect;

public class SeatDAO {
	DBConnect db = new DBConnect();
	private static SeatDAO dao = new SeatDAO();

	private SeatDAO() {

	}
	public static SeatDAO getInstance() {
		return dao;
	}

	//좌석정보
	public List<HashMap<String, String>> getSeatInfo(String screening_id){
		List<HashMap<String,String>> list = new ArrayList<HashMap<String,String>>();
		Connection conn = db.getConnection();
		PreparedStatement pst = null;
		ResultSet rs = null;

		String sql ="SELECT "
				+ "s.id AS seat_id, "
				+ "s.seat_row, "
				+ "s.seat_col, "
				+ "CASE WHEN sr.id IS NULL THEN 0 ELSE 1 END AS is_reserved, "
				+ "s.seat_no, "
				+ "m.title AS movie_title, "
				+ "m.poster_url AS poster, "
				+ "a.name AS auditorium_name, "
				+ "t.name AS theater_name, "
				+ "sc.start_time, "
				+ "sc.price "
				+ "FROM seat s "
				+ "JOIN auditorium a ON s.auditorium_id = a.id "
				+ "JOIN theater t ON a.theater_id = t.id "
				+ "JOIN screening sc ON sc.auditorium_id = a.id "
				+ "JOIN movie m ON sc.movie_id = m.id "
				+ "LEFT JOIN reservation r ON r.screening_id = sc.id "
				+ "LEFT JOIN seat_reserved sr ON sr.reservation_id = r.id AND sr.seat_id = s.id "
				+ "WHERE sc.id = ? "
				+ "ORDER BY s.seat_row, s.seat_col";
		try {
			pst=conn.prepareStatement(sql);
			pst.setString(1, screening_id);
			rs=pst.executeQuery();
			while(rs.next()) {
				HashMap<String, String> map = new HashMap<String, String>();
				map.put("seat_id", rs.getString("seat_id"));
				map.put("seat_row", rs.getString("seat_row"));
				map.put("seat_col", rs.getString("seat_col"));
				map.put("is_reserved", rs.getString("is_reserved"));
				map.put("seat_no", rs.getString("seat_no"));
				map.put("movie_title", rs.getString("movie_title"));
				map.put("poster", rs.getString("poster"));
				map.put("auditorium_name", rs.getString("auditorium_name"));
				map.put("theater_name", rs.getString("theater_name"));
				map.put("start_time", rs.getString("start_time"));
				map.put("price", rs.getString("price"));

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
