package mboard.dao;

import java.io.IOException;
import java.io.StringReader;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Vector;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

import db.DBConn;

public class CovidStatusDao {

	   public void insertPeriodData(StringBuilder sb) throws SAXException, IOException, ParserConfigurationException, ParseException{
		   PreparedStatement pstmt = null;
		   Connection conn = null;
		try {
			
			DBConn dbconn = new DBConn();
			conn = dbconn.getConnection();
			
			DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
			DocumentBuilder db = dbf.newDocumentBuilder();
			Document doc = db.parse(new InputSource(new StringReader(sb.toString())));
			doc.getDocumentElement().normalize();

			NodeList itemList = doc.getElementsByTagName("item");
			
			Vector outV = new Vector();
			
			for (int i = 0; i < itemList.getLength(); i++) {
			Node itemNode = itemList.item(i);
			Element itemEle = (Element) itemNode;
			
			String sql = " INSERT INTO COVIDSTATUS "
					+ "	VALUES((SELECT NVL(MAX(STATUSNUM), 0) + 1 FROM COVIDSTATUS), ?, ?, ?, ?, ?, ?, ?, ?) ";
			/*
			 * String sql = "INSERT INTO COUNTRYCOVIDSTATUS" +
			 * "	VALUES((SELECT NVL(MAX(COUNTRYNUM), 0) + 1 FROM COUNTRYCOVIDSTATUS), ?, ?, ?, ?, ?, ?)"
			 * ;
			 */
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, getValue(itemEle, "gubun")); 
			pstmt.setInt(2, Integer.parseInt(getValue(itemEle, "defCnt"))); 
			pstmt.setInt(3, Integer.parseInt(getValue(itemEle, "deathCnt"))); 
			pstmt.setInt(4, Integer.parseInt(getValue(itemEle, "incDec"))); 
			pstmt.setInt(5, Integer.parseInt(getValue(itemEle, "localOccCnt"))); 
			pstmt.setInt(6, Integer.parseInt(getValue(itemEle, "isolClearCnt")));
			String qurrate = "";
			try {
				qurrate = getValue(itemEle, "qurRate");
				pstmt.setInt(7, Integer.parseInt(qurrate));
			} catch (NumberFormatException e) {
				qurrate ="0";
				pstmt.setInt(7, Integer.parseInt(qurrate));
			}
			
			/* pstmt.setString(7, getValue(itemEle, "qurRate")); */ 
			
			String date = getValue(itemEle, "stdDay");
			SimpleDateFormat dateparser = new SimpleDateFormat("yyyy년 MM월 dd일 HH시");
			Date date2 = dateparser.parse(date);
			SimpleDateFormat datefomatter = new SimpleDateFormat("yyyy/MM/dd");
			String date3 = datefomatter.format(date2);
			pstmt.setString(8, date3); 
			pstmt.executeUpdate();

			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				   if(pstmt != null) pstmt.close();
				   if(conn != null) conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	   }
	   
		String getValue(Element Ele, String tag) {
			
			NodeList nList = Ele.getElementsByTagName(tag);
			Element nElmnt = (Element) nList.item(0);
			Node nNode = nElmnt.getFirstChild();
			return nNode.getNodeValue();
		}

		public int getDBDate() {
			   PreparedStatement pstmt = null;
			   Connection conn = null;
			   ResultSet rs = null;
			   int date = 0;
			   
			   try {
				   DBConn db = new DBConn();
				   conn = db.getConnection();
				   String sql = "SELECT TO_CHAR((SELECT NVL(MAX(STDDAY) , SYSDATE - 15) FROM COVIDSTATUS), 'yyyyMMdd') FROM DUAL";
				   pstmt = conn.prepareStatement(sql);
				   rs = pstmt.executeQuery();
				   
				   if(rs.next()) {
					   date = Integer.parseInt(rs.getString(1));
				   }
				
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				try {
					   if(pstmt != null) pstmt.close();
					   if(conn != null) conn.close();
					   if(rs != null) rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			   return date;
		}

		public StringBuilder getPeriodData(int period) {
			   PreparedStatement pstmt = null;
			   Connection conn = null;
			   ResultSet rs = null;
			   DBConn db = new DBConn();
			   conn = db.getConnection();
			   StringBuilder sb = new StringBuilder();
			   try {
				   
				   String header = "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>";
				   header +="<items>";
				   sb.append(header);
				   
				   for (int i = 0; i <= period; i++) {
					   String sql = "SELECT STATUSNUM, GUBUN, DEFCNT, DEATHCNT, INCDEC, LOCALOCCCNT, ISOLCLEARCNT, QURRATE, TO_CHAR(STDDAY,'YYYY-MM-DD') STDDAY"
					   		+ "	FROM COVIDSTATUS"
					   		+ "	WHERE STDDAY = TO_CHAR(SYSDATE - ?, 'yy/mm/dd')"
					   + "	ORDER BY DEFCNT DESC";
					   pstmt = conn.prepareStatement(sql);
					   pstmt.setInt(1, period - i);
					   
					   rs = pstmt.executeQuery();

					   while(rs.next()) {
						   String xml = "<item>";
						   xml += "<gubun>" + rs.getString("gubun") + "</gubun>";
						   xml += "<defCnt>" + rs.getString("defCnt") + "</defCnt>";
						   xml += "<deathCnt>" + rs.getString("deathCnt") + "</deathCnt>";
						   xml += "<incDec>" + rs.getString("incDec") + "</incDec>";
						   xml += "<localOccCnt>" + rs.getString("localOccCnt") + "</localOccCnt>";
						   xml += "<isolClearCnt>" + rs.getString("isolClearCnt") + "</isolClearCnt>";
						   xml += "<qurRate>" + rs.getString("qurRate") + "</qurRate>";
						   xml += "<stdDay>" + rs.getString("stdDay") + "</stdDay>";
						   xml += "</item>";
						   sb.append(xml);
					}

				}
				   String footer = "</items>";
				   sb.append(footer);
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				try {
					   if(pstmt != null) pstmt.close();
					   if(conn != null) conn.close();
					   if(rs != null) rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			   System.out.println("getPeriodData"+sb.toString());
			   return sb;
		}

		public StringBuilder getPeriodRecentData(int period) {
			   PreparedStatement pstmt = null;
			   Connection conn = null;
			   ResultSet rs = null;
			   DBConn db = new DBConn();
			   conn = db.getConnection();
			   StringBuilder sb = new StringBuilder();
			   try {
				   
				   String header = "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>";
				   header +="<items>";
				   sb.append(header);
				   
					/* for (int i = 0; i <= period; i++) { */  //FOR문
					   
					   
					     String sql = " SELECT * FROM COVIDSTATUS "
					     		+ " WHERE STDDAY BETWEEN TO_DATE((SELECT TO_CHAR((SELECT MAX(STDDAY) - ? FROM COVIDSTATUS), 'YYYY-MM-DD') FROM DUAL), 'YYYY-MM-DD') AND TO_DATE((SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') FROM DUAL),'YYYY-MM-DD') "
					     		+ " ORDER BY STDDAY DESC , DEFCNT DESC";
					 //  String sql = "SELECT *"
					   //		+ "	FROM COUNTRYCOVIDSTATUS"
					   	//	+ "	WHERE STDDAY = TO_CHAR(SYSDATE - ?, 'yy/mm/dd')"
					   		//+ "	ORDER BY STDDAY ";
					   pstmt = conn.prepareStatement(sql);
					   pstmt.setInt(1, period );
					   
					   rs = pstmt.executeQuery();

					   while(rs.next()) {
						   String xml = "<item>";
						   xml += "<gubun>" + rs.getString("gubun") + "</gubun>";
						   xml += "<defCnt>" + rs.getString("defCnt") + "</defCnt>";
						   xml += "<deathCnt>" + rs.getString("deathCnt") + "</deathCnt>";
						   xml += "<incDec>" + rs.getString("incDec") + "</incDec>";
						   xml += "<localOccCnt>" + rs.getString("localOccCnt") + "</localOccCnt>";
						   xml += "<isolClearCnt>" + rs.getString("isolClearCnt") + "</isolClearCnt>";
						   xml += "<qurRate>" + rs.getString("qurRate") + "</qurRate>";
						   xml += "<stdDay>" + rs.getString("stdDay") + "</stdDay>";
						   xml += "</item>";
						   sb.append(xml);
					}

				/*}*/   //FOR문 중괄호
				   String footer = "</items>";
				   sb.append(footer);
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				try {
					   if(pstmt != null) pstmt.close();
					   if(conn != null) conn.close();
					   if(rs != null) rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			   System.out.println("getPeriodData"+sb.toString());
			   return sb;
		}
		
		// 확진자 수가 많은 순으로 4 지역, 합계-------------------------------------------
		public StringBuilder getPeriodRecentData5() {
			PreparedStatement pstmt = null;
			Connection conn = null;
			ResultSet rs = null;
			DBConn db = new DBConn();
			conn = db.getConnection();
			StringBuilder sb = new StringBuilder();
			try {
				
				String header = "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>";
				header +="<items>";
				sb.append(header);
				
				/* for (int i = 0; i <= period; i++) { */  //FOR문
				
				
				String sql = "SELECT *"
						+ "  FROM ("
						+ "        SELECT * FROM COVIDSTATUS"
						+ "WHERE STDDAY BETWEEN TO_DATE((SELECT TO_CHAR((SELECT MAX(STDDAY) - 1 FROM COVIDSTATUS), 'YYYY-MM-DD') FROM DUAL), 'YYYY-MM-DD') AND TO_DATE((SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') FROM DUAL),'YYYY-MM-DD')"
						+ "ORDER BY STDDAY DESC , DEFCNT DESC"
						+ " WHERE ROWNUM <= 5";
				//  String sql = "SELECT *"
				//		+ "	FROM COUNTRYCOVIDSTATUS"
				//	+ "	WHERE STDDAY = TO_CHAR(SYSDATE - ?, 'yy/mm/dd')"
				//+ "	ORDER BY STDDAY ";
				pstmt = conn.prepareStatement(sql);
				
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					String xml = "<item>";
					xml += "<gubun>" + rs.getString("gubun") + "</gubun>";
					xml += "<defCnt>" + rs.getString("defCnt") + "</defCnt>";
					xml += "<deathCnt>" + rs.getString("deathCnt") + "</deathCnt>";
					xml += "<incDec>" + rs.getString("incDec") + "</incDec>";
					xml += "<localOccCnt>" + rs.getString("localOccCnt") + "</localOccCnt>";
					xml += "<isolClearCnt>" + rs.getString("isolClearCnt") + "</isolClearCnt>";
					xml += "<qurRate>" + rs.getString("qurRate") + "</qurRate>";
					xml += "<stdDay>" + rs.getString("stdDay") + "</stdDay>";
					xml += "</item>";
					sb.append(xml);
				}
				
				/*}*/   //FOR문 중괄호
				String footer = "</items>";
				sb.append(footer);
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				try {
					if(pstmt != null) pstmt.close();
					if(conn != null) conn.close();
					if(rs != null) rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			System.out.println("getPeriodData"+sb.toString());
			return sb;
		}
}
