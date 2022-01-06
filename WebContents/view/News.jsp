<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/css/prj2.css">
<style>
/* 	#link {all :unset !important;}
	#link:active{all :unset !important;}
	#link:hover{all :unset !important;} */
</style>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/js/bootstrap.min.js" integrity="sha512-OvBgP9A2JBgiRad/mM36mkzXSXaJE9BEIENnVEmeZdITvwT09xnxLtT4twkCa8m/loMbPHsvPl0T8lRGVBwjlQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" />
  <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/js/bootstrap.bundle.min.js"></script>  
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
	$(function(){
			var div = $('#newscontent');
			var html = '';
		$.ajax({
			url : '/news',
			data : {},
			beforeSend : function(){
				var loading = '<div class="container-fluid"><div class="d-flex justify-content-center">'+
				  '<div class="spinner-border" role="status">'+
				    '<span class="visually-hidden">Loading...</span>'+
				  '</div></div></div>';
				  
				$('#newscontent').html(loading);
			},
			success : function(json){
				$.each(json, function(index, data){
					
					
					html += '<div class="col">'
						 + '<div class="card h-100 shadow rounded">'
						 + '<a id="link" href="' + data.link +'">'
				      	 + '<img src="' + data.img + '" class="card-img-top" height="300	" width="300" alt="...">'
				      	 + '<div class="card-body">'
				      	 + '<h5 class="card-title">' + data.title + '</h5></a>'
				      	 + '<span class="card-text">' + data.description + '</span>'
				      	 + '</div></div></div>';
				        
				/* 	data.title
					data.link
					data.description
					data.pubDate */
					
					/* "title": "셀트리온 <b>코로나</b> 치료제 '렉키로나', 호주 조건부 허가",
					"originallink": "http://www.newsis.com/view/?id=NISX20211207_0001678184&cID=10434&pID=13100",
					"link": "https://news.naver.com/main/read.naver?mode=LSD&mid=sec&sid1=102&oid=003&aid=0010874376",
					"description": "기사내용 요약한국, 유럽 등 이어 호주서 승인 렉키로나 사용 가능 국가 확대 셀트리온은 <b>코로나</b>19 항체... 호주 보건당국은 신속 잠정승인 절차에 따라 <b>코로나</b>19 확진을 받은 성인 고위험군 경증환자, 중등증 환자를... ",
					"pubDate": "Tue, 07 Dec 2021 08:46:00 +0900"
					
					<div class="col">
				    <div class="card h-100">
				      <img src="..." class="card-img-top" alt="...">
				      <div class="card-body">
				        <h5 class="card-title">Card title</h5>
				        <p class="card-text">This is a longer card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.</p>
				      </div>
				    </div>
				  </div>
					
					*/
				})
				$("#newscontent").html(html);
			},
			error : function(xhr){
				alert(xhr.status + ' ' + xhr.statusText);
			}
		})
	})
</script>
</head>
<body>
 <%@ include file="/include/toptopnav.jsp" %>

 <div class="title" id="mytitle"><h2>코로나 뉴스</h2></div>
 <%@ include file="/include/topnav.jsp" %>
 
	<div id="newscontent" class="row row-cols-1 row-cols-md-5 g-4 border border-light " style="margin: 10px 20px;">
	</div>
	
	<%@ include file="/include/bottomnav.jsp" %>
	
</body>
</html>