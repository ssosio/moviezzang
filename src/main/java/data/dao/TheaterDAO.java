package data.dao;

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
}
