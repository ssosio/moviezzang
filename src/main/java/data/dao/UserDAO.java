package data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

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
	

}
