<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  <%
  	String uid       = (String)session.getAttribute("id");
  	String unickname = (String)session.getAttribute("nickname");
  	
  %>     
       
<!DOCTYPE html>
<html>
<head>
<meta charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" />
  <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="/css/prj2.css">
<title>게시글 리스트</title>
<style>
	.container {width: 80%;}
		
	h1       {text-align: center;}
	
	a        {text-decoration: none; color : black;}
	.write   {
/* 		border:dashed red 1px;
 */		text-align: right;	
		padding-right: 20px;
		font-weight: bold;
		font-size: 20px;
		height: 30px;
	}
	#uplist  {
		background-color: rgb(230, 220, 220);
		font-weight: bold;
		border : solid rgb(165, 14, 14) 1px;
	}
	
	#up      {
		color: rgb(165, 14, 14);
	}

	
	table td:nth-of-type(2) {font-weight: bold;}
</style>
</head>
<body>
 <%@ include file="/include/toptopnav.jsp" %>

 <div class="title" id="mytitle"><h2>게시판</h2></div>
 <%@ include file="/include/topnav.jsp" %>

  <main>
   
     <h1>게시글</h1>
    <div class="container">
         <div class="write" ><a href="/mboard?cmd=WRITEFORM&id=<%=uid%>" >새글쓰기</a></div>
   <table id="boardlisttable" class="table">
   <thead>
     <tr>
       <td>번호</td>
       <td>제목</td>
       <td>작성자</td>
       
       <td>작성일</td>
       <td>조회수</td>
     </tr>
    </thead>
    <tbody>
     <c:forEach var="boardup"  end="4" items="${ boardupList }" >
     <tr id="uplist">
     <td>${ boardup.bnum }</td> 
       <td>
          <div id="up">*추천글*</div>
        <a href="/mboard?cmd=VIEW&bnum=${ boardup.bnum }&id=${ boardup.id }&nickname=${ boardup.nickname }">
          ${ boardup.btitle }
        </a>
       </td>
       <td>${ boardup.nickname }</td>
       <td>${ boardup.bregdate }</td>
       <td>${ boardup.readcount }</td>
     
     </tr>
     </c:forEach>
          <c:forEach var="board"  items="${ boardList }" >
     <tr>
       <td>${ board.bnum }</td> 
       <td>
        <a href="/mboard?cmd=VIEW&bnum=${ board.bnum }&id=${ board.id }&nickname=${ board.nickname }">
          ${ board.btitle }
        </a>
       </td>
       <td>${ board.nickname }</td>
       <td>${ board.bregdate }</td>
       <td>${ board.readcount }</td>
     </tr>
     </c:forEach>
     </tbody>
   </table>
   </div>
  </main>
  
 <%@ include file="/include/bottomnav.jsp" %>
</body>
</html>