<%@page import="java.util.Vector"%>
<%@page import="mboard.dao.CovidInfoDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" />
  <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="/css/prj2.css">



</head>
<body>



  <main>   
   <h2>코로나개인정보 리스트</h2>
   <table>
     <tr>
       <td colspan="8" >
          <div class="covidinfoadd" onclick="location.href='/mboard?cmd=COVIDINFOFORM&id=${ id }'">
      			기록추가
      </div>
          <div class="covidinfohome" onclick="location.href='/mboard?cmd=HOME&id=${ id }'">
      			Home
      </div>
       </td>
     </tr>
     <tr>
       <td class="hidden-col">순번</td>
       <td class="hidden-col">아이디</td>
       <td>기록종류</td>
       <td>백신여부</td>
       <td>백신 또는 검사날짜</td>
       <td>검사한병원</td>
       <td>검사결과</td>
       <td>증상기록</td>
     </tr>
     

      
    <c:forEach var="covidinfoiList" items="${ requestScope.covidinfoiList }">
<%--      <tr id="tr1" onClick="location.href='/mboard?cmd=COVIDVIEW&id=${ memViewVo.id }&num=${ covidinfoiList.get(0)  }'"> --%>
			<tr onClick="location.href='/mboard?cmd=COVIDVIEW&id=${ covidinfoiList.get(1) }&num=${ covidinfoiList.get(0)  }'">

      <td class="hidden-col">${ covidinfoiList.get(0)  }</td>
       <td class="hidden-col" name ="userid">
       ${ covidinfoiList.get(1)  }
       </td>
       <td>${ covidinfoiList.get(2)  }</td>
       <td>${ covidinfoiList.get(3)  }</td>
       <td>${ covidinfoiList.get(4)  }</td>
       <td>${ covidinfoiList.get(5)  }</td>
       <td>${ covidinfoiList.get(6)  }</td>
       <td>${ covidinfoiList.get(7)  }</td>
     <!--   <td><a href="/mboard?cmd=MENUDELETE">삭제</a></td> -->
     </tr>   
   
    </c:forEach>
   </table>
   
  </main>  
   

  
</body>
</html>