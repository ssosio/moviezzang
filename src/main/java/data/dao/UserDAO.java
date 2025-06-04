package data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;


import data.dto.UserDTO;
import mysql.db.DBConnect;

public class UserDAO {
	
	
	DBConnect db=new DBConnect();
	
	public static UserDAO dao=new UserDAO();
	
	private UserDAO() {
		
	}
	
	public static UserDAO getInstance() {
		return dao;
	}
	
	public void insertMember(UserDTO dto) {
		
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		
		String sql="insert into user(userid,password,name,gender,age,phone,address,email,birth,signup_at) values(?,?,?,?,?,?,?,?,?,now())";
		
		try {
			pstmt=conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getUserid());
			pstmt.setString(2, dto.getPassword());
			pstmt.setString(3, dto.getName());
			pstmt.setString(4, dto.getGender());
			pstmt.setInt(5, dto.getAge());
			pstmt.setString(6, dto.getPhone());
			pstmt.setString(7, dto.getAddress());
			pstmt.setString(8, dto.getEmail());
			pstmt.setString(9, dto.getBirth());
			
			
			pstmt.execute();
			
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(pstmt, conn);
		}
		
	}
	
	public int idCheck(String userid) {
		
		int f=0;
		
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		String sql="select count(*) from user where userid=?";
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			rs=pstmt.executeQuery();
			
			if(rs.next())
			{
				f=rs.getInt(1);
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(rs, pstmt, conn);
			
		}
		return f;
		
	}
	
	//update
	public void updateMember(UserDTO dto)
	{
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		
		String sql="update user set password=?, name=?, gender=?, age=?, phone=?, address=?, email=?, birth=? where id=?";
		
		try {
			pstmt=conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getPassword());
			pstmt.setString(2, dto.getName());
			pstmt.setString(3, dto.getGender());
			pstmt.setInt(4, dto.getAge());
			pstmt.setString(5, dto.getPhone());
			pstmt.setString(6, dto.getAddress());
			pstmt.setString(7, dto.getEmail());
			pstmt.setString(8, dto.getBirth());
			pstmt.setString(9, dto.getId());
			
			pstmt.execute();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(pstmt, conn);
		}
		
		
	}
	
	//예매내역 리스트
	public List<HashMap<String, String>> getReserveList(String userid)
	{
		String sql="SELECT \r\n"
				+ "    res.id, \r\n"
				+ "    res.reserved_at, \r\n"
				+ "    m.title, \r\n"
				+ "    t.name, \r\n"
				+ "    s.start_time, \r\n"
				+ "    s.price\r\n"
				+ "FROM \r\n"
				+ "    reservation res\r\n"
				+ "JOIN screening s ON res.screening_id = s.id\r\n"
				+ "JOIN movie m ON s.movie_id = m.id\r\n"
				+ "JOIN auditorium a ON s.auditorium_id = a.id\r\n"
				+ "JOIN theater t ON a.theater_id = t.id\r\n"
				+ "JOIN user u ON res.user_id = u.id\r\n"
				+ "WHERE u.userid = ?";
		List<HashMap<String, String>> list=new ArrayList<HashMap<String,String>>();
		
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			
			rs=pstmt.executeQuery();
			
			while(rs.next())
			{
				HashMap<String, String> map=new HashMap<String, String>();
				map.put("id", rs.getString("id"));
				map.put("reserved_at", rs.getString("reserved_at"));
				map.put("title", rs.getString("title"));
				map.put("name", rs.getString("name"));
				map.put("start_time", rs.getString("start_time"));
				map.put("price", rs.getString("price"));
				
				list.add(map);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(rs, pstmt, conn);
			
		}
		
		return list;
	}
	
	//user시퀀스에 따른 dto
	public UserDTO getData(String id)
	{
		UserDTO dto=new UserDTO();
		
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		String sql="select * from user where id="+id;
		
		try {
			pstmt=conn.prepareStatement(sql);
			
			rs=pstmt.executeQuery();
			
			while(rs.next())
			{
				dto.setId(rs.getString("id"));
				dto.setUserid(rs.getString("userid"));
				dto.setPassword(rs.getString("password"));
				dto.setName(rs.getString("name"));
				dto.setGender(rs.getString("gender"));
				dto.setAge(rs.getInt("age"));
				dto.setPhone(rs.getString("phone"));
				dto.setAddress(rs.getString("address"));
				dto.setMileage(rs.getInt("mileage"));
				dto.setUser_type(rs.getString("user_type"));
				dto.setSignup_at(rs.getTimestamp("signup_at"));
				dto.setEmail(rs.getString("email"));
				dto.setBirth(rs.getString("birth"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(rs, pstmt, conn);
		}
		
		
		return dto;
	}
	
	//user 삭제
	public void deleteMember(String id)
	{
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		
		String sql="delete from user where id="+id;
		
		try {
			pstmt=conn.prepareStatement(sql);
			
			pstmt.execute();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(pstmt, conn);
		}
		
	}
	
	//비밀번호체크
	public boolean EqualPass(String id,String password)
	{
		boolean b=false;
		
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		String sql="select * from user where id=? and password=?";
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, password);
			rs=pstmt.executeQuery();
			
			if(rs.next())
				b=true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(rs, pstmt, conn);
		}
		
		return b;
	}
	
	//아이디,비밀번호 체크
	public boolean userIdCheck(String userid,String password)
	{
		boolean b=false;
		
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		String sql="select * from user where userid=? and password=?";
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			pstmt.setString(2, password);
			rs=pstmt.executeQuery();
			
			if(rs.next())
				b=true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(rs, pstmt, conn);
		}
		
		return b;
	}
	
	//전체user List
	public List<UserDTO> getAllMembers()
	{
		List<UserDTO> list=new ArrayList<UserDTO>();
		
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		String sql="select * from user order by userid";
		
		try {
			pstmt=conn.prepareStatement(sql);
			
			rs=pstmt.executeQuery();
			
			while(rs.next())
			{
				UserDTO dto=new UserDTO();
				dto.setId(rs.getString("id"));
				dto.setName(rs.getString("name"));
				dto.setUserid(rs.getString("userid"));
				dto.setPassword(rs.getString("password"));
				dto.setAge(rs.getInt("age"));
				dto.setAddress(rs.getString("address"));
				dto.setGender(rs.getString("gender"));
				dto.setEmail(rs.getString("email"));
				dto.setMileage(rs.getInt("mileage"));
				dto.setPhone(rs.getString("phone"));
				dto.setUser_type(rs.getString("user_type"));
				dto.setSignup_at(rs.getTimestamp("signup_at"));
				dto.setBirth(rs.getString("birth"));
				
				list.add(dto);
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(rs, pstmt, conn);
		}
		
		
		return list;
	}
	
	
	
}
