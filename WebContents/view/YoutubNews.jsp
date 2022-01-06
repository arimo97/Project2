<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/css/prj2.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
/* 	#link {all :unset !important;}
	#link:active{all :unset !important;}
	#link:hover{all :unset !important;} */
</style>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
	$(function(){
			var div = $('#videocontents');
		$.ajax({
			url : '/ytnews1',
			data : {},
			success : function(json){
				var html = '';
				$.each(json, function(index, data){
					
					console.log(data);
					html += '<div class="col">'
						 + '<div class="card h-100 shadow rounded">'
						 + '<a id="link" href="' + 'https://www.youtube.com/watch?v=' + data.id.videoId +'">'
				      	 + '<img src="' + data.snippet.thumbnails.high.url + '" class="card-img-top" height="300	" width="300" alt="...">'
				      	 + '<div class="card-body">'
				      	 + '<h5 class="card-title">' + data.snippet.title + '</h5></a>'
				      	 + '<span class="card-text">' + data.snippet.description + '</span>'
				      	 + '</div></div></div>';
				        
				})
				$("#videocontents").append(html);
			},
			error : function(xhr){
				alert(xhr.status + ' ' + xhr.statusText);
			}
		})
				$.ajax({
			url : '/ytnews2',
			data : {},
			success : function(json){
					var html = '';
				$.each(json, function(index, data){
					html += '<div class="col">'
						 + '<div class="card h-100 shadow rounded">'
						 + '<a id="link" href="' + 'https://www.youtube.com/watch?v=' + data.id.videoId +'">'
				      	 + '<img src="' + data.snippet.thumbnails.high.url + '" class="card-img-top" height="300	" width="300" alt="...">'
				      	 + '<div class="card-body">'
				      	 + '<h5 class="card-title">' + data.snippet.title + '</h5></a>'
				      	 + '<span class="card-text">' + data.snippet.description + '</span>'
				      	 + '</div></div></div>';
				        
				})
				div.append(html);
			},
			error : function(xhr){
				alert(xhr.status + ' ' + xhr.statusText);
			}
		})
				$.ajax({
			url : '/ytnews3',
			data : {},
			success : function(json){
					var html = '';
				$.each(json, function(index, data){
					html += '<div class="col">'
						 + '<div class="card h-100 shadow rounded">'
						 + '<a id="link" href="' + 'https://www.youtube.com/watch?v=' + data.id.videoId +'">'
				      	 + '<img src="' + data.snippet.thumbnails.high.url + '" class="card-img-top" height="300	" width="300" alt="...">'
				      	 + '<div class="card-body">'
				      	 + '<h5 class="card-title">' + data.snippet.title + '</h5></a>'
				      	 + '<span class="card-text">' + data.snippet.description + '</span>'
				      	 + '</div></div></div>';
				        
				})
				div.append(html);
			},
			error : function(xhr){
				alert(xhr.status + ' ' + xhr.statusText);
			}
		})
				$.ajax({
			url : '/ytnews4',
			data : {},
			success : function(json){
					var html = '';
				$.each(json, function(index, data){
					html += '<div class="col">'
						 + '<div class="card h-100 shadow rounded">'
						 + '<a id="link" href="' + 'https://www.youtube.com/watch?v=' + data.id.videoId +'">'
				      	 + '<img src="' + data.snippet.thumbnails.high.url + '" class="card-img-top" height="300	" width="300" alt="...">'
				      	 + '<div class="card-body">'
				      	 + '<h5 class="card-title">' + data.snippet.title + '</h5></a>'
				      	 + '<span class="card-text">' + data.snippet.description + '</span>'
				      	 + '</div></div></div>';
				        
				})
				div.append(html);
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
 <%@ include file="/include/chat.jsp" %>
 
	<div id="videocontents" class="row row-cols-1 row-cols-md-5 g-4 border border-light " style="margin: 10px 20px;">
	</div>
	
	<%@ include file="/include/bottomnav.jsp" %>
	
</body>
</html>