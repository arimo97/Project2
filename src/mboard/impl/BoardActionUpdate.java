package mboard.impl;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import mboard.dao.BoardDao;
import mboard.base.Action;
import mboard.vo.BoardVo;

public class BoardActionUpdate implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		
		// 넘어온 값 처리 (bnum, id, btitle, btext)
		request.setCharacterEncoding("UTF-8");
		String   sbnum     =  request.getParameter("bnum");
		int      bnum      =  Integer.parseInt(sbnum);
		String   id        =  (String) session.getAttribute("id");
		String   btitle    =  request.getParameter("btitle");
		String   btext     =  request.getParameter("btext");
		String   nickname  =  (String) session.getAttribute("nickname");
		
		// data 조작
		BoardDao  boardDao  = new BoardDao();
		
		BoardVo   boardVo   = new BoardVo();
		
//		boardDao.getBoard(bnum);
		
		
		
		System.out.println("update start : " + boardVo);
		
		
		boardVo.setBtitle(btitle);
		System.out.println("btitle : " + btitle);
		
		boardVo.setBtext(btext);
		System.out.println("btext : " + btext);
		
//		boardVo.setNickname(nickname);
//		System.out.println("nickname : " + nickname);
		
		boardVo.setBnum(bnum);
		
		boardVo.setId(id);
		System.out.println("id : " + id);
		
		boardDao.boardUpdate(boardVo);
		
		
		
		
		
		System.out.println("update end : " + boardVo);
		
		// 이동
		String  path  =  "/mboard?cmd=BOARD&id=" + id;
		request.getRequestDispatcher(path).forward(request, response);

	}

}
