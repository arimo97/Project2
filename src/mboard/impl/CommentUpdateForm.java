package mboard.impl;

import java.io.IOException;
import java.text.ParseException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import mboard.base.Action;
import mboard.dao.CommentDao;
import mboard.vo.CommentVo;

public class CommentUpdateForm  implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, ParseException {

		HttpSession session = request.getSession();
		
		
		request.setCharacterEncoding("UTF-8");

		String uid   = (String) session.getAttribute("id"); // 로그인한 아이디
		String cid   = request.getParameter("cid"); // 댓글 쓴 id
		String scnum = request.getParameter("cnum");
		String url   = "";
		
		
		
		//System.out.println();
		session.setAttribute("cid", cid);
		session.setAttribute("scnum", scnum);
		
		int    cnum  = Integer.parseInt(scnum);
		
		CommentDao commentDao = new CommentDao();
		CommentVo  commentVo  = commentDao.getComment(cnum);
		session.setAttribute("commentVo", commentVo);
		System.out.println("CommentUpdateForm commentVo : " + commentVo);
		
        if(uid.equals(cid)) {
			url="/view/CommentOption.jsp";
		} else {
			url="";
		}
		
		
		String  path  =  url;
		request.getRequestDispatcher(path).forward(request, response);
		
	}

}
