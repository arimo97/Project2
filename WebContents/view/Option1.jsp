<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib  prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib  prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
		String uid    = (String)session.getAttribute("id");
		String req_id = (String)session.getAttribute("req_id");
		String req_bnum = (String)session.getAttribute("req_bnum");
		String req_nickname = (String)session.getAttribute("req_nickname");
		String ctext  = (String)session.getAttribute("ctext"); // commentoptionaction에서 담음
		String cid    = (String)session.getAttribute("cid");
		String scnum  = (String)session.getAttribute("scnum");
		/* int cnum      = Integer.parseInt("scnum"); */

%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="/css/prj2.css">
<title>Insert title here</title>
<style>
	#upcomment   td:nth-of-type(1) {width:100px;}
	#upcomment   td:nth-of-type(2) {width:700px;}
	
	#upcomment   td:nth-of-type(2) {text-align:left; padding-left:10px;}
	
	textarea { height: 50px; width: 680px; margin: 10px; }
	input    { width: 680px; }
</style>
<script>
  window.onload = function() {
	var form = document.querySelector('form');
	form.addEventListener('submit', function(e) {
		console.log(e);
		var btn = e.submitter; // 이벤트를 발생시킨 버튼
		// alert(btn.id);
		switch(btn.id) {
 		case "btnCommentUpdate": // 수정
			break;
			
 		case "btnCommentDelete": // 삭제
 			e.preventDefault(); // submit 취소
			e.stopPropagation();
 			
			location.href = "/mboard?cmd=COMMENTDELETE&cnum=<%=scnum %>&cid=<%=cid %>";
			break;
			
		case "btnCommentList":   // view로 이동
			e.preventDefault(); // submit 취소
			e.stopPropagation();
			
			location.href = "/mboard?cmd=VIEW&id=<%=req_id %>&bnum=<%=req_bnum %>&nickname=<%=req_nickname %>" ;
			break;
		}
		
	});
}
</script>
</head>
<body>

 <%@ include file="/include/toptopnav.jsp" %>

 <div class="title" id="mytitle"><h2>사회적거리두기</h2></div>
 <%@ include file="/include/topnav.jsp" %>
 <%@ include file="/include/chat.jsp" %>

   <main>
	<%-- <%@ include file="/include/menus.jsp" %> --%>
	
	<form action="/mboard?cmd=COMMENTUPDATE&id=<%=uid %>" method="POST">
	
	<table id='upcomment'>
	 <caption><h2>댓글 관리</h2></caption>
	 <tr>
	   <td>내용</td>
	   <td><input type="textarea" name="ctext" value="<%=ctext %>"/></td>
	 </tr>
	 <tr>
	   <td colspan="2">
	   <button id="btnCommentUpdate" >수정</button>
	   <button id="btnCommentDelete" >삭제</button>
	   <button id="btnCommentList" >취소</button>
	   </td>
	  
	 </tr>
	</table>
	</form>
   </main>
   <%@ include file="/include/bottomnav.jsp" %>
</body>
</html>