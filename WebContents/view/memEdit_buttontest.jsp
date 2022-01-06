<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.card.card-primary {  position: absolute;
						  top: 50%;
						  left: 50%;
						  transform: translate(-50%, -50%);
						  width:500px;
						  overflow: auto;

  						}
  	.radio {margin: 20px 0px;}
  	.green {color: green;}
  	code {margin: 0px 10px;}
  	.imgLoc{margin-left: 10px;}
</style>
<link href="/dist/css/adminlte.min.css" rel="stylesheet">
  <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
    <!-- Font Awesome -->
  <link rel="stylesheet" href="/css/all.min.css">
    <!-- Theme style -->
  <link rel="stylesheet" href="/css/adminlte.min.css">
  	<!-- radio button -->
  <link rel="stylesheet" href="/css/memReg_radio.css">
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>

	function check(){
		// 아이디 공백 체크-----------------------------------
		var id = document.getElementById('idinput');
		if (!id.value){
			alert('아이디를 입력해 주세요');
			id.focus();
			return false;
		}
		
		//비밀번호 체크----------------------------------------
		var pw1 = document.getElementById('pwinput1');
		var pw2 = document.getElementById('pwinput2');
		if (!pw1.value){
			alert('비밀번호를 입력해 주세요');
			pw1.focus();
			return false;
		}
		if (!pw2.value){
			alert('비밀번호를 입력해 주세요');
			pw2.focus();
			return false;
		}
		
		if (pw1.value != pw2.value){
			alert('비밀번호가 일치하지 않습니다');
			return false;
		}
		
		//닉네임 체크-------------------------------------------
		var nick = document.getElementById('nicknameinput');
		if(!nick.value){
			alert('닉네임은 필수입니다.')
			nick.focus();
			return false;
		}

		//중복여부 체크-----------------------------------------
		var verify = document.getElementsByTagName('b');
		if (verify.length != 2){
				alert('아이디 및 닉네임 중복을 확인해 주세요');
				return false;
		} else{
			for(var i in verify){
				if (verify.className == 'red'){
					alert('아이디 및 닉네임을 확인해 주세요');
					verify[i].focus();
					return false;
					}
				}
		}
		
		
	}
	
	function btnHome(){
		 new daum.Postcode({
		        oncomplete: function(data) {
		            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
		            // 예제를 참고하여 다양한 활용법을 확인해 보세요.
		            
		            var roadAddr = data.roadAddress; // 도로명 주소 변수
		            var extraRoadAddr = ''; // 참고 항목 변수
		            
		            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
		            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
		            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
		                extraRoadAddr += data.bname;
		            }
		            // 건물명이 있고, 공동주택일 경우 추가한다.
		            if(data.buildingName !== '' && data.apartment === 'Y'){
		               extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
		            }
		            // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
		            if(extraRoadAddr !== ''){
		                extraRoadAddr = '(' + extraRoadAddr + ')';
		            }
		            
		            var html = '<input type="radio" name="location" id="homeradio" class="radio2" value="home"/><label for="homeradio"></label>' +
		            '<input type="button" id="home" class="radio2" hidden="hidden" onclick="btnHome();"/>' +
					'<label for="home">' + '우리집' + '<img src="/img/home.svg" width="20px" height="20px" class="imgLoc"/></label>'
					+ '<p class="addjuso" id="homeAddr">' + roadAddr + ' ' + extraRoadAddr + '</p>';
					
		            document.getElementById('homespan').innerHTML = html;
					}
		 }).open();
	}
	
	function btnOffice(){
		new daum.Postcode({
	        oncomplete: function(data) {
	            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
	            // 예제를 참고하여 다양한 활용법을 확인해 보세요.
	            
	            var roadAddr = data.roadAddress; // 도로명 주소 변수
	            var extraRoadAddr = ''; // 참고 항목 변수
	            
	            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                extraRoadAddr += data.bname;
	            }
	            // 건물명이 있고, 공동주택일 경우 추가한다.
	            if(data.buildingName !== '' && data.apartment === 'Y'){
	               extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	            }
	            // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	            if(extraRoadAddr !== ''){
	                extraRoadAddr = '(' + extraRoadAddr + ')';
	            }
	            
	            var html = '<input type="radio" name="location" id="officeradio" class="radio2" value="office"/><label for="officeradio"></label>' +
	            '<input type="button" id="office" class="radio2" hidden="hidden" onclick="btnOffice();"/>' +
				'<label for="office">' + '회사' + '<img src="/img/company_loc.svg" width="20px" height="20px" class="imgLoc"/></label>'
				+ '<p class="addjuso" id="officeAddr">' + roadAddr + ' ' + extraRoadAddr + '</p>';
				
	            document.getElementById('officespan').innerHTML = html;
				}
		}).open();
	}
	
	window.onload = function(){
		
		var search = document.getElementById('searchlocation');
		search.onclick = function(){
			 new daum.Postcode({
			        oncomplete: function(data) {
			            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
			            // 예제를 참고하여 다양한 활용법을 확인해 보세요.
			            
			            var roadAddr = data.roadAddress; // 도로명 주소 변수
			            var extraRoadAddr = ''; // 참고 항목 변수
			            
			            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
			            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
			            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
			                extraRoadAddr += data.bname;
			            }
			            // 건물명이 있고, 공동주택일 경우 추가한다.
			            if(data.buildingName !== '' && data.apartment === 'Y'){
			               extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
			            }
			            // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
			            if(extraRoadAddr !== ''){
			                extraRoadAddr = '(' + extraRoadAddr + ')';
			            }
		
		/*  			            // 우편번호와 주소 정보를 해당 필드에 넣는다.
			            document.getElementById("sample4_roadAddress").value = roadAddr;
			            document.getElementById('sample4_postcode').value = data.zonecode;
			            document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
			            
			            // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
			            if(roadAddr !== ''){
			                document.getElementById("sample4_extraAddress").value = extraRoadAddr;
			            } else {
			                document.getElementById("sample4_extraAddress").value = '';
			            }
			            
			            document.getElementById("sample4_roadAddress").value = roadAddr; */
			            var addedjuso = document.getElementsByClassName('addedjuso');
			            var len = parseInt(addedjuso.length + 1);
			            var html = '';
						if (len > 3){
							alert('주소는 3개까지 추가 가능합니다');
							} else{
								
								html = '<input type="radio" name="location" id="addjuso' + len + '" class="radio2" value="' + len + '">' +
								'<label for="addjuso' + len + '">' + '<span class="addedjuso" id="nickname' + len + '"></span>' + '<img src="/img/location.svg" width="20px" height="20px" class="imgLoc"></label>'
								+ '<p class="addjuso" id="inloc' + len + '">' + roadAddr + ' ' + extraRoadAddr + '</p>';
								alert(html);
								
								window.open('/view/jusoname.jsp', '별칭을 설정해 주세요', 'height=560,width=500,top=100,left=100');
								
								addjuso.innerHTML += html;
								
							}
			        }
			    }).open();
			
		}
		
		// 집 주소 추가
		var home = document.getElementById('home');
		home.onclick = btnHome;
		
		// 회사 주소 추가
		var office = document.getElementById('office');
		office.onclick = btnOffice;
		
		// 뒤로가기 버튼-------------------------------------------------------
		var cancel = document.getElementById('cancel');
		cancel.onclick = function() {
			history.back();
		}
		
		// 아아디 중복체크 ----------------------------------------------------------		
		document.getElementById('btnVerifyId').onclick = function(){
			$.ajax({
				url : '/regcheck',
				datatype : 'html',
				data : {id : document.getElementById('idinput').value,
						btn : 'id'},
				success : function(html){
					$('#usableId').html(html);
				},
				error : function(xhr){
					console.log(xhr.status + ':' + xhr.statusText);
				}
			})
		}
		
		// 닉네임 중복체크 ----------------------------------------------------------
		document.getElementById('btnVerifyNick').onclick = function(){
			$.ajax({
				url : '/regcheck',
				datatype : 'html',
				data : {nickname : document.getElementById('nicknameinput').value,
						btn : 'nick'},
				success : function(html){
					$('#usableNick').html(html);
				},
				error : function(xhr){
					console.log(xhr.status + ':' + xhr.statusText);
				}
			})
		}
		/* var verify = document.getElementsByTagName('b');
		console.log(verify.length); */
	}
</script>
</head>
<body>
	<!-- general form elements -->
	<div class="card card-primary">
		<div class="card-header" >
			<h3 class="card-title" >회원정보수정</h3>
		</div>
		<!-- /.card-header -->
		<div class="card-body">
			<form action="/mboard?cmd=EDIT" method="POST" onsubmit="return check()">
			<div class="form-group">
				<label for="exampleInputBorder">ID<code id="usableId"><!-- 사용가능한 아이디 --></code></label>
				<input type="button" value="중복확인" class="btn btn-default float-right" id="btnVerifyId" hidden="hidden">
				<input type="text" class="form-control form-control-border"
					id="idinput" placeholder="ID" name="id" value="${id }" readonly >
			</div>
			<div class="form-group">
				<label for="exampleInputBorderWidth2">패스워드 변경
					<!-- <code>.form-control-border.border-width-2</code> -->
				</label> <input type="password"
					class="form-control form-control-border border-width-2"
					id="pwinput1"
					placeholder="password" name="pw">
			</div>
			<div class="form-group">
				<label for="exampleInputBorderWidth3">패스워드 변경 확인
				<!-- <code>.form-control-border.border-width-2</code> -->
				</label> <input type="password" class="form-control form-control-border border-width-2" 
				id="pwinput2" placeholder="password">
			</div>
			<div class="form-group">
				<label for="exampleInputBorder">닉네임<code id="usableNick"><!-- 사용가능한 아이디 --></code></label>
				<input type="button" value="중복확인" class="btn btn-default float-right" id="btnVerifyNick" hidden="hidden">
				<input type="text" class="form-control form-control-border"
					id="nicknameinput" placeholder="nickname" name="nickname" value="${nickname }" readonly>
			</div>
			<div class="form-group">
				<label for="exampleInputRounded0">이메일 <!-- <code>.rounded-0</code> --></label>
				<input type="email" class="form-control form-control-border"
					id="exampleInputRounded0" placeholder="email" name="email" value="${email }">
			</div>
			<h4>주소 설정<input type="button" class="btn btn-default float-right" value="내 장소 추가" id="searchlocation"></h4>
			<div class="radio">
			
				<input type="radio" name="location" id="current" class="radio2" checked="checked" value="current">
				<label for="current">현재 위치 (GPS)<img src="/img/current_loc.svg" width="20px" height="20px" class="imgLoc"></label>
				<hr>
				
				<c:choose>
				<c:when test="${home == null}">
				<span id="homespan">
				<input type="button" id="home" class="radio2" hidden="hidden">
				<label for="home">우리집 추가<img src="/img/home.svg" width="20px" height="20px" class="imgLoc"></label>
				</span>
				</c:when>
				
				<c:when test="${home != null}">
				<span id="homespan">
				<input type="radio" name="location" id="homeradio" class="radio2" value="home"/>
				<label for="homeradio"></label>
			    <input type="button" id="home" class="radio2" hidden="hidden"/>
				<label for="home">우리집<img src="/img/home.svg" width="20px" height="20px" class="imgLoc"/></label>
				<p class="addjuso" id="homeAddr">${home.address }</p>
				</span>
				</c:when>
				</c:choose>
				
				<br>
				
				<c:choose>
				<c:when test="${office == null }">
				<span id="officespan">
				<input type="button" id="office" class="radio2" hidden="hidden"/>
				<label for="office">회사 추가<img src="/img/company_loc.svg" width="20px" height="20px" class="imgLoc"/></label>
				</span>
				</c:when>
				
				<c:when test="${office != null}">
				<span id="officespan">
				<input type="radio" name="location" id="officeradio" class="radio2" value="office"/>
				<label for="officeradio"></label>
			    <input type="button" id="office" class="radio2" hidden="hidden"/>
				<label for="office">우리집<img src="/img/company_loc.svg" width="20px" height="20px" class="imgLoc"/></label>
				<p class="addjuso" id="officeAddr">${office.address }</p>
				</span>
				</c:when>
				</c:choose>
				
				<hr>
				
				<div id="extraloc">
				<c:set var="len" value="${fn:length(extraloc) }"></c:set>
				<c:forEach var="n" begin="1" end="${len }"  step="1">
				
					<input type="radio" name="location" id="addjuso${n }" class="radio2" value="loc${n }"/>
					<label for="addjuso${n }"><span class="addedjuso" id="nickname${n }">${extraloc[n].name }</span>
					<img src="/img/location.svg" width="20px" height="20px" class="imgLoc"/></label>
					<p class="addjuso" id="inloc${n }">${extraloc[n].address }</p>
					
				</c:forEach>
				</div>
				
			</div>
			<button type="submit" class="btn btn-info" id="join" >수정</button>
			<button type="button" class="btn btn-default float-right" id="cancel" >뒤로가기</button>
			
			<div id="databox" style="display : none;">
				<input type="text" name="homeloc" id="homeloc">
				<input type="text" name="officeloc" id="officeloc">
				<input type="text" name="loc1name" id="loc1name">
				<input type="text" name="loc1" id="loc1">
				<input type="text" name="loc2name" id="loc2name">
				<input type="text" name="loc2" id="loc2">
				<input type="text" name="loc3name" id="loc3name">
				<input type="text" name="loc3" id="loc3">
				<input type="button" id="jusoname">
			</div>
			</form>
		</div>
	</div>
</body>
</html>