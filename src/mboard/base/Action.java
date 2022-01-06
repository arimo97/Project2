package mboard.base;

import java.io.IOException;
import java.text.ParseException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//@FunctionalInterface : java 1.8 추가된 annotation
//해당 인터페이스는 한개의 메소드만 가질 수 있다.
//메소드 2개 이상이면 에러 발생 - 다른 사람이 인터페이스 수정방지
//람다식에 사용하는 인터페이스는 무조건 @FunctionalInterface로 구현 
@FunctionalInterface
public interface Action {
	
	void   execute( HttpServletRequest request, 
			HttpServletResponse response )
		throws  ServletException, IOException, ParseException;
	
}







