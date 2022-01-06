package mboard.impl;

import java.io.IOException;
import java.text.ParseException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mboard.base.Action;
import mboard.dao.MemDao;
import mboard.vo.MemVo;

public class MemRegstraionAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, ParseException {
		
		request.setCharacterEncoding("UTF-8");
		
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		String email = request.getParameter("email");
		String nickname = request.getParameter("nickname");
		
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

		if (aftcnt == 0) {
			String path = "/mboard?cmd=ERROR";
			response.sendRedirect(path);
		} else {
			String path = "/view/login.jsp";

			response.sendRedirect(path);
		}
	}
	
}
