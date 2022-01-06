package mboard.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

import db.DBConn;
import mboard.vo.CovidInfoVo;

public class CovidInfoDao {
	public static Vector num;

	DBConn dbconn;
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	public String covidinfoInsert(CovidInfoVo covidInfoVo) {
		String result = "";
		
		dbconn	= new DBConn();
		conn	= dbconn.getConnection();
		String sql = "";
		sql = " INSERT  INTO    COVIDINFO ( ID, INFONUM, VACCINEORTEST, VACCINE, TEST_DATE, TEST_HOSPITAL,TEST_RESULT ,SYMPTOM  ) ";
		sql += " VALUES (  ?, ( SELECT NVL(MAX(INFONUM),0) +1 FROM COVIDINFO ), ? , ? , ? , ? , ? , ? ) ";
		try {
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, covidInfoVo.getId());
			pstmt.setString(2, covidInfoVo.getVaccineortest());
			pstmt.setString(3, covidInfoVo.getVaccine());
			pstmt.setString(4, covidInfoVo.getTest_date());
			pstmt.setString(5, covidInfoVo.getTest_hospital());
			pstmt.setString(6, covidInfoVo.getTest_result());
			pstmt.setString(7, covidInfoVo.getSymptom());

			pstmt.executeUpdate();

			result = "추가되었습니다";

		} catch (SQLException e) {
			switch (e.getErrorCode()) {
			case 1:
				result = "중복된 자료입니다";
				break;
			default:
				result = e.getMessage();
			}
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
			} catch (SQLException e) {
			}
		}
		
		return result;
		
	}
	
	public Vector getMemList(String id) { // public Vector getMemList(String id)
		Vector outV = new Vector(); // 2차원배열 : ResultSet 전체

		dbconn	= new DBConn();
		conn	= dbconn.getConnection();

		String sql = " SELECT  ID, INFONUM, VACCINEORTEST, VACCINE, TEST_DATE, TEST_HOSPITAL, TEST_RESULT, SYMPTOM ";
		sql += " FROM COVIDINFO ";
		sql += " WHERE ID = ? "; // id 확인용

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id); // id 확인

			rs = pstmt.executeQuery();
			num = new Vector();
			while (rs.next()) {

				Vector v = new Vector();
				num.add(rs.getString("infonum"));
				v.add(rs.getString("infonum"));
				v.add(rs.getString("id"));
				v.add(rs.getString("vaccineortest"));
				v.add(rs.getString("vaccine"));
				v.add(rs.getString("test_date"));
				v.add(rs.getString("test_hospital"));
				v.add(rs.getString("test_result"));
				v.add(rs.getString("symptom"));
				outV.add(v);

			}
			System.out.println(num);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
			} catch (SQLException e) {
			}
		}
		return outV;
	}

	public CovidInfoVo getUser(String memid, String recordno) {
		
		CovidInfoVo user = null;
		dbconn = new DBConn();
	

		String sql = " SELECT  ID, INFONUM, VACCINEORTEST, VACCINE, TEST_DATE, TEST_HOSPITAL, TEST_RESULT, SYMPTOM ";
		sql += " FROM    COVIDINFO ";
		sql += " WHERE   ID = ? ";
		sql += " AND    INFONUM = ? ";
			
		try {
			conn = dbconn.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memid);
			pstmt.setString(2, recordno);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				String id = rs.getString("ID");
				String infonum = rs.getString("INFONUM");
				String vaccineortest = rs.getString("VACCINEORTEST");
				String vaccine = rs.getString("VACCINE");
				String test_date = rs.getString("TEST_DATE");
				String jobtest_hospital = rs.getString("TEST_HOSPITAL");
				String test_result = rs.getString("TEST_RESULT");
				String symptom = rs.getString("SYMPTOM");
				user = new CovidInfoVo(id, infonum, vaccineortest,vaccine, test_date, jobtest_hospital, test_result, symptom);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
			} catch (SQLException e) {
			}
		}
		return user;
	}

	public String deleteUser(CovidInfoVo user) {
		String result = "";

		dbconn = new DBConn();

		String sql = "";

		sql = " DELETE  ";
		sql += " FROM   COVIDINFO";
		sql += " WHERE  ID = ? ";
		sql += " AND    INFONUM = ? ";

		try {
			conn = dbconn.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user.getId());
			pstmt.setString(2, user.getInfonum());

			pstmt.executeUpdate();

			result = "삭제 되었습니다";

		} catch (SQLException e) {
			switch (e.getErrorCode()) {
			default:
				result = e.getMessage();
			}
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
			} catch (SQLException e) {
			}
		}
		return result;

	}

	// 회원 수정
		public String updateUser(CovidInfoVo user) {
			String result = "";

			dbconn = new DBConn();
			conn = dbconn.getConnection();
			String sql = "";

			sql = " UPDATE    COVIDINFO ";
			sql += "  SET     VACCINEORTEST  = ?, ";
			sql += "       	  VACCINE  = ?, ";
			sql += "          TEST_DATE     = ?,";
			sql += "          TEST_HOSPITAL   = ?,";
			sql += "          TEST_RESULT   = ?,";
			sql += "          SYMPTOM       = ?";
			sql += "  WHERE   ID  = ? ";
			sql += " AND    INFONUM = ? ";

			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, user.getVaccineortest());
				pstmt.setString(2, user.getVaccine());
				pstmt.setString(3, user.getTest_date());
				pstmt.setString(4, user.getTest_hospital());
				pstmt.setString(5, user.getTest_result());
				pstmt.setString(6, user.getSymptom());
				pstmt.setString(7, user.getId());
				pstmt.setString(8, user.getInfonum());

				pstmt.executeUpdate();

				result = "수정 되었습니다";

			} catch (SQLException e) {
				switch (e.getErrorCode()) {
				default:
					result = e.getMessage();
				}
			} finally {
				try {
					if (pstmt != null)
						pstmt.close();
				} catch (SQLException e) {
				}
			}
			return result;

		}
		// 회원 삭제
	

}
