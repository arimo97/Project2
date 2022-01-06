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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
	  
  $(function() {
		switch('${ covidInfoVo.vaccineortest }'){
		case '백신접종':
		 document.getElementById('vaccinetrue').checked = true;
		 break;
		case '코로나검사':
		 document.getElementById('test').checked = true;
		 break;
		default:
		 break;
		}
	  
	  switch('${ covidInfoVo.vaccine }'){
	  case '미접종':
		  document.getElementById('vaccine0').checked = true;
		  break;
	  case '1차완료':
		  document.getElementById('vaccine1').checked = true;
		  break;
	  case '2차완료':
		  document.getElementById('vaccine2').checked = true;
		  break;
	  case '3차완료':
		  document.getElementById('vaccine3').checked = true;
		  break;
	  default:
		  break;
	  	
	  } 
		switch('${ covidInfoVo.test_result }'){
		case '양성':
		 document.getElementById('pos').checked = true;
		 break;
		case '음성':
		 document.getElementById('neg').checked = true;
		 break;
		default:
		 break;
		}
  })

</script>


</head>
<body>

  <form class="modal-content" action="/mboard?cmd=COVIDINFOUPDATE" method="POST">
    <div class="container">
      <h2>개인 코로나 정보 수정</h2>
      <hr>
      <input type="hidden"  name="id" value="${ covidInfoVo.id }" readonly /> 
      <input type="hidden"  name="infonum" value="${ covidInfoVo.infonum  }" readonly />
      
      <label for="Vaccineortest1"><b>기록종류</b></label><br>
      <input type="radio" id="vaccinetrue" name="vaccineortest" value="백신접종">
  		<label for="Vaccineortest1">백신접종</label>
      <input type="radio" id="test" name="vaccineortest" value="코로나검사">
  		<label for="Vaccineortest1">코로나검사</label><br><br>
       
      <label for="email"><b>백신여부</b></label><br>
      
      
      <input type="radio" id="vaccine0" name="vaccine" value="미접종">
  		<label for="vaccineYes">미접종</label>     
      <input type="radio" id="vaccine1" name="vaccine" value="1차완료">
  		<label for="vaccineYes">1차완료</label>
      <input type="radio" id="vaccine2" name="vaccine" value="2차완료">
  		<label for="vaccineYes">2차완료</label>
      <input type="radio" id="vaccine3" name="vaccine" value="3차완료">
  		<label for="vaccineYes">3차완료</label><br>
 			<br>
      
      
      <label for="test_date"><b>백신 또는 검사날짜</b></label><br>
      <input type="date" name="test_date" value=${ covidInfoVo.test_date } }><br><br>
      

      <label for="test_hospital"><b>검사한 병원</b></label>
      <input type="text" placeholder="검사한 병원" name="test_hospital" class="covidtext" value=${ covidInfoVo.test_hospital }  >
      

      <label for="test_result"><b>검사 결과</b></label><br>
      <input type="radio" id="neg" name="test_result" value="음성" >
  		<label for="test_result" >음성</label>
      <input type="radio" id="pos" name="test_result" value="양성" >
  		<label for="test_result" >양성</label>
  		<br><br>
      
      <label for="symptom"><b>증상 기록</b></label><br>
			<textarea id="symptom" name="symptom">${ covidInfoVo.symptom }</textarea>		 
	
     


      <div class="clearfix">
        <button type="submit" class="savebtn1">수정</button>
        <button type="button" onclick="location.href='/mboard?cmd=COVIDINFODELETE&id=${ covidInfoVo.id }&num=${ covidInfoVo.infonum  }'" class="deletebtn1">삭제</button>
        <button type="button" onclick="location.href='/mboard?cmd=COVIDINFOFORM&id=${ covidInfoVo.id }'" class="registbtn1">새로등록</button>
        <button type="button" onclick="location.href='/mboard?cmd=COVIDINFOLIST&id=${ covidInfoVo.id }'" class="listbtn1">목록</button>
      </div>
    </div>
  </form>


</body>
</html>