<%@page import="org.apache.catalina.Session"%>
<%@page import="mboard.vo.MemberVo"%>
<%@page import="mboard.dao.MemberDao"%>
<%@page import="mboard.vo.BoardVo"%>
<%@page import="mboard.dao.BoardDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib  prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib  prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	String uid = (String)session.getAttribute("id");
	String bnum = (String)session.getAttribute("bnum");
	String bid = (String)session.getAttribute("bid");
	String bnickname = (String)session.getAttribute("bnickname");
	String unickname = (String)session.getAttribute("nickname");
	String commentList = (String)session.getAttribute("commentList");
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" />
  <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="/css/prj2.css">
<title>Insert title here</title>
<style>
    /* board tr 7개  */
	#board   td:nth-of-type(1) {width:100px;}
	#board   td:nth-of-type(2) {width:700px;}
	
	#board   td:nth-of-type(2) {text-align:left; padding-left:10px;}
	#board   tr:nth-of-type(5)  {height: 300px;}
	#board   tr:nth-of-type(5) td:nth-of-type(2) {background-color: white;}
	#board   tr:nth-of-type(6)  {text-align: center;}
		
    /* board tr 2개  */
	#comenttitle td:nth-of-type(1) {width:700px;}
	#comenttitle td:nth-of-type(2) {width:100px;}
	
	
	#comment td:nth-of-type(1) {width:100px;}
	#comment td:nth-of-type(2) {width:700px;}
	
	/* 이거 안됨 */
	/* #comment tr:nth-of-type(4) {color : red; height:400px; vertical-align:baseline;} */
	
	.ctext                     { height:50px; width:700px; }
	.upcomment                 { height:50px; width:700px; } 

</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
function myFunction() {
	  var x = document.getElementById("myTopnav");
	  if (x.className === "topnav") {
	    x.className += " responsive";
	  } else {
	    x.className = "topnav";
	  }
	}

/* 삭제 확인 창 */

/* function delchk(){
    return confirm("삭제하시겠습니까?");
}
 */


/* function button_event(){

	if (confirm("정말 삭제하시겠습니까??") == true){    //확인

	    document.form.submit();

	}else{   //취소

	    return;

	}

	}
 */

<%-- window.onload() {
	
	 var clist = '<%=(String)session.getAttribute("commentList")%>';
	 
	 if(<%=unickname %>.equals(${ boardVo.nickname })) {

		 for(var i = 0; i < clist.length; i++){
			 
	document.getElementsByName('cupdate')[i].hidden = false;
	document.getElementsByName('cdelete')[i].hidden = false;
			 
		 }
		 
	document.getElementsByClassName('uview').hidden = false;
	 }
} --%>
/*	
$( function() {
	
	for (var i = 0; i < clist.length; i++) {
//	 $('#cupdate').on('click', function() {
		
 	alert("수정1");
//alert(i);
	var cupdate = document.getElementsByName('cupdate')[i];
	cupdate.onclick = function(){
	document.getElementsByName('upcomment')[i].readOnly = false;
	alert("for 실행 " + i);
		
	}
//	});
	alert("수정2");
		 
		 
	}     
	
}); */
	
<%-- $( function() {

 alert("시작");
var clist = '<%=(String)session.getAttribute("commentList")%>';
for (var i = 0; i < clist.length; i++) {
alert("for 실행 " + i);
var cupdate = document.getElementsByName('cupdate')[i];
cupdate.onclick = function(){
	alert("onclick 시작");
document.getElementsByName('upcomment')[i-2].readOnly = false;
	alert("onclick 끝");
	
}
alert("for 실행 끝" + i);
} 
}); --%>


	 
//	for (var i = 0; i < 2; i++) {
	
/* 	for (var i = 0; i < clist.length; i++) {
alert(i);
	var cupdate = document.getElementsByName('cupdate')[i];
	cupdate.onclick = function(){
	 alert("수정");
	document.getElementsByName('upcomment')[i].readOnly = false;
		
	}
		
	} */
	
	/* 댓글 목록은 +1개 버튼은 2부터 text는 5부터 */
	
	
	/* function update() {
	alert("수정.");
	document.getElementsByName('upcomment')[0].readOnly = false;
	
}; */
	
	

</script>
</head>
<body>

 <%@ include file="/include/toptopnav.jsp" %>

 <div class="title" id="mytitle"><h2>게시판</h2></div>
 <%@ include file="/include/topnav.jsp" %>

   <main>
	<%-- <%@ include file="/include/menus.jsp" %> --%>
	<table class="boardlisttable table">
	 <caption><h2>게시판 내용보기</h2></caption>
	 <tr>
	   <td>글번호</td>
	   <td>${ boardVo.bnum }</td>
	 </tr>
	 <tr>
	   <td>작성자</td>
	   <td>${ boardVo.nickname }</td>
	 </tr>
	 <tr>
	   <td>작성일</td>
	   <td>${ boardVo.bregdate }</td>
	 </tr>
	 <tr>
	   <td>제목</td>
	   <td>${ boardVo.btitle }</td>
	 </tr>
	 <tr>
	   <td id="boardcontent">내용</td>
	    <% pageContext.setAttribute("newLineChar", "\n"); %>
	   <td id="boardcontent1">${fn:replace(boardVo.btext, "newLineChar", "<br />")}</td>
	 </tr>
	 <tr>
	   <td colspan="2" class="toboardtd">
	   <div onclick="location.href='/mboard?cmd=WRITEFORM&id=<%=uid %>&nickname=<%=unickname %>'" class="toboardlist">새글쓰기</div>
	   <div onclick="location.href='/mboard?cmd=DELETE&bnum=${ boardVo.bnum }&id=<%=uid %>'" class="toboardlist">삭제하기</div>
	   <div onclick="location.href='/mboard?cmd=UPDATEFORM&bnum=${ boardVo.bnum }&id=<%=uid %>&nickname=<%=unickname %>'" class="toboardlist">수정하기</div>
	   <div onclick="location.href='/mboard?cmd=BOARD&id=<%=uid %>'" class="toboardlist">목록으로</div>
	 <%--   <a href="/mboard?cmd=DELETE&bnum=${ boardVo.bnum }&id=<%=uid %>" class="uview">
	   [삭제 하기]                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
	   </a>
	   <a href="/mboard?cmd=UPDATEFORM&bnum=${ boardVo.bnum }&id=<%=uid %>&nickname=<%=unickname %>" class="uview">
	   [수정 하기]
	   </a>
	   <a href="/mboard?cmd=BOARD&id=<%=uid %>">
	   [목록으로]
	   </a> --%>
	   </td>
	  
	 </tr>
	 <tr class = vacantrow>
	 	<td colspan="2">
	 	</td>
	 </tr>
	
	
	  <tr>
	   <td colspan="2" id="commenttitle">댓글 ${ commentcount }</td>
	 </tr>
<tr>
 	  <form action="/commentwrite" method = "GET">
	   <td colspan="2"><input type="textarea" name="ctext"  placeholder="댓글 추가" value="" class="ctext" />
 	   <%-- <td><a href="/mboard?cmd=COMMENTWRITE&bnum=${ boardVo.bnum }&id=<%=uid %>&nickname=<%=unickname %>" />확인</td> --%>
	   <input type = "submit"  id="chart1searchbutton" value="확인" /></td>
        </form> 
	    <%-- <td><a href="/commentwrite&bnum=${ boardVo.bnum }&id=<%=uid %>" />확인</td> --%> 
	 </tr>
	  <tr>
	   <td colspan="2" id="commentlist">댓글 목록</td>
	 </tr>
	   <c:forEach var="comment"  items="${ commentList }" >
	  <tr>
	   <td>${ comment.nickname }</td>
	   <td>${ comment.ctext } 
	   
	     <a href="/mboard?cmd=COMMENTOPTION&id=<%=uid%>&cnum=${ comment.cnum }&cid=${ comment.id }&ctext=${ comment.ctext }" >
	       <img class="more-horizontal" src="/img/more-horizontal.png" />
	     </a></td>

	 </tr>
	   </c:forEach>
	</table>
   </main>
   <%@ include file="/include/bottomnav.jsp" %>
</body>
</html>