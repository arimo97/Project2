package mboard.impl;

import java.io.IOException;
import java.text.ParseException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mboard.base.Action;
import mboard.dao.CovidInfoDao;
import mboard.vo.CovidInfoVo;

public class CovidDeleteAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, ParseException {
		String id	= request.getParameter("id");
		String num	= request.getParameter("num");
		
		//db 사용 data 조회
		CovidInfoDao covidInfoDao	=	new CovidInfoDao();
		CovidInfoVo covidInfoVo		=	new CovidInfoVo(id, num); 
		covidInfoDao.deleteUser(covidInfoVo);
		
		
		request.setAttribute("covidInfoVo", covidInfoVo);
		System.out.println("CovidViewAction covidInfoVo:" + covidInfoVo);
		
		
		//이동
		String path = "/mboard?cmd=COVIDINFOLIST&id=" + id;
		request.getRequestDispatcher(path).forward(request, response);
	}

}
