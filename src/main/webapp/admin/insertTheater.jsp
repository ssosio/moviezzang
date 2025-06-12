<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="mysql.db.DBConnect"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String region = request.getParameter("region");
	String name = request.getParameter("name");
	String address = request.getParameter("address");
	int auditoriums = Integer.parseInt(request.getParameter("auditoriums"));
	
	// 나중에 각 DAO로 분리하자
	DBConnect db = new DBConnect();
	Connection conn = db.getConnection();
	conn.setAutoCommit(false); // 트랜잭션 시작
	
	try {
	    int theaterId = 0;
	    // 극장 데이터 추가
	    String sql1 = "INSERT INTO theater(region, name, address) VALUES (?, ?, ?)";
	    															// auto_increment로 증가한 pk를 바로 반환
	    PreparedStatement pstmt1 = conn.prepareStatement(sql1, Statement.RETURN_GENERATED_KEYS);
	    pstmt1.setString(1, region);
	    pstmt1.setString(2, name);
	    pstmt1.setString(3, address);
	    pstmt1.executeUpdate();
	    ResultSet rs = pstmt1.getGeneratedKeys();
	    
	    if(rs.next())
	    {
	    	theaterId = rs.getInt(1); 	
	    }
	
	    rs.close();
	    pstmt1.close();
	    
	    String sql2 = "INSERT INTO auditorium(theater_id, name) VALUES (?, ?)"; 
	    String sql3 = "INSERT INTO seat(auditorium_id, seat_row, seat_col, seat_no) VALUES (?, ?, ?, ?)";
	    
        PreparedStatement pstmt2 = conn.prepareStatement(sql2, Statement.RETURN_GENERATED_KEYS);
        PreparedStatement pstmt3 = conn.prepareStatement(sql3);
	    
	    
	    // 상영관을 전달받은 갯수만큼 추가하고, 그만큼 좌석 테이블의 데이터도 추가
	    for(int i=1; i<=auditoriums; i++) 
	    {
	        // auditorium name: 1관, 2관, ... 이런식으로
	        String auditoriumName = i + "관";
	        
	        pstmt2.setInt(1, theaterId);
	        pstmt2.setString(2, auditoriumName);
	        pstmt2.executeUpdate();
	        
	        ResultSet rs2 = pstmt2.getGeneratedKeys();        
	        int auditoriumId = 0;
	        
	        if(rs2.next()) 
	        {
	        	auditoriumId = rs2.getInt(1);
	        }
	     
	        rs2.close();
	        
	        // 좌석 추가하는 부분
	        for(char row='A'; row<='N'; row++) 
	        { // A~N
	            for(int col=1; col<=14; col++) 
	            {
	                String seatNo = row + String.valueOf(col);
	                
	                pstmt3.setInt(1, auditoriumId);
	                pstmt3.setString(2, String.valueOf(row));
	                pstmt3.setInt(3, col);
	                pstmt3.setString(4, seatNo);
	                pstmt3.addBatch(); // 매번 execute하지말고 합쳐놓았다가 executeBatch()로 쿼리 한번에 실행
	            }
	        }       
	        pstmt3.executeBatch();
	    }
	
        pstmt2.close();
        pstmt3.close();
	    
	    conn.commit();
	    // 성공 응답
	} catch(Exception e) {
	    conn.rollback(); // 에러 발생시 전체 롤백
	    // 실패 응답
	} finally {
	    conn.setAutoCommit(true);
	}	
%>