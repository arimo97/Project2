package mboard.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import mboard.dao.MemDao;

@WebServlet("/regcheck")
public class RegCheck extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		HttpSession session = request.getSession();
		
		String id = request.getParameter("id");
		String nickname = request.getParameter("nickname");
		String btn = request.getParameter("btn");
		String regex1 = "^[a-z0-9A-z-_]{4,20}$";
		String regex2 = "^{4,20}$";
		String existnick = (String) session.getAttribute("nickname");
		
		MemDao memDao = new MemDao();
		PrintWriter out = response.getWriter();
		// 아이디 중복체크---------------------------------------------------
		if (btn.equals("id")) {
			if(id.isEmpty()) {
				String html = "<b class='red'>아이디란을 채워 주세요.</b>";
				out.print(html);
				out.close();
			} else {
				if(Pattern.matches(regex1, id)) {
					boolean existId = memDao.verifyId(id);
					if (existId) {
						String html = "<b class='red'>사용 불가능한 아이디 입니다.</b>";
						out.print(html);
						out.close();
					} else {
						String html = "<b class='green'>사용 가능한 아이디 입니다.</b>";
						response.setContentType("text/html;charset=UTF-8");
						out.print(html);
						out.close();
					} 
				} else {
					String html = "<b class='red'>아이디는 4-20자 영문, 숫자 조합입니다.</b>";
					out.print(html);
					out.close();
					}
				}
			}
		
		// 닉네임 중복체크---------------------------------------------------
		
		if (nickname.equals(existnick)) {
			String html = "<b class='green'>현재 닉네임을 유지합니다.</b>";
			out.print(html);
			out.close();
		}
		
		if (btn.equals("nick")) {
			if(nickname.isEmpty()) {
				String html = "<b class='red'>닉네임란을 채워 주세요.</b>";
				out.print(html);
				out.close();
			} else {
				boolean existNick = memDao.verifyNick(nickname);
				if (existNick) {
					String html = "<b class='red'>사용 불가능한 닉네임 입니다.</b>";
					out.print(html);
					out.close();
				} else {
					String html = "<b class='green'>사용 가능한 닉네임 입니다.</b>";
					out.print(html);
					out.close();
				}
			}
		}
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
