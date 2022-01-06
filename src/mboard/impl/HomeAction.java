package mboard.impl;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mboard.base.Action;
import mboard.dao.LoginDao;
import mboard.dao.MemDao;
import mboard.vo.MemViewVo;

public class HomeAction implements Action {
	private static String id;
	private static String sido;
	private static String sigungu;
	
	@Override
	public void execute(HttpServletRequest request,
			HttpServletResponse response) 
					throws ServletException, IOException {
	
		
		
		String id 	= request.getParameter("id");
		System.out.println("HomeAction corona_id:" +  id);
		
		
		/*
		 * // 현재 회원 정보(메뉴아이디, 메뉴이름) MemDao memdao = new MemDao(); MemViewVo memViewVo =
		 * new MemViewVo(); memViewVo = memdao.getMem(id);
		 * request.setAttribute("memViewVo", memViewVo);
		 */
				
		/* System.out.println("HomeAction memViewVogetid: " + memViewVo.getId()); */		
		
		
	
		
		
		
		id	= LoginDao.getId();
		sido = LoginDao.getSido();
		sigungu = LoginDao.getSigungu();
		
		System.out.println("HomeAction id: " + id);
		System.out.println("HomeAction sido: " + sido);
		System.out.println("HomeAction sigungu: " + sigungu);
		
		
	
		
	
		//이동
		String         path     = "/view/Home.jsp";
		request.getRequestDispatcher(path).forward(request, response);	
	}


}
