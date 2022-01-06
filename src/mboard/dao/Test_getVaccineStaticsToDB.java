package mboard.dao;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.time.LocalDate;
import java.time.Period;

public class Test_getVaccineStaticsToDB {

		static StringBuilder getJSON(int dayBeforefromToday) {
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
				System.out.println("Response Code:" + conn.getResponseCode());

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
	
	public static void main(String[] args) {
		String json;
		
		try {
			VaccineStaticsDao vsDao = new VaccineStaticsDao();
			vsDao.insertPeriodData(getJSON(15));

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
