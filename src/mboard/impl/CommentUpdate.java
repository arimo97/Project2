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
import mboard.vo.MemberVo;

public class CommentUpdate implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		
		// 넘어온 값 처리 (ctext)
		request.setCharacterEncoding("UTF-8");

		System.out.println("CommentUpdate impl 시작");
		
		String   ctext  =  request.getParameter("ctext");
		System.out.println("CommentUpdate ctext : " + ctext);
		
		String   req_bnum  =  (String) session.getAttribute("req_bnum");	
		int      bnum   =  Integer.parseInt(req_bnum);
		System.out.println("CommentUpdate bnum : " + bnum);
		
		String   scnum  =  (String) session.getAttribute("scnum");		
		System.out.println("CommentUpdate cnum : " + scnum);
		int      cnum   =  Integer.parseInt(scnum);
		System.out.println("CommentUpdate cnum : " + cnum);
		
		String   req_id =  (String) session.getAttribute("req_id");
		System.out.println("CommentUpdate req_id : " + req_id);

		String   uid    =  (String) session.getAttribute("id");
		System.out.println("CommentUpdate uid : " + uid);
		
		String   unickname    =  (String) session.getAttribute("nickname");
		System.out.println("CommentUpdate unickname : " + unickname);
		
		
		
		String   url    = "";
		
		
		// data 조작
		CommentDao  commentDao  = new CommentDao();
		
		CommentVo commentVo     = new CommentVo();
		
		
		System.out.println("comment update 시작 : " + commentVo);
		
//		commentVo.setBnum(bnum);		
//		commentVo.setId(uid);
		commentVo.setCtext(ctext);
		commentVo.setCnum(cnum);
//		commentVo.setNickname(unickname);
		
		commentDao.commentUpdate(commentVo);
		
		System.out.println("comment update 끝 : " + commentVo);
		request.setAttribute("commentVo", commentVo);
		
		
		MemberDao       memberDao    =   new  MemberDao();
		List<MemberVo>  memberList   =   memberDao.getMemberlist();
		request.setAttribute("memberList", memberList);
		
//		여기 수정하기
		
		
		
		// bnum 해당 게시글 조회 : boardVo
		// int           bnum       =  Integer.parseInt(req_bnum);
		BoardDao      boardDao   =  new BoardDao();
		BoardVo       boardVo    =  boardDao.getBoard( bnum );
		
		String        btext       =  boardVo.getBtext().replace("\n", "<br />");		
		boardVo.setBtext(btext);
		
		request.setAttribute("boardVo", boardVo);
		
		// bnum 해당 댓글 목록 조회 : commentVo
		bnum       =  Integer.parseInt(req_bnum);
		//CommentDao      commentDao   =  new CommentDao();
		List<CommentVo>  commentList    =  commentDao.getCommentList(bnum);
		
		request.setAttribute("commentList", commentList);
		
		System.out.println("BoardActionView(commentVo) commentList : " + commentList);
		
		
		
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
