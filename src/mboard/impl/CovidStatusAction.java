package mboard.impl;

import java.io.IOException;
import java.text.ParseException;
import java.util.Vector;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.parsers.ParserConfigurationException;

import org.xml.sax.SAXException;

import mboard.base.Action;
// import mboard.dao.CovidStatusDao;
import mboard.dao.LoginDao;
import mboard.dao.MemDao;
import mboard.dao.VaccineStaticsDao;
import mboard.vo.MemViewVo;

public class CovidStatusAction implements Action {

	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, ParseException {
				String id = request.getParameter("id");
				System.out.println("CovidInfoFormAction id:" + id);
				
				/*
				 * //현재 회원 정보 MemDao memdao = new MemDao(); MemViewVo memViewVo =
				 * memdao.getMem(id); request.setAttribute("memViewVo", memViewVo);
				 */
				String         path     = "/view/CovidStatusview.jsp";

					
			
				request.getRequestDispatcher(path).forward(request, response);
				
				
			}

}
