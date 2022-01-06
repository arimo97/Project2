package mboard.servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import mboard.dao.NewsGetImgDao;

@WebServlet("/newshome")
public class NewsServletHome extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private static String Address;
	private static URL url;
	private static BufferedReader br;
	private static HttpURLConnection conn;
	private static String protocol = "GET";
	private static String id;
	private static String secret;
	private static String size;
	private static String search;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Address = "https://openapi.naver.com/v1/search/news.json?sort=sim&query=";
		id = "VFcnH9cj3uNJ3ZgobKdr"; // client-id
		secret = "aZrGgcxeXR"; // api secret key
		search = URLEncoder.encode("코로나", "UTF-8");// 검색어
		size = "&display=" + 5;

		url = new URL(Address + search + size);
		conn = (HttpURLConnection) url.openConnection();
		conn.setRequestProperty("X-Naver-Client-Id", id);
		conn.setRequestProperty("X-Naver-Client-Secret", secret);
		conn.setRequestMethod(protocol);

		br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
		StringBuffer sb = new StringBuffer();
		String json;
		JSONArray outarr = new JSONArray();
		NewsGetImgDao ngiDao = new NewsGetImgDao();
		
		while ((json = br.readLine()) != null)
			sb.append(json);
		
		try {
			JSONParser parser = new JSONParser();
			JSONObject obj = (JSONObject) parser.parse(sb.toString());
			JSONArray arr = (JSONArray) obj.get("items");
			
			for (int i = 0; i < arr.size(); i++) {
				JSONObject tmp = (JSONObject) arr.get(i);
				String imgLink = ngiDao.getImg(tmp.get("link").toString());
				if (imgLink.isEmpty() || imgLink == null)
					imgLink = "https://ssl.pstatic.net/static.news/image/news/ogtag/navernews_200x200_20160804.png";
				tmp.put("img", imgLink);
				outarr.add(tmp);
			}
			
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		
		response.setContentType("application/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.write(outarr.toJSONString());
		out.close();
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
