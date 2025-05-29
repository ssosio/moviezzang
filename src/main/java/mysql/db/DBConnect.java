package mysql.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DBConnect {
	static final String URL = "jdbc:mysql://moviezzang.c72c02iwaybk.ap-northeast-2.rds.amazonaws.com:3306/moviezzang";
	static final String MySQLDriver= "com.mysql.cj.jdbc.Driver";
		
		// 생성자 안에 드라이버 넣기
		public DBConnect() 
		{
			try {
				Class.forName(MySQLDriver);
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
				System.out.println("mysql 드라이버 연결 실패: " + e.getMessage());
			}
		}

		// 오라클 계정 연결
		public Connection getConnection()
		{
			Connection conn = null;
			
			try {
				conn = DriverManager.getConnection(URL, "adminLKH", "lkh940706!");
				//System.out.println("mysql 연결 성공");
			} catch (SQLException e) {
				System.out.println("mysql 연결 실패");
				e.printStackTrace();
			}
			
			return conn;
		}
		
		// close 메소드 총 4개, 오버로딩 메소드
		public void dbClose(ResultSet rs, Statement stmt, Connection conn)
		{
			try {
				if (rs != null) rs.close();
				if (stmt != null) stmt.close();
				if (conn != null) conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		public void dbClose(Statement stmt, Connection conn)
		{
			try {
				if (stmt != null) stmt.close();
				if (conn != null) conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		public void dbClose(ResultSet rs, PreparedStatement pstmt, Connection conn)
		{
			try {
				if (rs != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (conn != null) conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		public void dbClose(PreparedStatement pstmt, Connection conn)
		{
			try {
				if (pstmt != null) pstmt.close();
				if (conn != null) conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
}
