<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.jumbotron{display: flex !important;
    			align-items: center !important;
    			padding: 40px;}
    .container{  max-width: 80% !important;}
</style>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script>
	
	function doInsert(){
		var inputnick = document.getElementById('nickinput').value;
		if (inputnick == '' || inputnick == null){
			alert('별칭을 입력해주세요');
			inputnick.focus();
			return false;
		}
		var nickname = window.opener.document.getElementById('nickname3');
		nickname.innerHTML = inputnick;
		window.opener.document.getElementById('loc3name').value = inputnick;
		window.close();
	}
	
	window.onload = function(){
	var confirm = document.getElementById('confirm');
		confirm.onclick = doInsert;
	}
</script>
</head>
<body>
	<form onsubmit="return check()">
	<div class="jumbotron">
  	<div class="container">
    <h1 class="display-4">별칭</h1>
    <p class="lead">알아보기 쉽게 별칭을 정하세요</p>
	<input type="text" placeholder="" id="nickinput">
	<button type="submit" id="confirm" onclick="">확인</button>
  	</div>
	</div>
	</form>
	
</body>
</html>