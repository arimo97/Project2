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

@WebServlet("/ytnews1")
public class YoutubeNews1 extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

/*
					data.id.videoId
					data.snippet.title
					data.snippet.description
					data.snippet.thumbnails.high.url */
			
			response.setContentType("application/json;charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			
			JSONArray tmp1 = getJSON("UChlgI3UHCOnwUGzWzbJ3H5w");
			out.print(tmp1);
			
//			outarr.add(getJSON("UChlgI3UHCOnwUGzWzbJ3H5w")); //ytn
//			outarr.add(getJSON("UCF4Wxdo3inmxP-Y59wXDsFw")); // mbc
//			outarr.add(getJSON("UCcQTRi69dsVYHN3exePtZ1A")); // kbs
//			outarr.add(getJSON("UCa7-3Zvxg-5Rfxgu3RQY_gw")); //질본
			
			
			
			out.close();
			
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
	
	public JSONArray getJSON(String channelId) throws IOException {
		String apiurl = "https://www.googleapis.com/youtube/v3/search";
		apiurl += "?key=AIzaSyDQgWd0sSb0HNFhyhePohKAGYdqliUnIME";
		apiurl += "&part=snippet&type=video&maxResults=5&videoEmbeddable=true&order=date&channelId=" + channelId;
		apiurl += "&q="+URLEncoder.encode("코로나","UTF-8");
		
		URL url = new URL(apiurl);
		HttpURLConnection con = (HttpURLConnection) url.openConnection();
		con.setRequestMethod("GET");
		
		BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream(),"UTF-8"));
		String inputLine;
		StringBuilder sb = new StringBuilder();
		JSONArray items = new JSONArray();
		
		
		while((inputLine = br.readLine()) != null) {
			sb.append(inputLine);
		}
		br.close();
		
		try {
			JSONParser parser = new JSONParser();
			JSONObject obj = new JSONObject();
			obj = (JSONObject) parser.parse(sb.toString());
			items = (JSONArray) obj.get("items");
			
			
		} catch (ParseException e) {
			e.printStackTrace();
		}
		System.out.println("items : " + items);
		return items;
	}
	
}
