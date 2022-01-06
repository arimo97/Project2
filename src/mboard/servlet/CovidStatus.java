package mboard.servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/covidstatus")
public class CovidStatus extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		// String  gubun = request.getParameter("gubun");
		
		LocalDate now = LocalDate.now(); 
		LocalDate fiveDayAgo = now.minusDays(3);
		String startCreateDt = now.format(DateTimeFormatter.ofPattern("yyyyMMdd"));
		String endCreateDt = fiveDayAgo.format(DateTimeFormatter.ofPattern("yyyyMMdd"));
		
		String  key      = "hRXt5X1gQAgvpF06fQ7kUIW1%2BdY%2BQ4LiV3g5DFhFiH%2FvJUSK%2FEo%2BiOfn9YVDsdZPN%2FWaabFsPga4Nlu7KYzX0A%3D%3D"; 
		   // 일반 인증키 (Encoding)
		
		// 호출
		StringBuilder  urlBuilder = new StringBuilder(
			"http://openapi.data.go.kr/openapi/service/rest/Covid19/getCovid19SidoInfStateJson"); // URL
		urlBuilder.append("?" + URLEncoder.encode("serviceKey", "UTF-8")    + "=" + key);
		urlBuilder.append("&" + URLEncoder.encode("pageNo", "UTF-8")        + "=" + URLEncoder.encode("1", "UTF-8"));
		urlBuilder.append("&" + URLEncoder.encode("numOfRows", "UTF-8")     + "=" + URLEncoder.encode("10", "UTF-8"));
		// urlBuilder.append("&" + URLEncoder.encode("startCreateDt", "UTF-8") + "=" + URLEncoder.encode(startCreateDt, "UTF-8"));
		urlBuilder.append("&" + URLEncoder.encode("startCreateDt", "UTF-8") + "=" + URLEncoder.encode("20200410", "UTF-8"));
		// urlBuilder.append("&" + URLEncoder.encode("endCreateDt", "UTF-8")   + "=" + URLEncoder.encode(endCreateDt, "UTF-8"));
		urlBuilder.append("&" + URLEncoder.encode("endCreateDt", "UTF-8")   + "=" + URLEncoder.encode("20200410", "UTF-8"));
		// urlBuilder.append("&" + URLEncoder.encode("GUBUN", "UTF-8")         + "=" + URLEncoder.encode(gubun, "UTF-8"));
		
		URL  url   =  new URL( urlBuilder.toString() );
		System.out.println(url);
		HttpURLConnection  conn = (HttpURLConnection) url.openConnection(); // $.ajax
		conn.setRequestMethod("GET");
		conn.setRequestProperty("Content-type", "application/xml");
		System.out.println("Response Code:" + conn.getResponseCode());  // 200, 404, 500
		
		// 도착한 데이터 처리
		BufferedReader   br;
		if( conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300 ) {
			br = new BufferedReader(new InputStreamReader(conn.getInputStream() ));
		} else {
			br = new BufferedReader(new InputStreamReader(conn.getErrorStream() ));			
		}
		
		//  data -> 문자열로 변환
		StringBuilder  sb     = new StringBuilder();
		String         line;
		while( ( line = br.readLine() ) != null ) {
			sb.append( line );
		}
		br.close();
		conn.disconnect();
		System.out.println( sb.toString() );
			
		// 출력
		
		String xml = sb.toString();
		
		/*
		 * String xml = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"; xml += "<items>";
		 * for (int i = 0; i < sb.length(); i++) { xml += sb.toString(); } xml +=
		 * "</items>";
		 */
		
		response.setContentType("application/xml;charset=UTF-8");
		PrintWriter out  = response.getWriter();
		out.print( xml );
		out.close();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}