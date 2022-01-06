package mboard.impl;

import java.io.IOException;
import java.io.PrintWriter;
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

public class CommentOptionAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, ParseException {
			HttpSession session = request.getSession();
		
		
		request.setCharacterEncoding("UTF-8");

		String uid   = (String) session.getAttribute("id"); // 로그인한 아이디
		System.out.println("option uid : " + uid);
		
		String cid   = request.getParameter("cid");
		
//		String cid   = (String) session.getAttribute("cid"); // 댓글 쓴 id
		session.setAttribute("cid", cid);
		System.out.println("option cid : " + cid);
		
		String scnum = request.getParameter("cnum"); // 댓글 넘버
		session.setAttribute("scnum", scnum); // string 인 상태로 담아야함
		int    cnum  = Integer.parseInt(scnum);
		System.out.println("option cnum : " + cnum);
		
		String req_bnum = (String) session.getAttribute("req_bnum"); // 댓글이 달려있는 게시판 번호
		int    bnum  = Integer.parseInt(req_bnum);
		System.out.println("option bnum : " + bnum);
		
		String bid = (String) session.getAttribute("req_id"); // 댓글이 달려있는 게시판 쓴 아이디
		System.out.println("option bid : " + bid);
		
		String ctext = request.getParameter("ctext"); // 댓글 넘버
		System.out.println("option ctext : " + ctext);
		session.setAttribute("ctext", ctext);
		
		
		//String url   = "";
		
		
		// bnum 해당 게시글 조회 : boardVo
				// int           bnum       =  Integer.parseInt(req_bnum);
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
		
		
		
		if(uid.equals(cid)) {
			response.setContentType("text/html; charset=UTF-8"); 
			PrintWriter writer = response.getWriter(); 
			writer.println("<script> location.href='/view/Option1.jsp';</script>"); 
			//writer.println("<script>alert('본인 댓글입니다.'); location.href='/view/Option1.jsp';</script>"); 
			writer.close();
			//url="/view/Option1.jsp";
		} else if (uid.equals(bid)) {
			response.setContentType("text/html; charset=UTF-8"); 
			PrintWriter writer = response.getWriter(); 
			writer.println("<script> location.href='/view/Option2.jsp';</script>"); 
			//writer.println("<script>alert('본인 게시글의 댓글 입니다.'); location.href='/view/Option2.jsp';</script>"); 
			writer.close();
			//url="/view/Option2.jsp";
		} else {
			response.setContentType("text/html; charset=UTF-8"); 
			PrintWriter writer = response.getWriter(); 
			writer.println("<script>alert('접근 권한이 없습니다.'); location.href='/mboard?cmd=VIEW&bnum=" + bnum + "&id=" + bid + "';</script>"); 
			writer.close();
			//url="/view/view2.jsp";
		}	
		/*
		 * String path = url; request.getRequestDispatcher(path).forward(request,
		 * response);
		 */
		
	}

}
