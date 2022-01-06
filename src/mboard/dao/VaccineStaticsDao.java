package mboard.dao;

import java.io.BufferedReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Vector;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import db.DBConn;

public class VaccineStaticsDao {

   private static String Address;
   private static URL url;
   private static BufferedReader br;
   private static HttpURLConnection conn;
   private static String protocol = "GET";
   private static String id;
   private static String secret;
   private static String size;
   private static String search;
   private static Vector outV;
   private static String authKey;
   private static LocalDate date = LocalDate.now();
   
   
   public JSONObject getPeriodData(int period) {
	   PreparedStatement pstmt = null;
	   Connection conn = null;
	   ResultSet rs = null;
	   JSONArray data = new JSONArray();
	   JSONObject out = new JSONObject();
	   DBConn db = new DBConn();
	   conn = db.getConnection();
	   try {
			   String sql = "SELECT V.SIDO, V.FIRSTCNT, V.SECONDCNT, V.thirdCnt, V.totalFirstCnt, V.totalSecondCnt, V.totalThirdCnt,"
			   		+ " TO_CHAR(V.BASEDATE, 'yyyy-MM-dd') BASEDATE, P.POPULATION"
			   		+ "	FROM VaccineStatics V, POPULATION P"
			   		+ "	WHERE V.SIDO = P.SIDO"
			   		+ " AND BASEDATE >= TO_CHAR(SYSDATE - ?, 'yy/mm/dd')"
			   		+ "	ORDER BY BASEDATE DESC, V.SEQ";
			   pstmt = conn.prepareStatement(sql);
			   pstmt.setInt(1, period);
			   
			   rs = pstmt.executeQuery();
			   while(rs.next()) {
				   JSONObject jsobj = new JSONObject();
				   jsobj.put("sido", rs.getString("sido"));
				   jsobj.put("firstCnt", rs.getString("firstCnt"));
				   jsobj.put("secondCnt", rs.getString("secondCnt"));
				   jsobj.put("thirdCnt", rs.getString("thirdCnt"));
				   jsobj.put("totalFirstCnt", rs.getString("totalFirstCnt"));
				   jsobj.put("totalSecondCnt", rs.getString("totalSecondCnt"));
				   jsobj.put("totalThirdCnt", rs.getString("totalThirdCnt"));
				   jsobj.put("population", rs.getString("POPULATION"));
				   jsobj.put("baseDate", rs.getString("baseDate"));
				   data.add(jsobj);
			}
			   
			  /* {
					"currentCount": 10,
					"data": [
						{
							"accumulatedFirstCnt": 42421599,
							"accumulatedSecondCnt": 40767383,
							"accumulatedThirdCnt": 2478097,
							"baseDate": "2021-11-27 00:00:00",
							"firstCnt": 54302,
							"id": 4705,
							"secondCnt": 84823,
							"sido": "전국",
							"thirdCnt": 284323,
							"totalFirstCnt": 42475901,
							"totalSecondCnt": 40852206,
							"totalThirdCnt": 2762420
						},
				 
				 */
				 
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
	   out.put("data", data);
	   return out;
   }
   
   public void insertPeriodData(StringBuilder json){
	   PreparedStatement pstmt = null;
	   Connection conn = null;
	   ResultSet rs = null;
	try {
		JSONArray data = new JSONArray();
		DBConn db = new DBConn();
		conn = db.getConnection();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		
		JSONParser parser = new JSONParser();
		JSONObject obj;
		obj = (JSONObject) parser.parse(json.toString());
		JSONArray data1 = (JSONArray) obj.get("data");
		for (int i = 0; i < data1.size(); i++) {
			JSONObject tmp = (JSONObject) data1.get(i);
			String sql = "INSERT INTO VACCINESTATICS"
					+ "	VALUES((SELECT NVL(MAX(SEQ), 0) + 1 FROM VACCINESTATICS), ?, ?, ?, ?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, tmp.get("sido").toString()); 
			pstmt.setInt(2, Integer.parseInt(tmp.get("firstCnt").toString())); 
			pstmt.setInt(3, Integer.parseInt(tmp.get("secondCnt").toString())); 
			pstmt.setInt(4, Integer.parseInt(tmp.get("thirdCnt").toString())); 
			pstmt.setInt(5, Integer.parseInt(tmp.get("totalFirstCnt").toString())); 
			pstmt.setInt(6, Integer.parseInt(tmp.get("totalSecondCnt").toString())); 
			pstmt.setInt(7, Integer.parseInt(tmp.get("totalThirdCnt").toString())); 
			pstmt.setString(8, tmp.get("baseDate").toString().substring(0, 10)); 
			pstmt.executeUpdate();
		}
	} catch (ParseException e) {
		e.printStackTrace();
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
   }
   
   public int getDBDate() {
	   PreparedStatement pstmt = null;
	   Connection conn = null;
	   ResultSet rs = null;
	   int date = 0;
	   
	   try {
		   DBConn db = new DBConn();
		   conn = db.getConnection();
		   String sql = "SELECT NVL(TO_CHAR((SELECT MAX(BASEDATE) FROM VACCINESTATICS), 'yyyyMMdd'), TO_CHAR(SYSDATE - 15, 'yyyyMMdd')) FROM DUAL";
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
   
/*
	   public Vector VaccineDao() throws java.text.ParseException {
      try {
         Address = "https://api.odcloud.kr/api/15077756/v1/vaccine-stat?&cond%5BbaseDate%3A%3AGTE%5D="; 
         authKey = "OpXrReIFM3WssvT1gl8awDpSJusm5iswRhH80AwQNFPNUCPbDXxRmfNkrTarhDCq6N0Izazwla%2FOMt9RlBpc%2Fw%3D%3D"; 
         String perPage = "&perPage=" + 18;
         String servicekey = "&serviceKey=";
        LocalDate	date1		= date.now();
        SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy-MM-dd"); 
        Date time = new Date();
        String today1 = simpleDate.format(time);
        Date selectDate = simpleDate.parse(today1);
        Calendar cal =new GregorianCalendar(Locale.KOREA);
        cal.setTime(selectDate);
        cal.add(Calendar.DATE, -1);
        String yesterDay = simpleDate.format(cal.getTime());
         url = new URL(Address + yesterDay + servicekey + authKey + perPage);
         conn = (HttpURLConnection) url.openConnection();
         conn.setRequestProperty("X-Naver-Client-Id", id);
         conn.setRequestProperty("X-Naver-Client-Secret", secret);
         conn.setRequestMethod(protocol);
         br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
         StringBuffer sb = new StringBuffer();
         String json;
         
         
         while ((json = br.readLine()) != null)
            sb.append(json);
//         --------------------------------------------------------------------------------
//          원본 보기
         System.out.println(sb.toString());
//         --------------------------------------------------------------------------------

         // 쓸 수 있도록 형태 가공
         JSONParser parser = new JSONParser();
         JSONObject obj = (JSONObject) parser.parse(sb.toString());
         JSONArray data = (JSONArray) obj.get("data");
         String pattern ="yyyy-MM-dd";
         SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
       
         outV = new Vector();
         for (int i = 0; i < data.size(); i++) {
            Vector v = new Vector();
            JSONObject tmp = (JSONObject) data.get(i);
            
            v.add(tmp.get("sido").toString()); 
            v.add(tmp.get("firstCnt").toString()); 
            v.add(tmp.get("secondCnt").toString()); 
            v.add(tmp.get("accumulatedFirstCnt").toString()); 
            v.add(tmp.get("accumulatedSecondCnt").toString());
            v.add(tmp.get("baseDate").toString()); 
            outV.add(v);
            
         }
         System.out.println(outV);
      } catch (UnsupportedEncodingException e) {
         e.printStackTrace();
      } catch (MalformedURLException e) {
         e.printStackTrace();
      } catch (ProtocolException e) {
         e.printStackTrace();
      } catch (IOException e) {
         e.printStackTrace();
      } catch (ParseException e) {
         e.printStackTrace();
      }
      return outV;
   }
*/
   
}