package mboard.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import mboard.dao.GeoTrans;
import mboard.vo.GeoVo;

@WebServlet("/geoconvert")
public class GeoConvert extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		Double lat = (Double) session.getAttribute("lat"); 
		Double lon = (Double) session.getAttribute("lon");
		
		
		GeoVo in_pt = new GeoVo(lon, lat);
		GeoVo tm_pt = GeoTrans.convert(GeoTrans.GEO, GeoTrans.TM, in_pt);
		System.out.println("tm : xTM=" + tm_pt.getX() + ", yTM=" + tm_pt.getY());

		int[] coords = {(int)(tm_pt.getX() * 2.5), (int)(tm_pt.getY() * 2.5)};
		PrintWriter out = response.getWriter();
		out.print(coords);
		out.close();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
