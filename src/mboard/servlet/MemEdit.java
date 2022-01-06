package mboard.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import mboard.dao.MemDao;

@WebServlet("/memedit")
public class MemEdit extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		String nickname = request.getParameter("nickname");
		String homeloc = request.getParameter("homeloc");
		String officeloc = request.getParameter("officeloc");
		String loc1name = request.getParameter("loc1name");
		String loc1 = request.getParameter("loc1");
		String loc2name = request.getParameter("loc2name");
		String loc2 = request.getParameter("loc2");
		String loc3name = request.getParameter("loc3name");
		String loc3 = request.getParameter("loc3");
		
		int loc = (int) session.getAttribute("locstatus");
		
		MemDao memDao = new MemDao();
		memDao.doUpdateInfo(id, pw);
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
