package mboard.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;

import db.DBConn;
import mboard.vo.MemberVo;

public class MemberDao {

	private Connection  conn = null;
	private PreparedStatement  pstmt = null;
	
	// 게시물 목록 조회
	public ArrayList<MemberVo> getMemberlist() {
		ArrayList<MemberVo> list = new ArrayList<MemberVo>();
		ResultSet rs = null;
		
		try {
			DBConn db = new DBConn();
			conn        = db.getConnection();
			String sql = "SELECT * FROM MEMBERS";
			pstmt       = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {

				String id = rs.getString("id");
				String password = rs.getString("password");
				String email = rs.getString("email");
				String nickname = rs.getString("nickname");

				MemberVo mem = new MemberVo(id, password, email, nickname);
				list.add(mem);
			}
			
		} catch (SQLException e) {

			e.printStackTrace();
		} finally {
			try {
			if(rs != null) rs.close();
			if(pstmt != null) pstmt.close();
			} catch (SQLException e) {
				
			}
		}
		return list;
		
	}
	
	
	private  CallableStatement   cstmt  = null;
	
	// 수정을 위해 메뉴 조회
		public MemberVo getMember(String in_id) {
			MemberVo    memberVo = null;
			try {
				DBConn  db = new DBConn();
				conn       = db.getConnection();
				String sql = "{CALL  PKG_COVIDBOARD.PROC_MEMBER_VIEW(?, ?, ?)}";
				cstmt      = conn.prepareCall(sql);
				
				cstmt.setString(1, in_id);
				// out parameter 등록
				cstmt.registerOutParameter(2, Types.VARCHAR);
				cstmt.registerOutParameter(3, Types.VARCHAR);
				
				cstmt.execute(); // 프로시저 실행
				
				// 결과를 돌려받는다.
				String id       = cstmt.getString(2);
				String nickname = cstmt.getString(3);
				
				memberVo = new MemberVo(id, nickname);
				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					if( cstmt != null ) cstmt.close();
					if( conn  != null ) conn.close();
				} catch (SQLException e) {
				}
			}
			
			return memberVo;
		}
	
	
	
	
}
