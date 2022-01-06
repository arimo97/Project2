package mboard.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/gps")
public class GPS extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
			
			String sido = request.getParameter("sido");
			String sigungu = request.getParameter("sigungu");
			session.setAttribute("sido", sido);
			session.setAttribute("sigungu", sigungu);
			
			String lat = request.getParameter("lat");
			String lon = request.getParameter("lon");
			
			session.setAttribute("lat", lat);
			session.setAttribute("lon", lon);
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
