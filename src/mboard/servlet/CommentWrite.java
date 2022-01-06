package mboard.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import mboard.dao.CommentDao;
import mboard.vo.CommentVo;

@WebServlet("/commentwrite")
public class CommentWrite extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		HttpSession session = request.getSession();
		
		// 넘어온 값 처리
		request.setCharacterEncoding("UTF-8");
		
		String     req_id       =   (String)session.getAttribute("req_id");
		
		String     req_nickname =   (String)session.getAttribute("req_nickname");
		
		String     uid          =   (String) session.getAttribute("id");
		
		
		
		System.out.println("CommentWrite getAttribute uid : " + uid);
		String   bnum   =  (String) session.getAttribute("req_bnum"); 
//		session.setAttribute("id", id);
//		session.setAttribute("bnum", bnum);
		System.out.println("CommentWrite impl id : " + uid);
		System.out.println("CommentWrite impl bnum : " + bnum);
		
		String     ctext     =  request.getParameter("ctext");
		session.setAttribute("ctext", ctext);
		System.out.println("CommentWrite impl ctext : " + ctext);
		String     nickname  =  (String) session.getAttribute("nickname");
//		session.setAttribute("nickname", nickname);
		System.out.println("CommentWrite impl nickname : " + nickname);
		System.out.println("CommentWrite impl req_nickname : " + req_nickname);
		
		CommentDao        commentDao   =  new  CommentDao();
		List<CommentVo>   commentList  =  commentDao.getCommentAllList();
//		getCommentAllList()로 댓글 전체 리스트 가져오기
		
		System.out.println( "CommentWrite(commentList) WRITE 1:" + commentList  );
		
		
		
		// db 저장
		CommentVo    commentVo   =   new  CommentVo();  
		System.out.println("update start commentVo : " + commentVo);
		commentVo.setBnum(Integer.parseInt(bnum));
		commentVo.setId(uid);
		commentVo.setCtext(ctext);
		commentVo.setNickname(nickname);
		commentDao.commentInsert(commentVo);
		System.out.println("update end commentVo : " + commentVo);
		request.setAttribute("commentList", commentList);
		System.out.println( "CommentWrite(commentList) WRITE 2:" + commentList  );
		System.out.println("write commentVo : "+ commentVo);
		
//		CommentVo    commentVo   =   new  CommentVo( Integer.parseInt(bnum), ctext, id, nickname );  
//		commentDao.commentInsert( commentVo );
//		request.setAttribute("commentList", commentList);
//		System.out.println( "CommentWrite(commentList) WRITE 2:" + commentList  );
//		System.out.println("write commentVo : "+ commentVo);
				
		// 이동 : 목록 보기
		String     path   =  "/mboard?cmd=VIEW&id=" + req_id + "&bnum=" + bnum + "&nickname" + req_nickname;
		request.getRequestDispatcher(path).forward(request, response);
		
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
