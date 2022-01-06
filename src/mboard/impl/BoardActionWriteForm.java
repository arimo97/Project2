package mboard.impl;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import mboard.base.Action;
import mboard.dao.BoardDao;
import mboard.dao.MemberDao;
import mboard.vo.BoardVo;
import mboard.vo.MemberVo;

public class BoardActionWriteForm implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
//		// 메뉴리스트 menuList
////		MenuDao       menuDao    =   new  MenuDao();
////		List<MenuVo>  menuList   =   menuDao.getMenuList();
////		request.setAttribute("menuList", menuList);
//		
//		// menuVo : 현재 메뉴정보
////		MenuVo    menuVo     =   menuDao.getMenu(menu_id);
////		request.setAttribute("menuVo", menuVo);
//		
//		
		MemberDao       memberDao    =   new  MemberDao();
		List<MemberVo>  memberList   =   memberDao.getMemberlist();
		request.setAttribute("memberList", memberList);
		
		ArrayList<MemberVo>    memberVo     =   memberDao.getMemberlist();
		request.setAttribute("memberVo", memberVo);
		
		BoardDao        boardDao     =   new  BoardDao();
		List<BoardVo>   boardList    =   boardDao.getBoardList();
		request.setAttribute("boardList", boardList);
		
		// 이동
		String     path      =   "/view/boardwrite.jsp";
		request.getRequestDispatcher(path).forward(request, response);
		

	}

}











