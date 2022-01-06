package mboard.impl;

import java.io.IOException;
import java.text.ParseException;
import java.util.Vector;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mboard.base.Action;
import mboard.dao.CovidInfoDao;
import mboard.dao.MemDao;
import mboard.vo.CovidInfoVo;
import mboard.vo.MemViewVo;

public class CovidViewAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, ParseException {
		
		String id	= request.getParameter("id");
		String num	= request.getParameter("num");
		/* int num = Integer.parseInt(strnum); */
		System.out.println("CovidViewAction: " + id + "," + num);
		
		
		//db 사용 data 조회
		CovidInfoDao covidInfoDao	=	new CovidInfoDao();
		CovidInfoVo covidInfoVo		= covidInfoDao.getUser(id, num);
		request.setAttribute("covidInfoVo", covidInfoVo);
		System.out.println("CovidViewAction covidInfoVo:" + covidInfoVo);

	

		/*
		 * //현재 id MemDao memdao = new MemDao(); MemViewVo memViewVo =
		 * memdao.getMem(id); request.setAttribute("memViewVo", memViewVo);
		 * System.out.println("CovidViewAction memViewVo:" + memViewVo);
		 */
		
		
		
		//이동
		String path = "/view/covidinfoview.jsp";
		request.getRequestDispatcher(path).forward(request, response);
		
		
		
		

	}

}
