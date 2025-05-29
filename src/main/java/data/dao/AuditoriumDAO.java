package data.dao;

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
	
}
