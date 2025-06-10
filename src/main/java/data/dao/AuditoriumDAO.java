package data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import data.dto.AuditoriumDTO;
import mysql.db.DBConnect;

public class AuditoriumDAO {
	DBConnect db= new DBConnect();
	private static AuditoriumDAO dao = new AuditoriumDAO();
	//프라이빗 생성자로 변경
	private AuditoriumDAO(){
	}
	//getInstance로 dao반환
	public static AuditoriumDAO getInstance() {
		return dao;
	}
	
	public List<AuditoriumDTO> getDatasByTheater(String theaterId)
	{
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<AuditoriumDTO> list = new ArrayList<AuditoriumDTO>();
																					// 1관 2관... 이렇게 나오도록
		String sql = "select * from auditorium where theater_id = ? order by name";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, theaterId);
			rs = pstmt.executeQuery();
			
			while(rs.next())
			{
				AuditoriumDTO dto = new AuditoriumDTO();
				
				dto.setId(rs.getString("id"));
				dto.setTheater_id(rs.getString("theater_id"));
				dto.setName(rs.getString("name"));
				
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
