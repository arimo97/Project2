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
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" />
  <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="/css/prj2.css">
<title>Insert title here</title>
<style>
	.container {width: 80%;}
   form  td:nth-child(1)     { width:200px; }
   form  td:nth-child(2)     { width: 800px; }
   form  tr:nth-of-type(3)   { height:400px; }
   textarea                  { height:380px; width:780px; margin:10px;  }
   .width                    { width: 780px; }
</style>
<script>

window.onload = function() {
	var form = document.querySelector('form');
	form.addEventListener('submit', function(e) {
		console.log(e);
		var btn = e.submitter; // 이벤트를 발생시킨 버튼
		// alert(btn.id);
		switch(btn.id) {
		case "btnupdate": // 수정
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
		case "btnview":   // 취소
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

   <main>
	<div class="container">   
     <!-- <form  action="/board?cmd=WRITE&id=" method="POST"> -->
     <form  action="/mboard?cmd=WRITE" method="POST">
     <!-- <input type="hidden"  name="id"  value="${ id }" /> -->
     <input type="hidden"  name="id"  value="<%=uid %>" />
     <table>
      <caption><h2>게시판 글 쓰기</h2></caption>
      <tr>
        <td>제목</td>
        <td><input type="text" class="width" name="btitle" /></td>
      </tr>
      <tr>
        <td>작성자</td>
        <td><input type="text" class="width" name="nickname" value="<%=unickname %>" /></td>
      </tr>
      <tr>
        <td>내용</td>
        <td><textarea name="btext"></textarea></td>
      </tr>
      <tr>
        <td colspan="2">
          <button id = "btnupdate">확인</button>
          <button id = "btnview">취소</button>
          
        </td>
      </tr>
     </table> 
     </form>    
     </div>
   </main>
<%@ include file="/include/bottomnav.jsp" %>
</body>
</html>














