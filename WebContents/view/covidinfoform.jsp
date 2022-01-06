<%@page import="javax.swing.plaf.metal.MetalBorders.Flush3DBorder"%>
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
<title>Insert title here</title>



</head>
<body>

  <form class="modal-content" action="/mboard?cmd=COVIDINFO" method="POST">
    <div class="container">
    <div>
    <div class="covidinfotitle">
      개인 코로나 정보 입력
     </div>
     <div class="covidinfohome" onclick="location.href='/mboard?cmd=HOME&id=${ id }'">
      			Home
      </div>
      </div>
      
      <br>
      <br>
      <br>
    
      <div>
        <hr>
      <input type="hidden"  name="id" value="${ id }" readonly />
      <label for="Vaccineortest"><b>기록종류</b></label><br>
      <input type="radio" id="vaccine" name="vaccineortest" value="백신접종">
  		<label for="test_result">백신접종</label>
      <input type="radio" id="test" name="vaccineortest" value="코로나검사">
  		<label for="test_result">코로나검사</label> <br><br>
  		
      <label for="email"><b>백신여부</b></label><br>
      <input type="radio" id="vaccine1" name="vaccine" value="미접종">
  		<label for="vaccineYes">미접종</label>     
      <input type="radio" id="vaccine1" name="vaccine" value="1차완료">
  		<label for="vaccineYes">1차완료</label>
      <input type="radio" id="vaccine2" name="vaccine" value="2차완료">
  		<label for="vaccineYes">2차완료</label>
      <input type="radio" id="vaccine3" name="vaccine" value="3차완료">
  		<label for="vaccineYes">3차완료</label><br>
 			<br>
      
      
      <label for="test_date"><b>백신 또는 검사날짜</b></label><br>
      <input type="date" name="test_date"><br><br>
      

      <label for="test_hospital"><b>검사한 병원</b></label>
      <input type="text" placeholder="검사한 병원" name="test_hospital" class="covidtext">

      <label for="test_result"><b>검사 결과</b></label><br>
      <input type="radio" id="neg" name="test_result" value="음성">
  		<label for="test_result">음성</label>
      <input type="radio" id="pos" name="test_result" value="양성">
  		<label for="test_result">양성</label>
  		<br><br>
      
      <label for="symptom"><b>증상 기록</b></label><br>
			<textarea id="record" name="symptom"></textarea>		 
     
			</div>

      <div class="clearfix">
        <button type="submit" class="savebtn">저장</button>
        <button type="button" onclick="location.href='/mboard?cmd=COVIDINFOLIST&id=${ id }'" class="listbtn">목록</button>
      </div>
    </div>
  </form>


</body>
</html>