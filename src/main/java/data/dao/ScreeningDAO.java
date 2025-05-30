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

				  System.out.println("region: " + rs.getString("region"));
				  System.out.println("theater_name: " + rs.getString("theater_name"));
				  System.out.println("auditorium_name: " + rs.getString("auditorium_name"));
				  System.out.println("start_time: " + rs.getString("start_time"));
				    System.out.println("total_seat: " + rs.getString("total_seat"));
				    System.out.println("reserved_seats: " + rs.getString("reserved_seats"));
				    System.out.println("--------");
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

}
