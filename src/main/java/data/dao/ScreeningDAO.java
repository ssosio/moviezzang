package data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

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
	public ScreeningDTO getScreeningData(String movie_id) {
		ScreeningDTO dto = new ScreeningDTO();
		Connection conn = db.getConnection();
		PreparedStatement pst = null;
		ResultSet rs = null;

		String sql = "select * from screening where movie_id="+movie_id;

		return dto;
	}
}
