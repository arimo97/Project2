<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	 
<meta name="viewport" content="width=device-width, initial-scale=1">

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.bundle.min.js" ></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.min.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.min.js"></script> -->
<script src="https://cdn.jsdelivr.net/npm/chart.js@3.6.2/dist/chart.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.6.2/chart.esm.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.6.2/helpers.esm.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" />
  <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/js/bootstrap.bundle.min.js"></script>
  <link rel="stylesheet" href="/css/prj2.css">
<style>
</style>
<script>
/*
  {
	"currentCount": 10,
	"data": [
		{
			"accumulatedFirstCnt": 42421599,
			"accumulatedSecondCnt": 40767383,
			"accumulatedThirdCnt": 2478097,
			"baseDate": "2021-11-27 00:00:00",
			"firstCnt": 54302,
			"id": 4705,
			"secondCnt": 84823,
			"sido": "전국",
			"thirdCnt": 284323,
			"totalFirstCnt": 42475901,
			"totalSecondCnt": 40852206,
			"totalThirdCnt": 2762420
		},
 
 */
 
 /*

 	window.onload = function() {
		var btn = document.getElementById('btnGetData');
		btn.onclick = function() {
			var xhr = new XMLHttpRequest();
			xhr.onreadystatechange = function() {
				if (xhr.readyState == 4) {
					if (xhr.status == 200) {
						var get_data = xhr.responseText;
						var obj = JSON.parse(get_data);
						
						var div1 = document.getElementById('div1');
						var data = obj.data;
						var tag = '';
							tag += '<ol>';
							tag += '<il>';
							tag += 'color:' + data.color + '<br>' +
							'data:'+ data.id + '<br>' +
							'name:'+ data.name + '<br>'+
							'value:'+ data.pantone_value + '<br>'+
							'year:'+ data.year + '<br>';
							tag += '</il>';
							tag += '</ol>';
						div1.innerHTML = tag; 
					}
				}
			}
			var number = document.getElementById('num');
			xhr.open('GET', 'https://reqres.in/api/product/' + number.value, true);
			xhr.send();
		}
	}
 
 */
 
 
 /*
	v.add(tmp.get("sido").toString()); 
	v.add(tmp.get("firstCnt").toString()); 
	v.add(tmp.get("secondCnt").toString()); 
	v.add(tmp.get("accumulatedFirstCnt").toString()); 
	v.add(tmp.get("accumulatedSecondCnt").toString());
	v.add(tmp.get("baseDate").toString()); 
 */
	window.onload = function() {
	 
			var sido = '${ sido }';
			if('${ sido }' == '서울')
				sido = '서울특별시';
			if('${ sido }' == '부산')
				sido = '부산광역시';
			if('${ sido }' == '대구')
				sido = '대구광역시';
			if('${ sido }' == '인천')
				sido = '인천광역시';
			if('${ sido }' == '대전')
				sido = '대전광역시';
			if('${ sido }' == '세종')
				sido = '세종특별자치시';
			if('${ sido }' == '울산')
				sido = '울산광역시';
			if('${ sido }' == '경기')
				sido = '경기도';
			if('${ sido }' == '강원')
				sido = '강원도';
			if('${ sido }' == '충북')
				sido = '충청북도';
			if('${ sido }' == '충남')
				sido = '충청남도';
			if('${ sido }' == '전북')
				sido = '전라북도';
			if('${ sido }' == '전남')
				sido = '전라남도';
			if('${ sido }' == '경북')
				sido = '경상북도';
			if('${ sido }' == '경남')
				sido = '경상남도';
			if('${ sido }' == '제주')
				sido = '제주특별자치도';
	 		
			var xhr = new XMLHttpRequest();
			xhr.onreadystatechange = function() {
				if (xhr.readyState == 4 && xhr.status == 200) {
						var get_data = xhr.responseText;
						var obj = JSON.parse(get_data);
						
						var data = obj.data;
						var html = '<thead><tr>'+
						       '<th>시도</th>'+
						       '<th>당일1차 접종통계</th>'+
						       '<th>당일2차 접종통계</th>'+
						       '<th>당일3차 접종통계</th>'+
						       '<th>1차 접종 누적 통계</th>'+
						       '<th>2차 접종 누적 통계</th>'+
						       '<th>3차 접종 누적 통계</th>'+
						       '<th>1차 접종률</th>'+
						       '<th>2차 접종률</th>'+
						       '<th>3차 접종률</th>'+
						       '<th>기준일</th>'+
						       '</tr></thead><tbody>';
						       
						var labelsArr_baseDate = new Array();
						var dataArr_sido = new Array(); 
						var dataArr_all = new Array(); 
/* 						var dataArr_seoul = new Array(); 
						var dataArr_busan = new Array(); 
						var dataArr_jeju = new Array(); 
						var dataArr_deagu = new Array(); 
						var dataArr_inchon = new Array(); 
						var dataArr_gwangju = new Array(); 
						var dataArr_sejong = new Array(); 
						var dataArr_deajon = new Array(); 
						var dataArr_gyeonggi = new Array(); 
						var dataArr_ulsan = new Array(); 
						var dataArr_gangwon = new Array(); 
						var dataArr_chungbuk = new Array(); 
						var dataArr_chungnam = new Array(); 
						var dataArr_junbuk = new Array(); 
						var dataArr_junnam = new Array(); 
						var dataArr_gungnam = new Array(); 
						var dataArr_gungbuk = new Array();
						
						var dataArr_1st = new Array();
						var dataArr_2nd = new Array();
						var dataArr_3rd = new Array();
						var dataArr_4th = new Array(); */
						
						var dataArr_all1st = new Array();
						var dataArr_all2nd = new Array();
						var dataArr_all3rd = new Array();
						
						var dataArr_sido1st = new Array();
						var dataArr_sido2nd = new Array();
						var dataArr_sido3rd = new Array();

						data.forEach( function( ele, index ) {
							
							var vaccine1_ratio = (ele.totalFirstCnt / ele.population * 100).toFixed(1);
							var vaccine2_ratio = (ele.totalSecondCnt / ele.population * 100).toFixed(1);
							var vaccine3_ratio = (ele.totalThirdCnt / ele.population * 100).toFixed(1);
							
							html += '<tr>';
							html += '<td>' + ele.sido +'</td>';
							html += '<td>' + ele.firstCnt +'</td>';
							html += '<td>' + ele.secondCnt +'</td>';
							html += '<td>' + ele.thirdCnt +'</td>';
							html += '<td>' + ele.totalFirstCnt +'</td>';
							html += '<td>' + ele.totalSecondCnt +'</td>';
							html += '<td>' + ele.totalThirdCnt +'</td>';
							html += '<td>' + vaccine1_ratio +'</td>';
							html += '<td>' + vaccine2_ratio +'</td>';
							html += '<td>' + vaccine3_ratio +'</td>';
							html += '<td>' + ele.baseDate +'</td>';
							html += '</tr>'; 
							
							
							if (ele.sido == '전국'){
								dataArr_all1st.push(vaccine1_ratio);
								dataArr_all2nd.push(vaccine2_ratio);
								dataArr_all3rd.push(vaccine3_ratio);
							}
							
							if (sido == ele.sido){
								dataArr_sido1st.push(vaccine1_ratio);
								dataArr_sido2nd.push(vaccine2_ratio);
								dataArr_sido3rd.push(vaccine3_ratio);
								labelsArr_baseDate.push((ele.baseDate).substring(5));
							}
							
							/* if (sido != '서울특별시' && ele.sido == '서울특별시')
								dataArr_seoul.push(ele.accumulatedSecondCnt);
							if (sido != '부산광역시' && ele.sido == '부산광역시')
								dataArr_busan.push(ele.accumulatedSecondCnt);
							if (sido != '대구광역시' && ele.sido == '대구광역시')
								dataArr_deagu.push(ele.accumulatedSecondCnt);
							if (sido != '인천광역시' && ele.sido == '인천광역시')
								dataArr_inchon.push(ele.accumulatedSecondCnt);
							if (sido != '광주광역시' && ele.sido == '광주광역시')
								dataArr_gwangju.push(ele.accumulatedSecondCnt);
							if (sido != '대전광역시' && ele.sido == '대전광역시')
								dataArr_deajon.push(ele.accumulatedSecondCnt);
							if (sido != '세종특별자치시' && ele.sido == '세종특별자치시')
								dataArr_sejong.push(ele.accumulatedSecondCnt);
							if (sido != '울산광역시' && ele.sido == '울산광역시')
								dataArr_ulsan.push(ele.accumulatedSecondCnt);
							if (sido != '경기도' && ele.sido == '경기도')
								dataArr_gyeonggi.push(ele.accumulatedSecondCnt);
							if (sido != '강원도' && ele.sido == '강원도')
								dataArr_gangwon.push(ele.accumulatedSecondCnt);
							if (sido != '충청북도' && ele.sido == '충청북도')
								dataArr_chungbuk.push(ele.accumulatedSecondCnt);
							if (sido != '충청남도' && ele.sido == '충청남도')
								dataArr_chungnam.push(ele.accumulatedSecondCnt);
							if (sido != '전라북도' && ele.sido == '전라북도')
								dataArr_junbuk.push(ele.accumulatedSecondCnt);
							if (sido != '전라남도' && ele.sido == '전라남도')
								dataArr_junnam.push(ele.accumulatedSecondCnt);
							if (sido != '경상북도' && ele.sido == '경상북도')
								dataArr_gungbuk.push(ele.accumulatedSecondCnt);
							if (sido != '경상남도' && ele.sido == '경상남도')
								dataArr_gungnam.push(ele.accumulatedSecondCnt);
							if (sido != '제주특별자치도' && ele.sido == '제주특별자치도')
								dataArr_jeju.push(ele.accumulatedSecondCnt); */
							
							
						 });
						html += '</tbody>'
						document.getElementsByTagName('table')[0].innerHTML = html;
						
						
						dataArr_all1st.reverse();
						dataArr_all2nd.reverse();
						//alert(dataArr_all2nd.reverse());
						dataArr_all3rd.reverse();
						//alert(dataArr_all3rd.reverse());
						
						dataArr_sido1st.reverse();
						dataArr_sido2nd.reverse();
						dataArr_sido3rd.reverse();
						
						labelsArr_baseDate.reverse();
/* 						dataArr_sido.reverse(); 
						dataArr_all.reverse(); 
						dataArr_seoul.reverse(); 
						dataArr_busan.reverse(); 
						dataArr_jeju.reverse(); 
						dataArr_deagu.reverse(); 
						dataArr_inchon.reverse(); 
						dataArr_gwangju.reverse(); 
						dataArr_sejong.reverse(); 
						dataArr_deajon.reverse(); 
						dataArr_gyeonggi.reverse(); 
						dataArr_ulsan.reverse(); 
						dataArr_gangwon.reverse(); 
						dataArr_chungbuk.reverse(); 
						dataArr_chungnam.reverse(); 
						dataArr_junbuk.reverse(); 
						dataArr_junnam.reverse(); 
						dataArr_gungnam.reverse(); 
						dataArr_gungbuk.reverse(); */
						
						const ctx1 = document.getElementById('myChart1').getContext('2d');
						const bColor = [ 'rgba(255, 99, 132, 1)', 'rgba(54, 162, 235, 1)', 'rgba(255, 206, 86, 1)', 'rgba(75, 192, 192, 1)', 'rgba(153, 102, 255, 1)', 'rgba(255, 159, 64, 1)' ];
						const myChart1 = new Chart(ctx1, {
							type: 'line',
						    data: {
						        labels: labelsArr_baseDate,
						        datasets: [{
						            label: sido + ' 2차 접종률', 
						            data: dataArr_sido2nd,
						            borderWidth: 3,
						            borderColor: '#A4D0F2',
						            backgroundColor: "#A4D0F2",
						            hoverBorderWidth: 5,
						            hoverBorderColor: 'skyblue',
						            order : 1
						        },
						        {
					        	  label: '전국 2차 접종률',
						            data: dataArr_all2nd,
						            borderWidth: 3,
						            borderColor: '#EFC8C7',
						            backgroundColor: "#EFC8C7",
						            hoverBorderWidth: 5,
						            hoverBorderColor: 'skyblue',
						            order : 2
						        },
						        {
						            label: sido + ' 1차 접종률',
						            data: dataArr_sido1st,
						            borderWidth: 3,
						            borderColor: '#F5DF57',
						            backgroundColor: "#F5DF57",
						            hoverBorderWidth: 5,
						            hoverBorderColor: 'skyblue',
						            order : 3
						        },
						        {
					        	  label: '전국 1차 접종률',
						            data: dataArr_all1st,
						            borderWidth: 3,
						            borderColor: '#a77efc',
						            backgroundColor: "#a77efc",
						            hoverBorderWidth: 5,
						            hoverBorderColor: 'skyblue',
						            order : 4
						        }
						        ]
						    },
						    options: {
						        scales: {
						            y: {
						                beginAtZero: false
						            }
						          
						        },
						        title: {
					                display: true,
					                text: '우리 지역 1차, 2차 접종률'
					            }
						    }
						});
						
						const ctx2 = document.getElementById('myChart2').getContext('2d');
						const myChart2 = new Chart(ctx2, {
							type: 'line',
						    data: {
						        labels: labelsArr_baseDate,
						        datasets:[{
						            label: sido + ' 3차 접종률',
						            data: dataArr_sido3rd, 
						            borderWidth: 3,
						            hoverBorderWidth: 5,
						            hoverBorderColor: 'skyblue',
						            backgroundColor: "#DD3464",
						            borderColor: '#DD3464',
						            order : 1
						        },
						        {
						        	label: '전국 3차 접종률',
						            data: dataArr_all3rd, 
						            borderWidth: 3,
						            hoverBorderWidth: 5,
						            hoverBorderColor: 'skyblue',
						            backgroundColor: "#7A9BB9",
						            borderColor: '#7A9BB9',
						            order : 2
						        }
						        ]
						    },
						    options: {
						        scales: {
						            y: {
						                beginAtZero: false
						                }
						    },
						    title: {
						    	display: true,
						    	text: '우리지역 3차 접종률'
						    }
						    }
						    });
						}
				}
			xhr.open('GET', '/vaccinestaticsevlet?period=5', true);
			xhr.send();
		}
 
 
	 /* 
	 
	 function getRandomColor() {
			return "#" + Math.floor(Math.random() * 16777215).toString(16);
		}
 
	$(function(){
		$.ajax({
			url : '/vaccinestaticsevlet',
			datatype : 'json',
			success : function (json){
				var data = json.data;
				
				var labelsArr = new Array();
				var dataArr = new Array(); 
				var html = '';
				$.each(data, function(index, ele){
					html += '<tr class="row">';
					html += '<td id="area" class = "area">' + ele.sido +'</td>';
					html += '<td>' + ele.firstCnt +'</td>';
					html += '<td>' + ele.secondCnt +'</td>';
					html += '<td>' + ele.accumulatedFirstCnt +'</td>';
					html += '<td>' + ele.accumulatedSecondCnt +'</td>';
					html += '<td>' + ele.baseDate +'</td>';
					html += '</tr>';
					
					labelsArr.push(ele.sido);
					dataArr.push(ele.accumulatedSecondCnt);
					
					
				})
				
				$('table').append(html)
				
				//차트------------------------------------------------------------------
				const ctx = document.getElementById('myChart').getContext('2d');
				const myChart = new Chart(ctx, {
				    type: 'line',
				    data: {
				        labels: labelsArr, //x 축 제목  labelsArr = ['전국', '서울특별시', '부산광역시'  ......]
				        datasets: [{
				            label: '2차 접종 누적 통계', // 데이터 범례
				            data: dataArr, //y 축 숫자  dataArr = [40905177, 7652368, 2616908 ............]
				            borderWidth: 1
				        }]
				    },
				    options: {
				        scales: {
				            y: {
				                beginAtZero: true
				            },
				            normalized: true
				        }
				    }
				});
			},
			error : function(xhr){
				alert(xhr.status + ':' + xhr.statusText);
			}
			})
	}) 
	
	*/
	
	
	
/* 	window.onload = function(){
 		var myChart2 = document.getElementById('myChart2');
		var xValues = [ '21.01', '21.02', '21.03', '21.04', '21.05', '21.06', '21.07', '21.08', '21.09', '21.10', '21.11', '21.12' ];
		var yValues = [ 7, 8, 8, 9, 9, 9, 10, 11, 14, 14, 15, 14];
	

		new Chart(myChart2, {
			type : "line",
			data : {
				labels : xValues,
				datasets : [ {
					fill : false,
					lineTension : 0,
					backgroundColor : "rgba(0,0,255,1.0)",
					borderColor : "rgba(0,0,255,0.1)",
					data : yValues
				} ]
			},
			options : {
				legend : {
					display : true
				},
				scales : {
					yAxes : [ {
						ticks : {
							min : 6,
							max : 16
						}
					} ],
				}
			}
		}); 
	}
 */
			
	function myFunction() {
		var x = document.getElementById("myTopnav");
		if (x.className === "topnav") {
			x.className += " responsive";
		} else {
			x.className = "topnav";
		}
	}
</script>
</head>
<body>

 <%@ include file="/include/toptopnav.jsp" %>

 <div class="title" id="mytitle"><h2>예방접종현황</h2></div>
 <%@ include file="/include/topnav.jsp" %>
	
	<div class="container-fluid">
	<div class="row">
	<div class="col col-sm-6 shadow rounded">
   		<canvas id="myChart1" ></canvas>
   	</div>
   	<div class="col col-sm-6 shadow rounded" >
   		<canvas id="myChart2"></canvas>
   </div>
   </div>
  
   </div>
   
   <table class="table table-striped">
   </table>
   
 
   
    <%@ include file="/include/bottomnav.jsp" %>
  
  
  

  
</body>
</html>