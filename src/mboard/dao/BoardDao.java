package mboard.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import db.DBConn;
import mboard.vo.BoardVo;
import oracle.jdbc.OracleCallableStatement;

public class BoardDao {
	
	private   Connection         conn   = null;
	private   CallableStatement  cstmt  = null;
	private   PreparedStatement  pstmt  = null;
	BoardVo    boardVo  =  null;
	ResultSet  rs       =  null;
	
	// 전체 목록
	public List<BoardVo> getBoardList() {
		
		ResultSet     rs        = null;
		List<BoardVo> boardList = new ArrayList<BoardVo>();
		
		try {
			DBConn   db  =  new DBConn();
			conn         =  db.getConnection();
			String   sql =  "{CALL  PKG_COVIDBOARD.PROC_BOARD_LIST(?)}";
			cstmt        =  conn.prepareCall(sql);
			
			cstmt.registerOutParameter(1, 
					oracle.jdbc.OracleTypes.CURSOR	);	// ojdcb 6.jar
			
			cstmt.execute();
			
			OracleCallableStatement ocstmt = (OracleCallableStatement) cstmt;
			rs   =   ocstmt.getCursor(1);  // 1번째 파라미터
			
			while(rs.next()) {
				
				int       bnum      =  rs.getInt("bnum");
				String    btitle    =  rs.getString("btitle");
				String    btext     =  rs.getString("btext");
				String    id        =  rs.getString("id");
				int       readcount =  rs.getInt("readcount");
				String    bregdate  =  rs.getString("bregdate");
				String    bupdate   =  rs.getString("bupdate");
				String    nickname   =  rs.getString("nickname");
				String    bdelete   =  rs.getString("bdelete");
				BoardVo   board     =  new BoardVo( 
						bnum, btitle, btext, id, readcount, bregdate, bupdate, nickname, bdelete);
				
				boardList.add( board ); 
				
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

		return    boardList;
	}

	// 페이징 추가 리스트
	public ArrayList getBoardList(int startRow, int pageSize){
		//가변길이 배열 생성
		ArrayList boardList = new ArrayList(); 

		try {
			//1. 디비연결
			DBConn   db  =  new DBConn();
			conn         =  db.getConnection();
			//2. sql작성, pstmt
			//게시판의 데이터 목록중에서 10개씩 정렬해서 가져오기
			//re_ref(그룹번호) 내림차순 + re_seq(답글순서결정)오름차순으로 정렬
			//데이터 짤라서 가져오기 limit 시작행-1, 페이지갯수 => 해당 위치부터 개수만큼 가져오기
			String sql = "select * from COVIDBOARD order by re_ref desc, re_seq asc"
					+"limit ?,?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow-1);
			pstmt.setInt(2, pageSize);
			//3. 실행 -> rs저장
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				int       bnum      =  rs.getInt("bnum");
				String    btitle    =  rs.getString("btitle");
				String    btext     =  rs.getString("btext");
				String    id        =  rs.getString("id");
				int       readcount =  rs.getInt("readcount");
				String    bregdate  =  rs.getString("bregdate");
				String    bupdate   =  rs.getString("bupdate");
				String    nickname   =  rs.getString("nickname");
				String    bdelete   =  rs.getString("bdelete");
				BoardVo   board     =  new BoardVo( 
						bnum, btitle, btext, id, readcount, bregdate, bupdate, nickname, bdelete);
				
				boardList.add( board ); //업캐스팅
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}  finally {
			try {
				if(rs    != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn  != null) conn.close();
			} catch (SQLException e) {			
			}
		}
		return boardList;
		
	}
	
	
	// 추천 글 위로 올리기
	
	public List<BoardVo> getBoardUpList() {
			
			ResultSet     rs        = null;
			List<BoardVo> boardupList = new ArrayList<BoardVo>();
			
			try {
				DBConn   db  =  new DBConn();
				conn         =  db.getConnection();
				String   sql =  "{CALL  PKG_COVIDBOARD.PROC_BOARDUP_LIST(?)}";
				cstmt        =  conn.prepareCall(sql);
				
				cstmt.registerOutParameter(1, 
						oracle.jdbc.OracleTypes.CURSOR	);	// ojdcb 6.jar
				
				cstmt.execute();
				
				OracleCallableStatement ocstmt = (OracleCallableStatement) cstmt;
				rs   =   ocstmt.getCursor(1);  // 1번째 파라미터
				
				while(rs.next()) {
					
					int       bnum      =  rs.getInt("bnum");
					String    btitle    =  rs.getString("btitle");
					String    btext     =  rs.getString("btext");
					String    id        =  rs.getString("id");
					int       readcount =  rs.getInt("readcount");
					String    bregdate  =  rs.getString("bregdate");
					String    bupdate   =  rs.getString("bupdate");
					String    nickname   =  rs.getString("nickname");
					String    bdelete   =  rs.getString("bdelete");
					BoardVo   board     =  new BoardVo( 
							bnum, btitle, btext, id, readcount, bregdate, bupdate, nickname, bdelete);
					
					boardupList.add( board ); 
					
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

			return    boardupList;
		}
	
	
	// 게시글 추가
	public void boardInsert(BoardVo boardVo) {
		
		try {
			DBConn   db        =   new DBConn();
			conn               =   db.getConnection();
			String   sql       =   "{ CALL PKG_COVIDBOARD.PROC_BOARD_INSERT( ?,?,?,? ) }";
			cstmt              =   conn.prepareCall(sql);
			
			String   id        =   boardVo.getId();
			String   btitle    =   boardVo.getBtitle();
			String   btext     =   boardVo.getBtext();
			String   nickname  =   boardVo.getNickname();
						
			cstmt.setString(1, id );
			cstmt.setString(2, btitle );
			cstmt.setString(3, btext );
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

	// 게시글 보기
	public BoardVo getBoard(int bnum) {
		try {
			DBConn  db  = new  DBConn();
			conn        = db.getConnection();
			String  sql = "{CALL  PKG_COVIDBOARD.PROC_BOARD_VIEW(?, ?) }"; 
			cstmt       = conn.prepareCall(sql);
			
			cstmt.setInt(1, bnum);
			cstmt.registerOutParameter(2, 
				  oracle.jdbc.OracleTypes.CURSOR);
			
			cstmt.execute();
			
			OracleCallableStatement ocstmt = (OracleCallableStatement) cstmt;
			
			rs = ocstmt.getCursor(2);
			
			if(rs.next()) {
				// int       bnum      =  rs.getInt("bnum");
				String    btitle    =  rs.getString("btitle");
				String    btext     =  rs.getString("btext");
				String    id        =  rs.getString("id");
				int       readcount =  rs.getInt("readcount");
				String    bregdate  =  rs.getString("bregdate");
				String    bupdate   =  rs.getString("bupdate");
				String    nickname   =  rs.getString("nickname");
				String    bdelete   =  rs.getString("bdelete");
				
				boardVo = new BoardVo( bnum, btitle, btext, id, 
						readcount, bregdate, bupdate, nickname, bdelete);
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
		
		return  boardVo;
	}

	
	
	//-------------여기서부터-------------------------------------
	
	
	// 게시글 삭제
	public void boardDelete(String in_bnum) {
		
		try {
			DBConn  db  =  new DBConn();
			conn        =  db.getConnection();
			String  sql =  "{CALL PKG_COVIDBOARD.PROC_BOARD_DELETE(?)}";
			cstmt       =  conn.prepareCall(sql);
			int    bnum =  Integer.parseInt(in_bnum);
			cstmt.setInt(1, bnum);
			
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

	// 게시글 수정
	public void boardUpdate(BoardVo boardVo) {
		
		try {
			DBConn db  = new DBConn();
			conn       = db.getConnection();
			String sql = "{CALL PKG_COVIDBOARD.PROC_BOARD_UPDATE(?, ?, ?, ?)}";
			cstmt      = conn.prepareCall(sql);
			
			cstmt.setString(1, boardVo.getBtitle());
			cstmt.setString(2, boardVo.getBtext());
			cstmt.setInt(3, boardVo.getBnum());
			cstmt.setString(4, boardVo.getId());
			
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
	
}
