package mboard.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import db.DBConn;

public class Member {
	
	public String getDBLogin(String id, String pass) throws SQLException {
		String unickname = "";
		DBConn db   = new DBConn();
		Connection conn = db.getConnection();
		String sql = "";
		sql  = "SELECT NICKNAME FROM MEMBERS";
		sql += " WHERE ID = ?";
		sql += " AND PASSWORD = ?";
		PreparedStatement pstmt = conn.prepareCall(sql);
		pstmt.setString(1, id);
		pstmt.setString(2, pass);

		ResultSet         rs = pstmt.executeQuery();
		
		if(rs.next()) {
			unickname = rs.getString("NICKNAME");	
		} else {
			unickname = "aaaa";
		}
		
		rs.close();
		pstmt.close();
		conn.close();
		return unickname;
	}
	/*
	 * public String getLogin(String uid, String pwd) { String result = "";
	 * if(!uid.equals("")) { if(uid.equals(pwd)) { result = "카리나"; } else { result =
	 * "정확하게 입력하세요"; } } else { result = "아이디 입력하세요"; }
	 * 
	 * return result;
	 * 
	 * }
	 */
	
}
