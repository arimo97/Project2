package mboard.impl;

import java.io.IOException;
import java.text.ParseException;
import java.util.Vector;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mboard.base.Action;
import mboard.dao.LoginDao;
import mboard.dao.MemDao;
import mboard.dao.VaccineStaticsDao;
import mboard.vo.MemViewVo;

public class VaccineStaticsAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, ParseException {
		// TODO Auto-generated method stub
		// TODO Auto-generated method stub
				
				// 목록조회
				//MenuDao        menuDao   =  new MenuDao();
				//List<MenuVo>   menuList  =  menuDao.getMenuList();
				//System.out.println("MenuActionList:" + menuList);
				
				//request.setAttribute("menuList", menuList);
				
				//request.getRequestDispatcher(path).forward(request, response);
				LoginDao logindao =  new LoginDao();
				
				
				
				
				
				
				System.out.println("VaccineStaticsAction LoginDao:" + LoginDao.getId());
				System.out.println("VaccineStaticsAction LoginDao:" + LoginDao.getSido());
				System.out.println("VaccineStaticsAction LoginDao:" + LoginDao.getSigungu());
				
				
				String id	= request.getParameter("id");
				
				System.out.println("VaccineStaticsAction id:" + id);
				
				
				/*
				 * // 현재 메뉴 정보(메뉴아이디, 메뉴이름) MemDao memdao = new MemDao(); MemViewVo memViewVo =
				 * new MemViewVo(); memViewVo = memdao.getMem(id);
				 * request.setAttribute("memViewVo", memViewVo);
				 * System.out.println(memViewVo.getSido()); memViewVo.getSido();
				 * VaccineStaticsDao vDao = new VaccineStaticsDao(); Vector VaccineStatics =
				 * vDao.VaccineDao();
				 */
				
				/*
				 * System.out.println("VaccineStaticsAction:" + VaccineStatics);
				 * request.setAttribute("VaccineStatics", VaccineStatics);
				 */
				String         path     = "/view/VaccineStatics.jsp";
				request.getRequestDispatcher(path).forward(request, response);
				
				
			}
	}


