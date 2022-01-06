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
import mboard.vo.BoardVo;
import mboard.vo.CommentVo;

public class CommentDelete implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, ParseException {
		
		HttpSession session = request.getSession();
		
		// 넘어온 값 처리 (ctext)
				request.setCharacterEncoding("UTF-8");

				String   req_bnum  =  (String) session.getAttribute("req_bnum");
				System.out.println("CommentUpdate req_bnum : " + req_bnum);
				
				int      bnum   =  Integer.parseInt(req_bnum);
				System.out.println("CommentUpdate bnum : " + bnum);
				
				
				System.out.println("Commentdelete impl 시작");
				
				String   scnum  =  request.getParameter("cnum");
				System.out.println("CommentUpdate scnum : " + scnum);
				
				int      cnum   =  Integer.parseInt(scnum);
				System.out.println("CommentUpdate cnum : " + cnum);
				
				String   req_id =  (String) session.getAttribute("req_id");
				System.out.println("CommentUpdate req_id : " + req_id);

				String   uid    =  (String) session.getAttribute("id");
				System.out.println("CommentUpdate uid : " + uid);
				
				
				
				String   url    = "";
				
				// data 조작
				CommentDao  commentDao  =  new  CommentDao();
				commentDao.commentDelete(cnum);
				
				// bnum 해당 게시글 조회 : boardVo
				// int           bnum       =  Integer.parseInt(req_bnum);
				BoardDao      boardDao   =  new BoardDao();
				BoardVo       boardVo    =  boardDao.getBoard( bnum );	
				
				request.setAttribute("boardVo", boardVo);
				
				// bnum 해당 댓글 목록 조회 : commentVo
				bnum       =  Integer.parseInt(req_bnum);
				//CommentDao      commentDao   =  new CommentDao();
				List<CommentVo>  commentList    =  commentDao.getCommentList(bnum);
				
				request.setAttribute("commentList", commentList);
				
				System.out.println("BoardActionView(commentVo) commentList : " + commentList);
				
				
				
				// 이동
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
