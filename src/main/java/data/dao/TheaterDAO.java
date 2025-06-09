package data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import data.dto.TheaterDTO;
import mysql.db.DBConnect;

public class TheaterDAO {
	DBConnect db = new DBConnect();
	private static TheaterDAO dao = new TheaterDAO();

	private TheaterDAO()
	{

	}

	public static TheaterDAO getInstance()
	{
		return dao;
	}

	// insert
	public void insertData()
	{
		System.out.println("저는 인서트에요");
	}

	// delete

	// 전체 데이터 조회
	public List<TheaterDTO> getAllDatas()
	{
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<TheaterDTO> list = new ArrayList<TheaterDTO>(); 
		
		String sql = "select * from theater order by id";
		
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next())
			{
				TheaterDTO dto = new TheaterDTO();
				
				dto.setId(rs.getString("id"));
				dto.setRegion(rs.getString("region"));
				dto.setName(rs.getString("name"));
				dto.setAddress(rs.getString("address"));
				
				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			db.dbClose(rs, pstmt, conn);
		}
		
		return list;
	}
	
	//영화에따른 지역에서 상영하는 극장 전체조회
	public List<HashMap<String, String>> getTheaterName(String movie_id, String region){;
		List<HashMap<String, String>> list = new ArrayList<HashMap<String,String>>();
		Connection conn = db.getConnection();
		PreparedStatement pst = null;
		ResultSet rs = null;
		String sql = "select distinct t.name as theater_name \n"
				+ "from screening s\n"
				+ "join auditorium a on s.auditorium_id = a.id\n"
				+ "join theater t on a.theater_id = t.id\n"
				+ "where t.region = ? and s.movie_id = ?";
		try {
			pst= conn.prepareStatement(sql);
			pst.setString(1, region);
			pst.setString(2, movie_id);
			rs=pst.executeQuery();

			while(rs.next()) {
				HashMap<String, String> map = new HashMap<String, String>();

				map.put("theater_name", rs.getString("theater_name"));
				list.add(map);

			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(rs, pst, conn);
		}
		return list;
	}
}
