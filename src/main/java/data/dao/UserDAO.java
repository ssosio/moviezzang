package data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import data.dto.UserDTO;
import mysql.db.DBConnect;

public class UserDAO {
	
	
	DBConnect db=new DBConnect();
	
	public void insertMember(UserDTO dto) {
		
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		
		String sql="insert into user values(null,?,?,?,?,?,?,,null,null,now())";
		
		
	}
	

}
