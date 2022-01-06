package mboard.dao;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;

public class NewsGetImgDao {

	public String getImg(String link) throws IOException {
		
	        String pageContents = "";
	 
	        URL url = new URL(link);
	        URLConnection con = (URLConnection)url.openConnection();
	        BufferedReader buff = new BufferedReader (new InputStreamReader (con.getInputStream(), "euc-kr"));
	        
	        for (int i = 0; i < 35; i++) {
	        	try {
	        		if (i == 0) {
	        			pageContents = buff.readLine(); 
	        			if(pageContents.contentEquals("<!DOCTYPE HTML PUBLIC \"-//IETF//DTD HTML 2.0//EN\">")) {
	        				pageContents = "../img/imgnotfound.png"; 
	        				break;	        			
	        			}
	        		}
	        		buff.readLine();
	        		if ( i >= 30 && i <= 34 ) {
	        			pageContents = buff.readLine();
	        			System.out.println(pageContents);
	        			if (pageContents.contains("<meta property=\"og:image\"			content=\"")) {
	        				pageContents = pageContents.replace("<meta property=\"og:image\"			content=\"", "");
	        				pageContents = pageContents.replace("\"/>", "");
	        				break;
	        			}
	        			if (pageContents.contains("		<meta property=\"og:image\"       content=\"")) {
	        				pageContents = pageContents.replace("		<meta property=\"og:image\"       content=\"", "");
	        				pageContents = pageContents.replace("\" />", "");
	        				break;
	        			}
	        		}
	        	} catch (NullPointerException e) {
	        		e.printStackTrace();
	        		pageContents = "../img/imgnotfound.png"; 
				}
			}
            /*
	        while((pageContents = buff.readLine()) != null){
            	if (pageContents.contains("<meta name=\"twitter:image\"")) {
            		pageContents = pageContents.replace("<meta name=\"twitter:image\"			content=\"", "");
            		pageContents = pageContents.replace("\">", "");
            		break;
            		}
            	}
            */
            buff.close();
            
            return pageContents;
	}

}
