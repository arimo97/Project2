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

public class CountryCovidStatusDao {

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
			
			String sql = "INSERT INTO COUNTRYCOVIDSTATUS"
					+ "	VALUES((SELECT NVL(MAX(COUNTRYNUM), 0) + 1 FROM COUNTRYCOVIDSTATUS), ?, ?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, getValue(itemEle, "nationNm")); 
			pstmt.setString(2, getValue(itemEle, "areaNm")); 
			pstmt.setInt(3, Integer.parseInt(getValue(itemEle, "natDefCnt"))); 
			pstmt.setInt(4, Integer.parseInt(getValue(itemEle, "natDeathCnt"))); 
			pstmt.setDouble(5, Double.parseDouble(getValue(itemEle, "natDeathRate"))); 
			
			String date = getValue(itemEle, "stdDay");
			SimpleDateFormat dateparser = new SimpleDateFormat("yyyy년 MM월 dd일 HH시");
			Date date2 = dateparser.parse(date);
			SimpleDateFormat datefomatter = new SimpleDateFormat("yyyy/MM/dd");
			String date3 = datefomatter.format(date2);
			pstmt.setString(6, date3); 
			pstmt.executeUpdate();

			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
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
				   String sql = "SELECT TO_CHAR((SELECT MAX(STDDAY) FROM COUNTRYCOVIDSTATUS), 'yyyyMMdd') FROM DUAL";
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
						/* String sql = "SELECT * */
					   		String sql = " SELECT COUNTRYNUM, NATIONNM, AREANM, NATDEFCNT, NATDEATHCNT, NATDEATHRATE, TO_CHAR(STDDAY,'YYYY-MM-DD') STDDAY "
					   		+ "	FROM COUNTRYCOVIDSTATUS"
					   		+ "	WHERE STDDAY = TO_CHAR(SYSDATE - ?, 'yy/mm/dd')";
					   pstmt = conn.prepareStatement(sql);
					   pstmt.setInt(1, period - i);
					   /*
						COUNTRYNUM
						NATIONNM
						AREANM
						NATDEFCNT
						NATDEATHCNT
						NATDEATHRATE
						STDDAY
						
						<areaNm>아시아</areaNm>
						<areaNmCn>亚洲</areaNmCn>
						<areaNmEn>Asia</areaNmEn>
						<createDt>2021-11-26 09:55:12.422</createDt>
						<natDeathCnt>3440</natDeathCnt>
						<natDeathRate>0.7946389590</natDeathRate>
						<natDefCnt>432901</natDefCnt>
						<nationNm>한국</nationNm>
						<nationNmCn>韓国</nationNmCn>
						<nationNmEn>South Korea</nationNmEn>
						<seq>132770</seq>
						<stdDay>2021년 11월 26일 00시</stdDay>
						<updateDt>null</updateDt>
						
						pstmt.setString(1, getValue(itemEle, "nationNm")); 
						pstmt.setString(2, getValue(itemEle, "areaNm")); 
						pstmt.setString(3, getValue(itemEle, "natDefCnt")); 
						pstmt.setString(4, getValue(itemEle, "natDeathCnt")); 
						pstmt.setString(5, getValue(itemEle, "natDeathRate")); 
						pstmt.setString(6, getValue(itemEle, "stdDay")); 
					*/
					   rs = pstmt.executeQuery();

					   while(rs.next()) {
						   String xml = "<item>";
						   xml += "<nationNm>" + rs.getString("nationNm") + "</nationNm>";
						   xml += "<areaNm>" + rs.getString("areaNm") + "</areaNm>";
						   xml += "<natDefCnt>" + rs.getString("natDefCnt") + "</natDefCnt>";
						   xml += "<natDeathCnt>" + rs.getString("natDeathCnt") + "</natDeathCnt>";
						   xml += "<natDeathRate>" + rs.getString("natDeathRate") + "</natDeathRate>";
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
					   
					   
					     String sql = " SELECT COUNTRYNUM, NATIONNM, AREANM, NATDEFCNT, NATDEATHCNT, NATDEATHRATE, TO_CHAR(STDDAY,'YYYY-MM-DD') STDDAY FROM COUNTRYCOVIDSTATUS "
					     		+ " WHERE STDDAY BETWEEN TO_DATE((SELECT TO_CHAR((SELECT MAX(STDDAY) - ? FROM COUNTRYCOVIDSTATUS), 'YYYY-MM-DD') FROM DUAL), 'YYYY-MM-DD') AND TO_DATE((SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') FROM DUAL),'YYYY-MM-DD') "
					     		+ " ORDER BY STDDAY DESC ";
					 //  String sql = "SELECT *"
					   //		+ "	FROM COUNTRYCOVIDSTATUS"
					   	//	+ "	WHERE STDDAY = TO_CHAR(SYSDATE - ?, 'yy/mm/dd')"
					   		//+ "	ORDER BY STDDAY ";
					   pstmt = conn.prepareStatement(sql);
					   pstmt.setInt(1, period );
					   /*
						COUNTRYNUM
						NATIONNM
						AREANM
						NATDEFCNT
						NATDEATHCNT
						NATDEATHRATE
						STDDAY
						
						<areaNm>아시아</areaNm>
						<areaNmCn>亚洲</areaNmCn>
						<areaNmEn>Asia</areaNmEn>
						<createDt>2021-11-26 09:55:12.422</createDt>
						<natDeathCnt>3440</natDeathCnt>
						<natDeathRate>0.7946389590</natDeathRate>
						<natDefCnt>432901</natDefCnt>
						<nationNm>한국</nationNm>
						<nationNmCn>韓国</nationNmCn>
						<nationNmEn>South Korea</nationNmEn>
						<seq>132770</seq>
						<stdDay>2021년 11월 26일 00시</stdDay>
						<updateDt>null</updateDt>
						
						pstmt.setString(1, getValue(itemEle, "nationNm")); 
						pstmt.setString(2, getValue(itemEle, "areaNm")); 
						pstmt.setString(3, getValue(itemEle, "natDefCnt")); 
						pstmt.setString(4, getValue(itemEle, "natDeathCnt")); 
						pstmt.setString(5, getValue(itemEle, "natDeathRate")); 
						pstmt.setString(6, getValue(itemEle, "stdDay")); 
					*/
					   rs = pstmt.executeQuery();

					   while(rs.next()) {
						   String xml = "<item>";
						   xml += "<nationNm>" + rs.getString("nationNm") + "</nationNm>";
						   xml += "<areaNm>" + rs.getString("areaNm") + "</areaNm>";
						   xml += "<natDefCnt>" + rs.getString("natDefCnt") + "</natDefCnt>";
						   xml += "<natDeathCnt>" + rs.getString("natDeathCnt") + "</natDeathCnt>";
						   xml += "<natDeathRate>" + rs.getString("natDeathRate") + "</natDeathRate>";
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
			   return sb;
		}
}
