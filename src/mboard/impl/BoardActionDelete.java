package mboard.impl;

import java.io.IOException;
import java.text.ParseException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mboard.dao.BoardDao;
import mboard.base.Action;

public class BoardActionDelete implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, ParseException {
		// 넘어온 값 처리
		String  bnum     =  request.getParameter("bnum");
		
		// data 조작
		BoardDao  boardDao  =  new  BoardDao();
		boardDao.boardDelete(bnum);
		
		
		// 이동
		Action  action  =  new BoardListAction();
		action.execute(request, response);
		
		// String  path  =  "/mboard?cmd=LIST&menu_id=" + menu_id;
		// request.getRequestDispatcher(path).forward(request, response);

	}

}
