package data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import mysql.db.DBConnect;

public class ReservationDAO {
	DBConnect db = new DBConnect();

	private static ReservationDAO dao = new ReservationDAO();

	private ReservationDAO() {
	}
	public static ReservationDAO getInstance() {

		return dao;
	}

	//Reservation테이블 insert 여기서 auto_increment된 id값을 바로 return함.
	public int insertReserve(String screening_Id, String userNum){
		Connection conn = db.getConnection();
		PreparedStatement pst = null;
		ResultSet rs = null;
		int generatedId = -1;

		String sql ="insert into reservation (screening_id, user_id, reserved_at) values (?, ?, now())";

		try {
			pst = conn.prepareStatement(sql,PreparedStatement.RETURN_GENERATED_KEYS);
			pst.setString(1, screening_Id);
			pst.setString(2, userNum);
			pst.executeUpdate();

			//생성 키 받기
			rs = pst.getGeneratedKeys();
			System.out.println("rs: " + rs);
			if(rs.next()) {
				generatedId = rs.getInt(1); //1번째컬럼
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(pst, conn);
		}
		return generatedId; // insert 한 후 생성된 reservation_id 반환
	};

	//seat_reserved테이블 insert
	public void insertSeatReserve(int reservationId, String seat_id) {
		Connection conn = db.getConnection();
		PreparedStatement pst = null;
		String sql = "insert into seat_reserved values(null,?,?)";

		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, reservationId);
			pst.setString(2, seat_id);
			pst.execute();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(pst, conn);
		}
	};


}
