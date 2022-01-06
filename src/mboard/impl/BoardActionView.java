package mboard.impl;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import mboard.dao.BoardDao;
import mboard.dao.CommentDao;
import mboard.dao.MemberDao;
import mboard.base.Action;
import mboard.vo.BoardVo;
import mboard.vo.CommentVo;
import mboard.vo.MemberVo;

public class BoardActionView implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 넘어온 정보처리
		
		// id가 일치 하는 댓글은 
		
			HttpSession session = request.getSession();
		
		// 넘어온 값 처리
			request.setCharacterEncoding("UTF-8");
		
				String     req_bnum     =   request.getParameter("bnum");
				session.setAttribute("req_bnum", req_bnum);
				
				String     req_id       =   request.getParameter("id");
				session.setAttribute("req_id", req_id); // 게시글 쓴 사람 id
				
				String     req_nickname =   request.getParameter("nickname");
				session.setAttribute("req_nickname", req_nickname);
				String     uid          =   (String) session.getAttribute("id");
				String     url          = "";
				
				System.out.println("게시글 번호 : " + req_bnum);
				System.out.println("작성자 id : " + req_id);
				System.out.println("작성자 닉네임 : " + req_nickname);
				System.out.println("로그인 id : " + uid);
				
				// db 조작 data 조회
				
				MemberDao       memberDao    =   new  MemberDao();
				List<MemberVo>  memberList   =   memberDao.getMemberlist();
				request.setAttribute("memberList", memberList);
				
				
				
				// bnum 해당 게시글 조회 : boardVo
				int           bnum       =  Integer.parseInt(req_bnum);
				BoardDao      boardDao   =  new BoardDao();
				BoardVo       boardVo    =  boardDao.getBoard( bnum );
				
				String        btext       =  boardVo.getBtext().replace("\n", "<br />");		
				boardVo.setBtext(btext);
				
				request.setAttribute("boardVo", boardVo);
				
				// bnum 해당 댓글 목록 조회 : commentVo
				bnum       =  Integer.parseInt(req_bnum);
				CommentDao      commentDao   =  new CommentDao();
				List<CommentVo>  commentList    =  commentDao.getCommentList(bnum);
				
				request.setAttribute("commentList", commentList);
				
				System.out.println("BoardActionView(commentVo) commentList : " + commentList);

				// bnum 해당 댓글수				
				
				int commentcount = commentDao.getCommentCount(bnum);
				System.out.println("댓글 수1 : "+ commentcount);
				request.setAttribute("commentcount", commentcount);
				System.out.println("댓글 수2 : "+ commentcount);
				
				// req_nickname  // 게시글 작성자 닉네임
				
				
				// 현재 멤버 정보  : memberVo		
//				MemberVo   memberVo   =  memberDao.getMember(id);
//				request.setAttribute("memberVo", memberVo);
				
				
				
				
				if(req_id.equals(uid)) {
					url = "/view/view.jsp";
				} else {
					url = "/view/view2.jsp";
				}
				
				// 이동
				String     path       =   url;
				request.getRequestDispatcher(path).forward(request, response);

	}

}
