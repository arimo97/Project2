package test;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Scanner;

public class test {	public String Filtering(String msg) {
		FileInputStream fis;
		InputStreamReader isr;
		BufferedReader bReader;
		try {
			fis = new FileInputStream(new File("./src/text/fword_list.txt"));
			isr = new InputStreamReader(fis,"UTF-8");
			bReader = new BufferedReader(isr);
			String words = bReader.readLine();
		// 파일에서 한줄씩 읽어와서 words에 저장
			String[] warr = words.split("\\n");
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


	
}
