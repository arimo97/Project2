package mboard.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import db.DBConn;
import mboard.vo.CommentVo;
import oracle.jdbc.OracleCallableStatement;

public class CommentDao {

	private   Connection         conn   = null;
	private   CallableStatement  cstmt  = null;
	private   PreparedStatement  pstmt  = null;
	
	// 전체 댓글 조회
	public List<CommentVo> getCommentAllList() {
		
		ResultSet     rs            = null;
		List<CommentVo> commentAllList = new ArrayList<CommentVo>();
		
		try {
			DBConn   db  =  new DBConn();
			conn         =  db.getConnection();
			String   sql =  "{CALL  PKG_COVIDCOMMENT.PROC_COMMENT_ALL_LIST(?)}";
			cstmt        =  conn.prepareCall(sql);
			
			cstmt.registerOutParameter(1, 
					oracle.jdbc.OracleTypes.CURSOR	);	// ojdcb 6.jar
			
			cstmt.execute();
			
			OracleCallableStatement ocstmt = (OracleCallableStatement) cstmt;
			rs   =   ocstmt.getCursor(1);  // 1번째 파라미터
			
			System.out.println("CommentDao while 시작 all");
			while(rs.next()) {
				
				int       cnum      =  rs.getInt("cnum");
				int       bnum      =  rs.getInt("bnum");
				String    ctext     =  rs.getString("ctext");
				String    id        =  rs.getString("id");
				String    cregdate  =  rs.getString("cregdate");
				String    cupdate   =  rs.getString("cupdate");
				String    cdelete   =  rs.getString("cdelete");
				String    nickname   =  rs.getString("nickname");
				CommentVo   allcomment     =  new CommentVo( 
						cnum, bnum, ctext, id, cregdate, cupdate, cdelete, nickname);
				commentAllList.add( allcomment ); 
				
				System.out.println("CommentDao allcomment : "+ allcomment);
			}
			System.out.println("CommentDao while 끝 all");
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs    != null) rs.close();
				if(cstmt != null) cstmt.close();
				if(conn  != null) conn.close();
			} catch (SQLException e) {			
			}
		}

		return    commentAllList;
	}
	
	
	
	// 해당 개시글 댓글 목록
	public List<CommentVo> getCommentList(int in_bnum) {
		
		ResultSet     rs            = null;
		List<CommentVo> commentList = new ArrayList<CommentVo>();
		
		try {
			DBConn   db  =  new DBConn();
			conn         =  db.getConnection();
			String   sql =  "{CALL  PKG_COVIDCOMMENT.PROC_COMMENT_LIST(?,?)}";
			cstmt        =  conn.prepareCall(sql);
			
			cstmt.setInt(1, in_bnum);
			cstmt.registerOutParameter(2, 
					oracle.jdbc.OracleTypes.CURSOR	);	// ojdcb 6.jar
			
			cstmt.execute();
			
			OracleCallableStatement ocstmt = (OracleCallableStatement) cstmt;
			rs   =   ocstmt.getCursor(2);  // 1번째 파라미터
			
			System.out.println("CommentDao while 시작");
			while(rs.next()) {
				
				int       cnum      =  rs.getInt("cnum");
				int       bnum      =  rs.getInt("bnum");
				String    ctext     =  rs.getString("ctext");
				String    id        =  rs.getString("id");
				String    cregdate  =  rs.getString("cregdate");
				String    cupdate   =  rs.getString("cupdate");
				String    cdelete   =  rs.getString("cdelete");
				String    nickname   =  rs.getString("nickname");
				CommentVo   comment     =  new CommentVo( 
						cnum, bnum, ctext, id, cregdate, cupdate, cdelete, nickname);
				commentList.add( comment ); 
				
				System.out.println("CommentDao comment : "+comment);
			}
			System.out.println("CommentDao while 끝");
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs    != null) rs.close();
				if(cstmt != null) cstmt.close();
				if(conn  != null) conn.close();
			} catch (SQLException e) {			
			}
		}
		System.out.println("CommentDao commentList : "+commentList);
		return    commentList;
	}

	// 댓글 추가
	public void commentInsert(CommentVo commentVo) {
		
		try {
			DBConn   db        =   new DBConn();
			conn               =   db.getConnection();
			String   sql       =   "{ CALL PKG_COVIDCOMMENT.PROC_COMMENT_INSERT( ?,?,?,? ) }";
			cstmt              =   conn.prepareCall(sql);
			
			int      bnum      =   commentVo.getBnum();
			String   ctext     =   commentVo.getCtext();
			String   id        =   commentVo.getId();
			String   nickname  =   commentVo.getNickname();
						
			cstmt.setInt(1, bnum );
			cstmt.setString(2, ctext );
			cstmt.setString(3, id );
			cstmt.setString(4, nickname );
			
			cstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(cstmt != null) cstmt.close();
				if(conn  != null) conn.close();
			} catch (SQLException e) {			
			}
		}
		
	}


// 댓글 수정을 위한 cnum으로 댓글 조회
	public CommentVo getComment(int cnum) {
		CommentVo     commentVo = null;
		ResultSet     rs        = null;
		
		try {
			DBConn   db        =   new DBConn();
			conn               =   db.getConnection();
			String   sql       =   "{ CALL PKG_COVIDCOMMENT.PROC_COMMENT_GET( ?,? ) }";
			cstmt              =   conn.prepareCall(sql);
			
			cstmt.setInt(1, cnum);
			cstmt.registerOutParameter(2, 
				  oracle.jdbc.OracleTypes.CURSOR);
			
			cstmt.execute();
			
			OracleCallableStatement ocstmt = (OracleCallableStatement) cstmt;
			
			rs = ocstmt.getCursor(2);
			
			if(rs.next()) {
								
				int       bnum      =  rs.getInt("bnum");
				String    ctext     =  rs.getString("ctext");
				String    id        =  rs.getString("id");
				String    cregdate  =  rs.getString("cregdate");
				String    cupdate   =  rs.getString("cupdate");
				String    cdelete   =  rs.getString("cdelete");
				String    nickname  =  rs.getString("nickname");
				
				commentVo = new CommentVo( cnum, bnum, ctext, id, 
						cregdate, cupdate, cdelete, nickname);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs    != null) rs.close();
				if(cstmt != null) cstmt.close();
				if(conn  != null) conn.close();
			} catch (SQLException e) {			
			}
		}
		return commentVo;
		
	}

//	//-------------여기서부터-------------------------------------
//	
//	
//	// 게시글 삭제
//	public void boardDelete(String in_bnum) {
//		
//		try {
//			DBConn  db  =  new DBConn();
//			conn        =  db.getConnection();
//			String  sql =  "{CALL PKG_COVIDCOMMENT.PROC_COMMENT_DELETE(?)}";
//			cstmt       =  conn.prepareCall(sql);
//			int    bnum =  Integer.parseInt(in_bnum);
//			cstmt.setInt(1, bnum);
//			
//			cstmt.execute();
//			
//		} catch (SQLException e) {
//			e.printStackTrace();
//		} finally {
//			try {
//				if(cstmt != null) cstmt.close();
//				if(conn  != null) conn.close();
//			} catch (SQLException e) {			
//			}
//		}
//		
//	}
//
	// 게시글 수정
	public void commentUpdate(CommentVo commentVo) {
		
		try {
			DBConn db  = new DBConn();
			conn       = db.getConnection();
			String sql = "{CALL PKG_COVIDCOMMENT.PROC_COMMENT_UPDATE(?, ?)}";
			cstmt      = conn.prepareCall(sql);
			
			cstmt.setString(1, commentVo.getCtext());
			cstmt.setInt(2, commentVo.getCnum());
			
			cstmt.execute();
			
		} catch(SQLException e) {
			
		} finally {
			try {
				if(cstmt != null) cstmt.close();
				if(conn  != null) conn.close();
			} catch (SQLException e) {			
			}
		}
		
	}

// 댓글 삭제

	public void commentDelete(int cnum) {
		try {
			DBConn  db  =  new DBConn();
			conn        =  db.getConnection();
			String  sql =  "{CALL PKG_COVIDCOMMENT.PROC_COMMENT_DELETE(?)}";
			cstmt       =  conn.prepareCall(sql);
			cstmt.setInt(1, cnum);
			
			cstmt.execute();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(cstmt != null) cstmt.close();
				if(conn  != null) conn.close();
			} catch (SQLException e) {			
			}
		}
	}

	// 댓글수
	
	public int getCommentCount(int bnum) {
		int commentcount = 0;
		try {
			DBConn  db  =  new DBConn();
			conn        =  db.getConnection();
			String  sql =  "SELECT COUNT(*)";
			sql		   += "    FROM COVIDCOMMENT";
			sql		   += "    WHERE BNUM = ?";
			pstmt       =  conn.prepareStatement(sql);
			pstmt.setInt(1, bnum);
			
			ResultSet rs = null;
			rs = pstmt.executeQuery();
			if (rs.next()) {
				commentcount = rs.getInt(1);
				//rs.getInt("commentcount");
				System.out.println("이 게시판의 댓글수 : " + commentcount);
			}
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(cstmt != null) cstmt.close();
				if(conn  != null) conn.close();
			} catch (SQLException e) {			
			}
		}
		return commentcount;
		
	}
	
	
}