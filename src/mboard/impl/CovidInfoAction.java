package mboard.impl;

import java.io.IOException;
import java.text.ParseException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mboard.base.Action;
import mboard.dao.CovidInfoDao;
import mboard.vo.CovidInfoVo;

public class CovidInfoAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, ParseException {
	
		// 넘어온 값 처리
		request.setCharacterEncoding("UTF-8");
		String     id  				=  request.getParameter("id");
		String     vaccineortest  	=  request.getParameter("vaccineortest");
		String     vaccine  		=  request.getParameter("vaccine");
		String     test_date 		=  request.getParameter("test_date");
		String     test_hospital	=  request.getParameter("test_hospital");
		String     test_result		=  request.getParameter("test_result");
		String     symptom			=  request.getParameter("symptom");
		
		// db 저장
		CovidInfoDao   covidInfoDao  =   new  CovidInfoDao();
		CovidInfoVo    covidInfoVo   =   new  CovidInfoVo( id, vaccineortest, vaccine, test_date, test_hospital, test_result, symptom );
		covidInfoDao.covidinfoInsert( covidInfoVo );
		System.out.println("CovidInfoAction:" + covidInfoVo);
				
		
		// 이동 : 목록 보기
		
		String path = "/mboard?cmd=COVIDINFOLIST&id=" + id;
		request.getRequestDispatcher(path).forward(request, response);
		
		

	}

}
