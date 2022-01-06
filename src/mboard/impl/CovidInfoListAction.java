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
import mboard.vo.MemViewVo;

public class CovidInfoListAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, ParseException {
		
		String id	=	request.getParameter("id");
		
		
		/*
		 * //현재 회원 정보 MemDao memdao = new MemDao(); MemViewVo memViewVo =
		 * memdao.getMem(id); request.setAttribute("memViewVo", memViewVo);
		 */
		/* System.out.println("CovidInfoListAction memViewVo:" + memViewVo ); */
		
		CovidInfoDao uDao = new CovidInfoDao(); 
		Vector covidinfoiList = uDao.getMemList(id);
		
		
		
		System.out.println("CovidInfoListAction Vector: " + covidinfoiList);
		request.setAttribute("covidinfoiList", covidinfoiList);


		String         path     = "/view/covidinfolist.jsp";
		request.getRequestDispatcher(path).forward(request, response);	
		
		/*
		 * MenuDao menuDao = new MenuDao(); List<MenuVo> menuList =
		 * menuDao.getMenuList();
		 */

	}

}
