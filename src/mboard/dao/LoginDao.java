package mboard.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import db.DBConn;
import mboard.vo.MemViewVo;

public class LoginDao {

	private static String sido;
	private static String sigungu;
	private static String id1;
	public int result = 0;
	
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	public int loginProc(String id, String pw){
		try {
			DBConn   db  =  new  DBConn();
			conn         =  db.getConnection();
			String sql = "SELECT * "
					  + " FROM MEMBERS"
					  + " WHERE ID = ? AND PASSWD = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				sido = rs.getString("SIDO");
				sigungu = rs.getString("SIGUNGU");
				id1 = rs.getString("id");
				result = 1;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

	public static String getSido() {
		return sido;
	}
	
	public static String getId() {
		return id1;
	}

	public static String getSigungu() {
		return sigungu;
	}
	
}
