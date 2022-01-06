package mboard.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import mboard.vo.Chat;

public class ChatDAO {
	private Connection conn;
	private   String      driver = "oracle.jdbc.OracleDriver";
	private   String      dburl  = "jdbc:oracle:thin:@localhost:1521:xe";
	private   String      dbuid  = "prj2";
	private   String      dbpwd  = "1234";
	public ChatDAO() {
		try {
			Class.forName(driver);
			conn  = DriverManager.getConnection(dburl, dbuid, dbpwd);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
//	시간에 따라 챗가져오기
	/*
	public ArrayList<Chat> getChatList(String nowTime){
		ArrayList<Chat> chatList = null;
		PreparedStatement pstmt	=null;
		ResultSet rs = null;
		String SQL = " SELECT CHATNAME,CHATCONTENT,CHATTIME ";
		SQL		  += " FROM CHAT WHERE CHATTIME > TO_DATE( ? ) ORDER BY CHATTIME ";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, nowTime);
			rs= pstmt.executeQuery();
			chatList = new ArrayList<Chat>();
			while(rs.next()) {
				Chat chat = new Chat();
				chat.setChatID(rs.getInt("chatID"));
				chat.setChatName(rs.getString("chatname"));
				chat.setChatContent(rs.getString("chatcontent").replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">" ,"&gt;").replaceAll("\n", "<br>"));
				int chatTime = Integer.parseInt(rs.getString("chatTime").substring(11, 13));
				String timeType = "오전";
				if(Integer.parseInt(rs.getString("chatTime").substring(11, 13)) >= 12 ) {
					timeType = "오후";
					chatTime -= 12;
				}
				chat.setChatTime(rs.getString("chatTime").substring(0, 11) + " " + timeType + " " + chatTime + ":" + rs.getString("chatTime").substring(14, 16) + "");
				chatList.add(chat);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs!=null) rs.close();
				if(pstmt != null) pstmt.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return chatList;
	}
	*/
	
	//챗 가져오기
	/*
	public ArrayList<Chat> getChatListByRecent(int number){
		ArrayList<Chat> chatList = null;
		PreparedStatement pstmt	=null;
		ResultSet rs = null;
		String SQL = " SELECT * FROM CHAT  ";
		SQL		  += " WHERE CHATID > (SELECT MAX(CHATID) - ? FROM CHAT)  ";
		SQL		  += " ORDER BY CHATTIME ";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, number);
			rs= pstmt.executeQuery();
			chatList = new ArrayList<Chat>();
			while(rs.next()) {
				Chat chat = new Chat();
				chat.setChatID(rs.getInt("chatID"));
				chat.setChatName(rs.getString("chatname"));
				chat.setChatContent(rs.getString("chatcontent").replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">" ,"&gt;").replaceAll("\n", "<br>"));
				int chatTime = Integer.parseInt(rs.getString("chatTime").substring(11, 13));
				String timeType = "오전";
				if(Integer.parseInt(rs.getString("chatTime").substring(11, 13)) >= 12 ) {
					timeType = "오후";
					chatTime -= 12;
				}
				chat.setChatTime(rs.getString("chatTime").substring(0, 11) + " " + timeType + " " + chatTime + ":" + rs.getString("chatTime").substring(14, 16) + "");
				chatList.add(chat);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs!=null) rs.close();
				if(pstmt != null) pstmt.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return chatList;
	}
	*/
	// 챗 가져오기
	public ArrayList<Chat> getChatListByRecent(String chatNUM){
		ArrayList<Chat> chatList = null;
		PreparedStatement pstmt	=null;
		ResultSet rs = null;
		String SQL = " SELECT * FROM CHAT  ";
		SQL		  += " WHERE CHATNUM > ? ";
		SQL		  += " ORDER BY CHATTIME";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, Integer.parseInt(chatNUM));
			rs= pstmt.executeQuery();
			chatList = new ArrayList<Chat>();
			while(rs.next()) {
				Chat chat = new Chat();
				chat.setChatID(rs.getInt("chatNum"));
				chat.setChatName(rs.getString("chatname"));
				chat.setChatContent(rs.getString("chatcontent").replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">" ,"&gt;").replaceAll("\n", "<br>"));
				int chatTime = Integer.parseInt(rs.getString("chatTime").substring(11, 13));
				String timeType = "오전";
				if(Integer.parseInt(rs.getString("chatTime").substring(11, 13)) >= 12 ) {
					timeType = "오후";
					chatTime -= 12;
				}
				chat.setChatTime(rs.getString("chatTime").substring(0, 11) + " " + timeType + " " + chatTime + ":" + rs.getString("chatTime").substring(14, 16) + "");
				chatList.add(chat);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs!=null) rs.close();
				if(pstmt != null) pstmt.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return chatList;
	}
	// 챗 db저장
	public int submit(String chatName, String chatContent, String chatIp) {
		PreparedStatement pstmt	=null;
		ResultSet rs = null;
		System.out.println("chatDao Name :" + chatName);
		System.out.println("chatDao Content :"  + chatContent) ;
		System.out.println("chatDao Ip :" + chatIp);
		String SQL = " INSERT INTO CHAT ( CHATNUM, CHATNAME, CHATCONTENT, CHATTIME, IP ) ";
		SQL		+= " VALUES ((SELECT NVL(MAX(CHATNUM),0)+1 FROM CHAT), ? , ? , SYSDATE, ?) ";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, chatName);
			pstmt.setString(2, chatContent);
			pstmt.setString(3, chatIp);
			return pstmt.executeUpdate();		
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs!=null) rs.close();
				if(pstmt != null) pstmt.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return -1;
		
	}
}
