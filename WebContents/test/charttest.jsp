<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$( function() {
	/* $('#gubun').on('change', function() {
		$('#btnGetData').click();		
	});  */   
	   function addComma(value){
	        value = value.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	        return value; 
	    }
$.ajax( {
	//url     : 'http://localhost:9090/CovidStatus/covidstatus',
	url     : 'http://localhost:9090/countrycovidstatus',
	// data    : { gubun : $('#gubun').val() },
	type    : 'GET',
	success : function( xml ) {
		console.log(xml);
		var labelsArr = new Array();
		var dataArr = new Array(); 
		var xArr = new Array();
		var yArrnatDeathCntkor = new Array(); 
		var yArrnatDeathCntjap = new Array(); 
		var yArrnatDeathCntchi = new Array();
		var yArrnatDeathCntusa = new Array();
		var xArrGapnatDeathCntDate = new Array(); 
		var yArrGapnatDeathCntkor = new Array(); 
		var yArrGapnatDeathCntjap = new Array(); 
		var yArrGapnatDeathCntchi = new Array();
		var yArrGapnatDeathCntusa = new Array();
		var yArrnatDefCntkor = new Array(); 
		var yArrnatDefCntjap = new Array(); 
		var yArrnatDefCntchi = new Array();
		var yArrnatDefCntusa = new Array();
		var xArrGapnatDefCntDate = new Array(); 
		var yArrGapnatDefCntkor = new Array(); 
		var yArrGapnatDefCntjap = new Array(); 
		var yArrGapnatDefCntchi = new Array();
		var yArrGapnatDefCntusa = new Array();
		var html = '';
		$(xml).find('item').each(function( index ) {
			if($('#courseID').val()==null || $('#courseID').val()==""){
				
			var nationNM = $(this).find('nationNm').html(); 
			var areaNm = $(this).find('areaNm').html();
			var natDefCnt = $(this).find('natDefCnt').html();
			var natDeathCnt = $(this).find('natDeathCnt').html();
			var natDeathRate = $(this).find('natDeathRate').html();
			var stdDay = $(this).find('stdDay').html();
			
			
			
			
			html += '<tr class="row">';
			html += '<td id="area" class = "area">' + nationNM +'</td>';
			html += '<td>' + areaNm +'</td>';
			html += '<td>' + natDefCnt +'</td>';
			html += '<td>' + natDeathCnt +'</td>';
			html += '<td>' + natDeathRate +'</td>';
			html += '<td>' + stdDay +'</td>';
			html += '</tr>';

			
			
			
			
			
			if(nationNM=='한국'){	
			labelsArr.push(stdDay);
			dataArr.push(natDeathCnt);
			xArr.push(stdDay);
			yArrnatDeathCntkor.push(natDeathCnt);
			yArrnatDefCntkor.push(natDefCnt);
			

			
			}
			

			
			
			if(nationNM=='일본'){
				yArrnatDeathCntjap.push(natDeathCnt);
				yArrnatDefCntjap.push(natDefCnt);
			}
			if(nationNM=='중국'){
				yArrnatDeathCntchi.push(natDeathCnt);
				yArrnatDefCntchi.push(natDefCnt);
			}
			if(nationNM=='미국'){
				yArrnatDeathCntusa.push(natDeathCnt);
				yArrnatDefCntusa.push(natDefCnt);
			}
			
		
		
			
			}
			
			
			/* countrysaveFunction($(this).find('nationNm').html(), $(this).find('natDefCnt').html()); */
		})
		$('table').append(html)
		//차트2-----------------------------------------------
		// 일일 사망자
		var GapDeathCntKor ='';
		var GapDeathCntjap ='';
		var GapDeathCntchi ='';
		var GapDeathCntusa ='';
		// 일일 확진자
		var GapnatDefKor ='';
		var GapnatDefjap ='';
		var GapnatDefchi ='';
		var GapnatDefusa ='';
			console.log("yArrnatDeathCntkor:" + yArrnatDeathCntkor);
			console.log("yArrnatDeathCntjap:" + yArrnatDeathCntjap);
			console.log("yArrnatDeathCntchi:" + yArrnatDeathCntchi);
			console.log("yArrnatDeathCntusa:" + yArrnatDeathCntusa);
			console.log("yArrnatDefCntkor:" + yArrnatDefCntkor);
			console.log("yArrnatDeathCntjap:" + yArrnatDeathCntjap);
			console.log("yArrnatDeathCntchi:" + yArrnatDeathCntchi);
			console.log("yArrnatDeathCntusa:" + yArrnatDeathCntusa);
			console.log("xArr:" + xArr);
			console.log(xArr.shift()); // 배열 첫번째 빼기
			console.log(xArr); // 배열 첫번째뺀 값들
			// 사망자 전날과 비교하여 사망자수 확인
				for (var i = yArrnatDeathCntkor.length; i >= 0 ; i--) {
					if (isNaN(yArrnatDeathCntkor[i] - yArrnatDeathCntkor[i - 1])==false ) {
						//1일 사망자
					GapDeathCntKor = yArrnatDeathCntkor[i] - yArrnatDeathCntkor[i - 1]
					GapDeathCntjap = yArrnatDeathCntjap[i] - yArrnatDeathCntjap[i - 1]
					GapDeathCntchi = yArrnatDeathCntchi[i] - yArrnatDeathCntchi[i - 1]
					GapDeathCntusa = yArrnatDeathCntusa[i] - yArrnatDeathCntusa[i - 1]
					yArrGapnatDeathCntkor.push(GapDeathCntKor)
					yArrGapnatDeathCntjap.push(GapDeathCntjap)
					yArrGapnatDeathCntchi.push(GapDeathCntchi)
					yArrGapnatDeathCntusa.push(GapDeathCntusa)
					
					//1일 확진자
					GapnatDefKor = yArrnatDefCntkor[i] - yArrnatDefCntkor[i - 1]
					GapnatDefjap = yArrnatDefCntjap[i] - yArrnatDefCntjap[i - 1]
					GapnatDefchi = yArrnatDefCntchi[i] - yArrnatDefCntchi[i - 1]
					GapnatDefusa = yArrnatDefCntusa[i] - yArrnatDefCntusa[i - 1]
					yArrGapnatDefCntkor.push(GapnatDefKor)
					yArrGapnatDefCntjap.push(GapnatDefjap)
					yArrGapnatDefCntchi.push(GapnatDefchi)
					yArrGapnatDefCntusa.push(GapnatDefusa)
						
					}
				}
			
				
				
			console.log(yArrGapnatDefCntkor);
			console.log(yArrGapnatDefCntjap);
			console.log(yArrGapnatDefCntchi);
			console.log(yArrGapnatDefCntusa);
		var xValues = [100,200,300,400,500,600,700,800,900,1000];

		
		
				//차트------------------------------------------------------------------
				console.log('labelsArr[1]:' + labelsArr[1]);		
				console.log('dataArr[1]:' + dataArr[1]);
				const ctx1 = document.getElementById('myChart1')
						.getContext('2d');
				const myChart1 = new Chart(ctx1, {
					type : 'line',
					data : {
						labels : xArr, //x 축 제목  labelsArr = ['전국', '서울특별시', '부산광역시'  ......]
						datasets : [ 
							{
							label : '한국 확진자 현황', // 데이터 범례
							data : yArrGapnatDefCntkor, //y 축 숫자  dataArr = [40905177, 7652368, 2616908 ............]
							borderColor : "red",
							fill : false
						},
						{
							label : '일본 확진자 현황', // 데이터 범례
							data : yArrGapnatDefCntjap, //y 축 숫자  dataArr = [40905177, 7652368, 2616908 ............]
							borderColor : "green",
							fill : false
						},
						{
							label : '중국 확진자 현황', // 데이터 범례
							data : yArrGapnatDefCntchi, //y 축 숫자  dataArr = [40905177, 7652368, 2616908 ............]
							borderColor : "blue",
							fill : false
						},	
						{
							label : '미국 확진자 현황', // 데이터 범례
							data : yArrGapnatDefCntusa, //y 축 숫자  dataArr = [40905177, 7652368, 2616908 ............]
							borderColor : "cyan",
							fill : false
						}
						]
					},
					options : {
						scales : {
							y : {
								beginAtZero : true
							}
						}
					}
				});
				//차트------------------------------------------------------------------
				console.log('labelsArr[1]:' + labelsArr[1]);		
				console.log('dataArr[1]:' + dataArr[1]);
				const ctx2 = document.getElementById('myChart2')
						.getContext('2d');
				const myChart2 = new Chart(ctx2, {
					type : 'line',
					data : {
						labels : xArr, //x 축 제목  labelsArr = ['전국', '서울특별시', '부산광역시'  ......]
						datasets : [ 
							{
							label : '한국 사망자 현황', // 데이터 범례
							data : yArrGapnatDeathCntkor, //y 축 숫자  dataArr = [40905177, 7652368, 2616908 ............]
							borderColor : "red",
							fill : false
						},
						{
							label : '일본 사망자 현황', // 데이터 범례
							data : yArrGapnatDeathCntjap, //y 축 숫자  dataArr = [40905177, 7652368, 2616908 ............]
							borderColor : "green",
							fill : false
						},
						{
							label : '중국 사망자 현황', // 데이터 범례
							data : yArrGapnatDeathCntchi, //y 축 숫자  dataArr = [40905177, 7652368, 2616908 ............]
							borderColor : "blue",
							fill : false
						},	
						{
							label : '미국 사망자 현황', // 데이터 범례
							data : yArrGapnatDeathCntusa, //y 축 숫자  dataArr = [40905177, 7652368, 2616908 ............]
							borderColor : "cyan",
							fill : false
						}
						]
					},
					options : {
						scales : {
							y : {
								beginAtZero : true
							}
						}
					}
				});
				
				
			},
			error : function(xhr) {
				alert(xhr.status + ':' + xhr.statusText);
			}
		})
		
		
		
	})
</script>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div>
   		<canvas id="myChart1" style="width:100%;max-width:600px"></canvas>
   </div>
<div>
   		<canvas id="myChart2" style="width:100%;max-width:600px"></canvas>
   </div>
   
  	
   	
</body>
</html>