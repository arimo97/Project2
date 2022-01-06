package mboard.impl;

import java.io.IOException;
import java.text.ParseException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mboard.base.Action;
import mboard.dao.MemDao;
import mboard.vo.MemViewVo;

public class CountryCovidStatusAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, ParseException {
		String id = request.getParameter("id");
		System.out.println("CountryCovidStatusAction id:" + id);
		/*
		 * //현재 회원 정보 MemDao memdao = new MemDao(); MemViewVo memViewVo =
		 * memdao.getMem(id); request.setAttribute("memViewVo", memViewVo);
		 */
		String         path     = "/view/CountryCovidStatus.jsp";

			
	
		request.getRequestDispatcher(path).forward(request, response);

	}

}
