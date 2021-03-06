package mboard.impl;

import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import mboard.base.Action;
import mboard.dao.MemDao;
import mboard.vo.LocVo;
import mboard.vo.MemVo;

public class MemUpdateAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, ParseException {

		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		String email = request.getParameter("email");
		session.setAttribute("email", email);
		String nickname = request.getParameter("nickname");
		session.setAttribute("nickname", nickname);
		
		
		
		String homeloc = request.getParameter("homeloc");
		String officeloc = request.getParameter("officeloc");
		String loc1name = request.getParameter("loc1name");
		String loc1 = request.getParameter("loc1");
		String loc2name = request.getParameter("loc2name");
		String loc2 = request.getParameter("loc2");
		String loc3name = request.getParameter("loc3name");
		String loc3 = request.getParameter("loc3");
		
		String location = request.getParameter("location");
		System.out.println("MemEdit location  : " + location);
		
		int aftcnt = 0;
		
		MemDao memDao = new MemDao();
		
		try {
			
			switch (location){
			case "current": aftcnt = memDao.doEditInfo(new MemVo(id, pw, email, nickname, 0)); 
							session.setAttribute("locstatus", 0); break;
			case "home": aftcnt = memDao.doEditInfo(new MemVo(id, pw, email, nickname, 1));
							session.setAttribute("locstatus", 1); break;
			case "office": aftcnt = memDao.doEditInfo(new MemVo(id, pw, email, nickname, 2));
							session.setAttribute("locstatus", 2); break;
			case "loc1": aftcnt = memDao.doEditInfo(new MemVo(id, pw, email, nickname, 3));
							session.setAttribute("locstatus", 3); break;
			case "loc2": aftcnt = memDao.doEditInfo(new MemVo(id, pw, email, nickname, 4));
							session.setAttribute("locstatus", 4); break;
			case "loc3": aftcnt = memDao.doEditInfo(new MemVo(id, pw, email, nickname, 5));
							session.setAttribute("locstatus", 5); break;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} 
		
		memDao.doDeleteLoc(id);
		
		if (!homeloc.isEmpty())
			aftcnt = memDao.doRegLoc(id, "home", homeloc);
		if (!officeloc.isEmpty())
			aftcnt = memDao.doRegLoc(id, "office", officeloc);
		if (!loc1.isEmpty())
			aftcnt = memDao.doRegLoc(id, loc1name, loc1);
		if (!loc2.isEmpty())
			aftcnt = memDao.doRegLoc(id, loc2name, loc2);
		if (!loc3.isEmpty())
			aftcnt = memDao.doRegLoc(id, loc3name, loc3);
		
		int loc = (int) session.getAttribute("locstatus");
		
		List<LocVo> list = memDao.getLoc(id);
		LocVo home = null;
		LocVo office = null;
		List<LocVo> extraloc = new ArrayList<LocVo>();
		
		for (int i = 0; i < list.size(); i++) {
			if(list.get(i).getName().equals("home"))
				home = list.get(i);
			else if (list.get(i).getName().equals("office"))
				office = list.get(i);
			else {
				extraloc.add(list.get(i));
			}
		}
		
		switch (loc) {
		case 0: break; 
		case 1: String[] homeloc0 = home.getAddress().split(" ");
				session.setAttribute("sido", homeloc0[0]);
				session.setAttribute("sigungu", homeloc0[1]);
				session.setAttribute("selectedloc", home.getAddress());
				break;
		case 2: String[] officeloc0 = office.getAddress().split(" ");
				session.setAttribute("sido", officeloc0[0]);
				session.setAttribute("sigungu", officeloc0[1]);
				session.setAttribute("selectedloc", office.getAddress());
				break;
		case 3: String[] loc1_0 = extraloc.get(0).getAddress().split(" ");
				session.setAttribute("sido", loc1_0[0]);
				session.setAttribute("sigungu", loc1_0[1]);
				session.setAttribute("selectedloc", extraloc.get(0).getAddress());
				break;
		case 4: String[] loc2_0 = extraloc.get(1).getAddress().split(" ");
				session.setAttribute("sido", loc2_0[0]);
				session.setAttribute("sigungu", loc2_0[1]);
				session.setAttribute("selectedloc", extraloc.get(1).getAddress());
				break;
		case 5: String[] loc3_0 = extraloc.get(2).getAddress().split(" ");
				session.setAttribute("sido", loc3_0[0]);
				session.setAttribute("sigungu", loc3_0[1]);
				session.setAttribute("selectedloc", extraloc.get(2).getAddress());
				break;
		}
		
		if (aftcnt == 0) {
			String path = "/mboard?cmd=ERROR";
			response.sendRedirect(path);
		} else {
			String path = "/view/Home.jsp";

			response.sendRedirect(path);
		}
	}

}
/*
ID
PASSWORD
EMAIL
NICKNAME
LOCSTATUS

		String homeloc = request.getParameter("homeloc");
		String officeloc = request.getParameter("officeloc");
		String loc1name = request.getParameter("loc1name");
		String loc1 = request.getParameter("loc1");
		String loc2name = request.getParameter("loc2name");
		String loc2 = request.getParameter("loc2");
		String loc3name = request.getParameter("loc3name");
		String loc3 = request.getParameter("loc3");
		
		String location = request.getParameter("location");
		
		MemDao memDao = new MemDao();
		int aftcnt = 0;
		
		switch (location){
		case "current": aftcnt = memDao.doRegInfo(new MemVo(id, pw, email, nickname, 0)); break;
		case "home": aftcnt = memDao.doRegInfo(new MemVo(id, pw, email, nickname, 1)); break;
		case "office": aftcnt = memDao.doRegInfo(new MemVo(id, pw, email, nickname, 2)); break;
		case "loc1": aftcnt = memDao.doRegInfo(new MemVo(id, pw, email, nickname, 3)); break;
		case "loc2": aftcnt = memDao.doRegInfo(new MemVo(id, pw, email, nickname, 4)); break;
		case "loc3": aftcnt = memDao.doRegInfo(new MemVo(id, pw, email, nickname, 5)); break;
		}
		
		if (!homeloc.isEmpty())
			aftcnt = memDao.doRegLoc(id, "home", homeloc);
		if (!officeloc.isEmpty())
			aftcnt = memDao.doRegLoc(id, "office", officeloc);
		if (!loc1.isEmpty())
			aftcnt = memDao.doRegLoc(id, loc1name, loc1);
		if (!loc2.isEmpty())
			aftcnt = memDao.doRegLoc(id, loc2name, loc2);
		if (!loc3.isEmpty())
			aftcnt = memDao.doRegLoc(id, loc3name, loc3);


*/
