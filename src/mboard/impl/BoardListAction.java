package mboard.impl;

import java.io.IOException;
import java.text.ParseException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import mboard.base.Action;
import mboard.dao.BoardDao;
import mboard.dao.CommentDao;
import mboard.dao.MemberDao;
import mboard.vo.BoardVo;
import mboard.vo.CommentVo;

public class BoardListAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, ParseException {
		// TODO Auto-generated method stub
	HttpSession session = request.getSession();
		
		request.setCharacterEncoding("UTF-8");
		String uid        = (String) session.getAttribute("id");
		String unickname  = (String) session.getAttribute("nickname");
		
		
		System.out.println("BoardListAction uid : " + uid);
		System.out.println("BoardListAction unickname : " + unickname);

		// 조회수 높은 글 위로 올리기
				BoardDao        boardDao   =  new  BoardDao();
				List<BoardVo>   boardupList  =  boardDao.getBoardUpList();		
				request.setAttribute("boardupList", boardupList);
				System.out.println( "BoardActionList boardupList :" + boardupList  );
		
		// 게시물 조회(board) : BoardList			
		// BoardDao        boardDao   =  new  BoardDao();
		List<BoardVo>   boardList  =  boardDao.getBoardList();		
		request.setAttribute("boardList", boardList);
		System.out.println( "BoardActionList(boardList) list :" + boardList  );
		
		// 전체 댓글 조회
		
		// bnum       =  Integer.parseInt(req_bnum);
		CommentDao      commentDao   =  new CommentDao();
		List<CommentVo>  commentList    =  commentDao.getCommentAllList();
		
		request.setAttribute("commentList", commentList);
		// 인덱스에서 누락된 IN 또는 OUT 매개변수:: 2 -- 에러 뜸
		System.out.println("BoardActionList(commentVo) bnum 댓글 목록 조회 : " + commentList);
		
		// 댓글 수 확인 댓글 조회
//		CommentDao        commentDao   =  new  CommentDao();
//		List<CommentVo>   commentList  =  commentDao.getCommentList(bnum);		
//		request.setAttribute("commentList", commentList);
//		System.out.println( "BoardActionList(commentList) list :" + commentList  );
		
		
		
		// 현재 메뉴 정보(메뉴아이디, 메뉴이름)
//		MemberDao   memberDao = new MemberDao();
//		ArrayList<MemberVo>    memberVo     =  memberDao.getMemberlist(id);
//		request.setAttribute("memberVo", memberVo);
		
		
		String   path         =   "/view/boardlist.jsp";  
		request.getRequestDispatcher(path).forward(request, response);
		
		
	}

}
