package mboard.dao;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.time.LocalDate;
import java.time.Period;
import java.time.format.DateTimeFormatter;

public class Test_getCovidstatusToDB {

static StringBuilder sb = null;
	
	static StringBuilder getDataPeriod(int period) throws IOException {
		LocalDate now = LocalDate.now();
		System.out.println("todayminus" + now.minus(Period.ofDays(1)));
		
		 LocalDate oneDayAgo = now.minusDays(period); 
		 String startCreateDt = oneDayAgo.format(DateTimeFormatter.ofPattern("yyyyMMdd")); //15
		 String endCreateDt =now.format(DateTimeFormatter.ofPattern("yyyyMMdd")); //오늘
		 System.out.println("startCreateDt:" + startCreateDt);
		 System.out.println("endCreateDt:" + endCreateDt);
		
		String  key      = "hRXt5X1gQAgvpF06fQ7kUIW1%2BdY%2BQ4LiV3g5DFhFiH%2FvJUSK%2FEo%2BiOfn9YVDsdZPN%2FWaabFsPga4Nlu7KYzX0A%3D%3D"; 
		   // 일반 인증키 (Encoding)
		
		// 호출
		StringBuilder  urlBuilder = new StringBuilder(
				"http://openapi.data.go.kr/openapi/service/rest/Covid19/getCovid19SidoInfStateJson"); // URL
		urlBuilder.append("?" + URLEncoder.encode("serviceKey", "UTF-8")    + "=" + key);
		urlBuilder.append("&" + URLEncoder.encode("pageNo", "UTF-8")        + "=" + URLEncoder.encode("1", "UTF-8"));
		urlBuilder.append("&" + URLEncoder.encode("numOfRows", "UTF-8")     + "=" + URLEncoder.encode("10", "UTF-8"));
		urlBuilder.append("&" + URLEncoder.encode("startCreateDt", "UTF-8") + "=" + URLEncoder.encode(startCreateDt, "UTF-8"));
		//urlBuilder.append("&" + URLEncoder.encode("startCreateDt", "UTF-8") + "=" + URLEncoder.encode("20211201", "UTF-8"));
		urlBuilder.append("&" + URLEncoder.encode("endCreateDt", "UTF-8")   + "=" + URLEncoder.encode(endCreateDt, "UTF-8"));
		//urlBuilder.append("&" + URLEncoder.encode("endCreateDt", "UTF-8")   + "=" + URLEncoder.encode("20211202", "UTF-8"));
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
		 sb     = new StringBuilder();
		String         line;
		while( ( line = br.readLine() ) != null ) {
			sb.append( line );
		}
		
		br.close();
		conn.disconnect();
		System.out.println("sb.toString :" + sb.toString() );
		
		
		return sb;
		}
	
	
	
	public static void main(String[] args) {
		

		try {
			CovidStatusDao csDao = new CovidStatusDao();
			csDao.insertPeriodData(getDataPeriod(15));

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
