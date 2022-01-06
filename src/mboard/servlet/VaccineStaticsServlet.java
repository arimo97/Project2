package mboard.servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.Period;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import mboard.dao.VaccineStaticsDao;

@WebServlet("/vaccinestaticsevlet")
public class VaccineStaticsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		int period = Integer.parseInt(request.getParameter("period"));
		// period = 5 -> 오늘(있을시에) , 어제 , 2일전, 3일전, 4일전, 5일전 데이터를 
		// ajax로 출력하는 서블렛임

		LocalDate today = LocalDate.now();
		VaccineStaticsDao vsDao = new VaccineStaticsDao();
		Fnc fnc = new Fnc();
		String json = fnc.getJSON(0).toString();
		
		try {
			JSONParser parser = new JSONParser();
			JSONObject jsobj;
			jsobj = (JSONObject) parser.parse(json);
			
			JSONArray data = (JSONArray) jsobj.get("data");

			if(data.isEmpty()) {
				int dbDate = vsDao.getDBDate();
				
				SimpleDateFormat dateParser = new SimpleDateFormat("yyyy-MM-dd");
				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
				String sysdate = LocalDate.now().toString();
				Date sysdate2 = dateParser.parse(sysdate);
				String sysdate3 = dateFormat.format(sysdate2);
				
				int dateGap = Integer.parseInt(sysdate3) - dbDate;
				System.out.println("json empty:"+dateGap);
				
				if (dateGap > 0) {
					// 오늘 sys 데이터 ~ DB에서 최신인 데이터의 날짜 + 1 까지 DB에 추가
					vsDao.insertPeriodData(fnc.getJSON(dateGap - 1));
					}
				
				//DB에서 15일치 들고와서 뿌림
				//json = vsDao.getPeriodData(15).toString();
				json = vsDao.getPeriodData(period).toString();
			} else {
				
				// DB에서 최신날짜를 뽑아냄
				int dbDate = vsDao.getDBDate();
				System.out.println("dadate:"+dbDate);
				
				JSONObject tmp = (JSONObject) data.get(0);
				String apiDate = tmp.get("baseDate").toString().substring(0,10);
				System.out.println("apiDate:"+apiDate);
				// apiDate를 2021-12-05 형식에서 20211205형식으로 변환

				SimpleDateFormat dateparser = new SimpleDateFormat("yyyy-MM-dd");
				Date apiDate2 = dateparser.parse(apiDate);
				System.out.println("apiDate2:"+apiDate2);
				SimpleDateFormat datefomatter = new SimpleDateFormat("yyyyMMdd");
				String apiDate3 = datefomatter.format(apiDate2);
				System.out.println("apiDate3:"+apiDate3);
				
				
				int dateGap = Integer.parseInt(apiDate3) - dbDate;
				System.out.println("json not empty:"+dateGap);
				// 20211206 - 20211205 = 1
				// 1일 차이남 오늘꺼 받아와야함
				
				if (dateGap > 0) {
					// 오늘 api 데이터 ~ DB에서 최신인 데이터의 다음날까지 DB에 추가
					vsDao.insertPeriodData(fnc.getJSON(dateGap - 1));
					//  dataGap = 0 오늘꺼, dataGap = 1 오늘꺼, 어제꺼, dateGap = 2 오늘꺼, 어제꺼, 2일전꺼 .........
					}
				//DB에서 15일치 들고와서 뿌림
				//json = vsDao.getPeriodData(15).toString();
				json = vsDao.getPeriodData(period).toString();
			}
		} catch (ParseException e) {
			e.printStackTrace();
		} catch (java.text.ParseException e) {
			e.printStackTrace();
		}
		

		response.setContentType("application/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.print(json);
		out.close();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

	
	// dayBeforefromToday 을받아서 오늘로부터 몇일 전까지 받을지 결정
	// 오늘이 12월 5일이고 dayBeforefromToday = 5 라면 12월 1, 2, 3, 4, 5일 데이터를 모두 불러옴
	// 데이터를 받은뒤 데이터가 모두 저장된 StringBuilder를 return하는 함수
	class Fnc {
		StringBuilder json = null;

		StringBuilder getJSON(int dayBeforefromToday) {
			StringBuilder json = null;
			try {
				String serviceKey = "OpXrReIFM3WssvT1gl8awDpSJusm5iswRhH80AwQNFPNUCPbDXxRmfNkrTarhDCq6N0Izazwla%2FOMt9RlBpc%2Fw%3D%3D";
				LocalDate today = LocalDate.now();
				System.out.println(today.minus(Period.ofDays(dayBeforefromToday)));

				String urlStr = "https://api.odcloud.kr/api/15077756/v1/vaccine-stat";
				urlStr += "?" + URLEncoder.encode("page", "UTF-8") + "=1";
				urlStr += "&" + URLEncoder.encode("perPage", "UTF-8") + "=10000";
				urlStr += "&" + URLEncoder.encode("cond", "UTF-8") + "%5BbaseDate%3A%3AGTE%5D=" + today.minus(Period.ofDays(dayBeforefromToday))
						+ "%2000%3A00%3A00";
				urlStr += "&" + URLEncoder.encode("serviceKey", "UTF-8") + "=" + serviceKey;

				URL url = new URL(urlStr);

				HttpURLConnection conn = (HttpURLConnection) url.openConnection();
				conn.setRequestMethod("GET");
				conn.setRequestProperty("Content-type", "application/json");

				String line = "";
				json = new StringBuilder();

				BufferedReader br;
				br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
				while ((line = br.readLine()) != null) {
					json.append(line);
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
			return json;
		}
	}

}
/*
	HttpURLConnection conn;
	URL url;
	BufferedReader br;
	StringBuilder sb;
	
	// 데이터 하나만 받아서 sb에 저장 (최신인지 확인용)
	
	Fnc fnc = new Fnc();
	String Address = "https://api.odcloud.kr/api/apnmOrg/v1/list?";url=new URL(Address+"serviceKey=L1pgoDpVUPJYRf6a%2BVEOyYG7c%2BBVuYzHOwbRLx8h2GyKLmETCICflwglq5NQQ64umxGjdkra%2F0B8VDMkGl4fBQ%3D%3D"+"&page="+1+"&perPage="+1);sb=fnc.getJSON(url);
	
	// sb에서 날짜만 뽑아냄 JSONParser parser = new JSONParser(); JSONObject jsobj =
	(JSONObject)parser.parse(sb.toString());
	JSONArray data = (JSONArray) jsobj.get("data");
	JSONObject tmp = (JSONObject) data.get(0); // api 데이터 날짜
	String apiDate = tmp.get("slrYmd").toString();
	
	GPSDao gpsDao = new GPSDao();
	int dbDate = gpsDao.getDate(); // db에 있는 데이터 날짜
	SimpleDateFormat timeFormat = new SimpleDateFormat("yyyyMMdd");
	
	// 오늘 날짜랑 비교해야하는데 api데이터가 스트링 타입이라 date 타입으로 바꿔 줌 Date apiDate2 =
	timeFormat.parse(apiDate); // db에디터가 int라서 date타입으로 바꿔줌 Date dbDate2 =
	timeFormat.parse(String.valueOf(dbDate));
	
	api날짜가 지금
	시스템 날짜보다 앞서있으면->
	업데이트가 필요 if(apiDate2.getDate()-dbDate2.getDate()<0)
	{
		Address = "https://api.odcloud.kr/api/apnmOrg/v1/list?";
		url = new URL(Address
				+ "page=1&perPage=8000&serviceKey=L1pgoDpVUPJYRf6a%2BVEOyYG7c%2BBVuYzHOwbRLx8h2GyKLmETCICflwglq5NQQ64umxGjdkra%2F0B8VDMkGl4fBQ%3D%3D");
		sb = fnc.getJSON(url);
		request.setAttribute("json1", sb.toString());
		url = new URL(Address
				+ "page=2&perPage=8000&serviceKey=L1pgoDpVUPJYRf6a%2BVEOyYG7c%2BBVuYzHOwbRLx8h2GyKLmETCICflwglq5NQQ64umxGjdkra%2F0B8VDMkGl4fBQ%3D%3D");
		sb = fnc.getJSON(url);
		request.setAttribute("json2", sb.toString());
		request.setAttribute("dbDate", dbDate);
		String path = "/addrtocoords";
		request.getRequestDispatcher(path).forward(request, response);
	}else
	{
	
	}
*/


/*
// api 업뎃이 존재하면 DB에 api 데어터를 추가한 후 DB에서 15일치를 들고와서 뿌림
				fnc = new Fnc();
				
				// String api에 오늘날짜 api 데이터 저장
				String api = fnc.getJSON(0).toString();
				
				JSONParser parser = new JSONParser();
				JSONObject jsobj = (JSONObject) parser.parse(json);
				data = (JSONArray) jsobj.get("data");
				JSONObject tmp = (JSONObject) data.get(0);
				
				
				// 오늘 api 데이터 날짜
				String apiDate = tmp.get("baseDate").toString();

				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
				String apiDate2 = dateFormat.format(apiDate);
				String today2 = dateFormat.format(today);

				// 20211205 - 20211204 = 1
				// DB에서 최신인 데이터의 다음날 ~ 오늘까지 DB에 추가
				int dateGap = Integer.parseInt(today2.toString()) - Integer.parseInt(apiDate2.toString());

*/
