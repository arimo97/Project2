package mboard.impl;

import java.io.IOException;
import java.text.ParseException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import mboard.base.Action;
import mboard.dao.MemDao;
import mboard.vo.MemViewVo;

public class CovidInfoFormAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, ParseException {
		
		HttpSession session = request.getSession();
		
		String id = (String) session.getAttribute("id");
		System.out.println("CovidInfoFormAction id:" + id);
		
		
		 //현재 회원 정보
//	 MemDao memdao = new MemDao(); 
//		 MemViewVo memViewVo = memdao.getMem(id);
//		 System.out.println("CovidInfoFormAction:" + memViewVo);
//		 request.setAttribute("memViewVo", memViewVo);
//		 request.setAttribute("id", id);
		 
		
		/* System.out.println("CovidInfoFormAction memViewVo:" + memViewVo); */
		
		//이동
		String path	= "/view/covidinfoform.jsp";
		request.getRequestDispatcher(path).forward(request, response);
		
		
		
	

	}

}
