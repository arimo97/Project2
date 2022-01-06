package mboard.impl;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mboard.base.Action;
import mboard.dao.BoardDao;
import mboard.vo.BoardVo;

public class BoardActionWrite implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 넘어온 값 처리
		request.setCharacterEncoding("UTF-8");
		
		String   id     =   request.getParameter("id"); 
		
		System.out.println(id);
		
		BoardDao        boardDao   =  new  BoardDao();
		List<BoardVo>   boardList  =  boardDao.getBoardList();		
		
		System.out.println( "BoardActionList(boardList) WRITE 1:" + boardList  );
		
		String     btitle    =  request.getParameter("btitle");
		String     btext     =  request.getParameter("btext");
		String     nickname  =  request.getParameter("nickname");
		
		// db 저장
		BoardVo    boardVo   =   new  BoardVo( id, btitle, btext, nickname );  
		boardDao.boardInsert( boardVo );
		request.setAttribute("boardList", boardList);
		System.out.println( "BoardActionList(boardList) WRITE 2:" + boardList  );
		System.out.println("write boardVo : "+ boardVo);
				
		
		// 이동 : 목록 보기
		String     path   =  "/mboard?cmd=BOARD&id=" + id;
		request.getRequestDispatcher(path).forward(request, response);
		

	}

}






