package mboard.impl;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mboard.dao.BoardDao;
import mboard.dao.MemberDao;
import mboard.base.Action;
import mboard.vo.BoardVo;
import mboard.vo.MemberVo;

public class BoardActionUpdateForm implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 넘어온 정보
		String  bnum       =  request.getParameter("bnum");
		String  uid        =  request.getParameter("uid");
		String  unickname  =  request.getParameter("unickname");

		// data 조작
		// menus.jsp
		MemberDao  memberDao       =  new MemberDao();
//		List<MemberVo> memberList  = memberDao.getMemberList();
//		request.setAttribute("memberList", memberList);
		
		// 수정할 boardVo 조회 (bnum)
		BoardDao  boardDao  =  new BoardDao();
		BoardVo   boardVo   =  boardDao.getBoard(Integer.parseInt(bnum));
		System.out.println("update bnum : " + bnum);
		System.out.println("update boardVo : " + boardVo);
		request.setAttribute("boardVo", boardVo);
		
		// 현재 멤버 정보
		MemberVo  memberVo  =  memberDao.getMember(uid);
		request.setAttribute("memberVo", memberVo);
		
		// 이동
		String  path  =  "/view/boardupdate.jsp";
		request.getRequestDispatcher(path).forward(request, response);

	}

}
