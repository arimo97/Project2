package mboard.impl;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mboard.base.Action;
import mboard.dao.MemDao;
import mboard.vo.MemViewVo;

public class CoronaDistanceAction implements Action {

	@Override
	public void execute(HttpServletRequest request,
			HttpServletResponse response) 
					throws ServletException, IOException {
		// TODO Auto-generated method stub
		String id = request.getParameter("id");
		
		System.out.println("CoronaDistanceAction:" + id);
		
		
		// 현재 메뉴 정보(메뉴아이디, 메뉴이름)
		MemDao memdao = new MemDao();
		MemViewVo          memViewVo = new MemViewVo();		
		/*
		 * memViewVo = memdao.getMem(id);
		 */		request.setAttribute("memViewVo", memViewVo);
				
		System.out.println("CoronaDistanceAction memViewVo2: " + memViewVo);
		
		String         path     = "/view/CoronaDistance.jsp";
		request.getRequestDispatcher(path).forward(request, response);	

	}
}



