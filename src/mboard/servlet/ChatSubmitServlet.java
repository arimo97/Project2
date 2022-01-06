package mboard.servlet;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URLDecoder;
import java.util.Scanner;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import mboard.dao.ChatDAO;

@WebServlet("/ChatSubmitServlet")
public class ChatSubmitServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
      
	static String msg;
	static String[] rmsg;
	
	static String filteredmsg;

	public static String filtering(String msg) {
		FileInputStream fis;
		InputStreamReader isr;
		BufferedReader bReader;
		try {
			String  path    =  ChatSubmitServlet.class.getResource(
					 "fword_list.txt").getPath();
//			fis = new FileInputStream(new File("./src/text/fword_list.txt"));
			fis = new FileInputStream(new File(path));
			isr = new InputStreamReader(fis,"UTF-8");
			bReader = new BufferedReader(isr);
			String words = bReader.readLine();
		// 파일에서 한줄씩 읽어와서 words에 저장
			System.out.println("words:" + words);
			String[] warr = words.split(",");
			
			
			
			System.out.println("warr:" + warr);
		//,를 구분자로 words에 저장되 있는 단어들을 구분해서 각 요소에 저장
			int size=warr.length; // 생성된 배열의 길이를 저장
			String filterword = "";
			for (int i = 0; i < size; i++) {
				filterword = warr[i]; //한 요소씩 읽어서 filterword에 저장
				filterword = filterword.trim();
				if(msg.contains(filterword)) {
				// 매개변수로 받은 채팅내용에 해당 단어가 포함되어 있는 지 확인
					int s =filterword.length();
				// 해당 단어(요소에서 읽어 온 단어)의 길이 저장
					String hider = "";
					int j = 0;
					while(j<s) {
				// 해당 단어 길이 만큼을 *를 데이터로 갖고 있는 String변수 hinder 만들기
						hider = hider + "*";
						j++;
					}
					msg = msg.replace(filterword, hider);
				//대화 내용중 filterword 부분을 hinder로 대체하여 다시 저장
				}
				
			}
			
			
		} catch (FileNotFoundException e) {
			// TODO: handle exception
			e.printStackTrace();
			System.out.println("지정 경로에 해당 파일 없음");
		} catch (IOException e) {
			e.printStackTrace();
		}
		return msg;
	}
	
	
	
	
	 public static void main(String[] args) { 
		 Scanner in = new Scanner(System.in);
	 String word = in.nextLine(); 
	 filteredmsg = filtering(word);
	 System.out.println(filteredmsg); 
	 }
	 

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String chatName		= URLDecoder.decode(request.getParameter("chatName"), "UTF-8");
		String chatContent	= URLDecoder.decode(request.getParameter("chatContent"), "UTF-8");
		String chatIp	= URLDecoder.decode(request.getParameter("chatIp"), "UTF-8");
		System.out.println("dopost chatIp:" + chatIp);
		System.out.println("dopost:" + chatContent);
		
		if(chatName == null || chatName.equals("") || chatContent == null || chatContent.equals("") || chatIp == null || chatIp.equals("")) {
			response.getWriter().write("0");
		} else {
			filteredmsg = filtering(chatContent);
			System.out.println("dopost chatIp2:" + chatIp);
			System.out.println("filteredmsg:" + filteredmsg);
			response.getWriter().write(new ChatDAO().submit(chatName, filteredmsg, chatIp) + "");
		}
		
	}
	
	
	 

}
