<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib  prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib  prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
		String uid = (String)session.getAttribute("uid");
		String unickname = (String)session.getAttribute("unickname");
		

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
	#text   td:nth-of-type(1) {width:100px;}
	#text   td:nth-of-type(2) {width:700px;}
	#text   tr:nth-of-type(7) {height:400px; vertical-align:baseline;}
	
	#text   td:nth-of-type(2) {text-align:left; padding-left:10px;}
	
	textarea { height: 380px; width: 680px; margin: 10px; }
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
		case "btnUpdate": // 수정
			let  btitle = document.querySelector('[name=btitle]');
			let  btext = document.querySelector('[name=btext]');
			if(btitle.value.trim().length == 0) {
				alert("제목을 입력하세요")
				// return false; 가 안되서 아래 두개 명령어를 씀
				// 기본 이벤트 취소 e.preventDefault();
				 e.preventDefault();
				 e.stopPropagation();
			}
			if(btext.value.trim().length == 0) {
				alert("내용을 입력하세요")
				// return false; 가 안되서 아래 두개 명령어를 씀
				// 기본 이벤트 취소 e.preventDefault();
				 e.preventDefault();
				 e.stopPropagation();
			}
			break;
		case "btnView":   // 목록으로
			e.preventDefault(); // submit 취소
			e.stopPropagation();
			
			location.href = "/mboard?cmd=VIEW&bnum=${boardVo.bnum}&id=${boardVo.id}" ;
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
	
	<form action="/mboard?cmd=UPDATE&id=<%=uid %>&nickname=<%=unickname %>" method="POST">
	
	<table id='text'>
	 <caption><h2>게시판 내용보기</h2></caption>
	 <tr>
	   <td>글번호</td>
	   <td><input type="text" name="bnum" value="${ boardVo.bnum }" readonly /></td>
	 </tr>
	 <tr>
	   <td>작성자</td>
	   <td><input type="text" value="${ boardVo.nickname }" readonly /></td>
	 </tr>
	 <tr>
	   <td>작성일</td>
	   <td><input type="text" value="${ boardVo.bregdate }" readonly /></td>
	 </tr>
	 <tr>
	   <td>조회수</td>
	   <td><input type="text" value="${ boardVo.readcount }" readonly /></td>
	 </tr>
	 <tr>
	   <td>제목</td>
	   <td><input type="text" name="btitle" value="${ boardVo.btitle }" /></td>
	 </tr>
	 <tr>
	   <td>내용</td>
	   <td><textarea name="btext">${ boardVo.btext }</textarea></td>
	 </tr>
	 <tr>
	   <td colspan="2">
	   <button id="btnUpdate" >수정</button>
	   <button id="btnView" >취소</button>
	   </td>
	  
	 </tr>
	</table>
	</form>
   </main>
   <%@ include file="/include/bottomnav.jsp" %>
</body>
</html>