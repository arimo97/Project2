<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>  
<!-- 165 날짜 형식 변환 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"> -->
<title>Insert title here</title>
<style></style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js@3.6.2/dist/chart.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.6.2/chart.esm.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.6.2/helpers.esm.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/js/bootstrap.min.js" integrity="sha512-OvBgP9A2JBgiRad/mM36mkzXSXaJE9BEIENnVEmeZdITvwT09xnxLtT4twkCa8m/loMbPHsvPl0T8lRGVBwjlQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" />
  <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/js/bootstrap.bundle.min.js"></script>  
  <link rel="stylesheet" href="/css/prj2.css">
<script>
$( function() {
   


})
</script>


<script>

// chart type 213 , 415---------------------------------------
// header 461
function  header() {
	
	var head = '<thead>';
	head = '<tr>';
	head += '<th>시도명</th>';
	head += '<th>확진자 수</th>';
	head += '<th>사망자 수</th>';
	head += '<th>전일대비 증감 수</th>';
	head += '<th>지역발생 수</th>';
    head += '<th>격리 해제 수</th>';
    head += '<th>10만명당 발생률</th>';
    head += '<th>기준일시</th>';
    head += '</tr>'; 
    head += '</thead>'; 
		return head;
	}


var sido      = '${ sido }';

// 시도 변환

if(sido == '서울특별시')
    sido = '서울';
 if(sido == '부산광역시')
    sido = '부산';
 if(sido == '대구광역시')
    sido = '대구';
 if(sido == '인천광역시')
    sido = '인천';
 if(sido == '대전광역시')
    sido = '대전';
 if(sido == '세종특별자치시')
    sido = '세종';
 if(sido == '울산광역시')
    sido = '울산';
 if(sido == '경기도')
    sido = '경기';
 if(sido == '강원도')
    sido = '강원';
 if(sido == '충청북도')
    sido = '충북';
 if(sido == '충청남도')
    sido = '충남';
 if(sido == '전라북도')
    sido = '전북';
 if(sido == '전라남도')
    sido = '전남';
 if(sido == '경상북도')
    sido = '경북';
 if(sido == '경상남도')
    sido = '경남';
 if(sido == '제주특별자치도')
    sido = '제주';


function myFunction() {
     var x = document.getElementById("myTopnav");
     if (x.className === "topnav") {
       x.className += " responsive";
     } else {
       x.className = "topnav";
     }
   }
   
   // shift enter키 사용, enter키 전송
   
   function enterkey(){
	   if (window.event.keyCode==13){
			var button = document.getElementById('chart1searchbutton');
			button.click();

		}
   }
   
   
   function stopgetsearch() {
            $("#myChart3").empty();
            $("#row").empty();

         }

   $(function(){
      nosearchchartrun();
      nosearchtablerun();
      
   // 검색 초기화
      
   $("#nosearchtablerunbutton").on({
      "click" : function(){
    	  alert("초기화");
         location.reload();
      }
         
      
   })
   
   
   $("#chart1searchbutton").on({
      "click" : function(){
         stopgetsearch();
         
         var chart1search = document.getElementById('chart1search').value;
         chartrun(chart1search);
         searchtablerun(chart1search);
         console.log(chart1search);
          $("#search").css("display", "block");
          $(".table2").css("display", "block");
          $("#nonesearch").css("display", "none");
          $(".table1").css("display", "none");
      }
         
      
   })
   })
   

   /* $('#gubun').on('change', function() {
      $('#btnGetData').click();      
   });  */   
   //처음 chart실행
   function nosearchchartrun(){
     $("#search").css("display", "none");
       $(".table2").css("display", "none");
      function addComma(value){
           value = value.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
           return value; 
       }
      $.ajax( {
         //url     : 'http://localhost:9090/CovidStatus/covidstatus',
         url     : 'http://localhost:9090/covidstatuschart',
          data    : { period : 15 },
         type    : 'GET',
         success : function( xml ) {
            console.log(xml);
            var xArr = new Array();
            var yArrBusan = new Array(); 
            var yArrSeoul = new Array(); 
            var yArrGyunggi = new Array(); 
            var yArrInchon = new Array(); 
            var yArrUser = new Array(); 
            
            
            // console.log("uSido : " + uSido);
            
/*          var set1 = new Set();
            var set2 = new Set();
            var set3 = new Set();
            var set4 = new Set();
            var set5 = new Set(); */
            
            var name1 = '';
            var name2 = '';
            var name3 = '';
            var name4 = '';
            var name5 = '';
            
            var yArr1 = new Array(); 
            var yArr2 = new Array(); 
            var yArr3 = new Array(); 
            var yArr4 = new Array(); 
            var yArr5 = new Array(); 
            
            var yArrinc1 = new Array(); 
            var yArrinc2 = new Array(); 
            var yArrinc3 = new Array(); 
            var yArrinc4 = new Array(); 
            var yArrinc5 = new Array(); 
            
            
            
            $("#chart1searchbutton").on({
               "click" : function(){
                  var chart1search = document.getElementById('chart1search').value;
                  console.log(chart1search);
               }
               
            })
            

                
            var html = '<tbody>';
            
            $(xml).find('item').each(function( index ) {
            	
            	// 확진자수 높은 4 지역과 주소에 기록된 지역
            	
               if($('#courseID').val()==null || $('#courseID').val()==""){
                  
                  var gubun = $(this).find('gubun').html(); 
                  var defCnt = $(this).find('defCnt').html();
                  var deathCnt = $(this).find('deathCnt').html();
                  var incDec = $(this).find('incDec').html();
                  var localOccCnt = $(this).find('localOccCnt').html();
                  var isolClearCnt = $(this).find('isolClearCnt').html();
                  var qurRate = $(this).find('qurRate').html();
                  var stdDay = $(this).find('stdDay').html();
                  
                  
                  
                  html += '<tr >';
                  html += '<td >' + gubun +'</td>';
                  html += '<td>' + defCnt +'</td>';
                  html += '<td>' + deathCnt +'</td>';
                  html += '<td>' + incDec +'</td>';
                  html += '<td>' + localOccCnt +'</td>';
                  html += '<td>' + isolClearCnt +'</td>';
                  html += '<td>' + qurRate +'</td>';
                  html += '<td>' + stdDay +'</td>';
                  html += '</tr>';
               
                  
                  // set1.add(0+(19*index)); // 합계
                  // set1.add(1+(19*index)); // 서울
                  
                  //set1.add(1+(19*index));  // 중간에 검역이 끼어 있어서 19로 해야함
              	
                  //set2.add(2+(19*index)); 
                  	
                  //set3.add(3+(19*index)); 
                  	
                  //set4.add(4+(19*index)); 
                  
                  // 이름은 처음 값만 받으면 됨
                  
                  if(index == 1){
                	  name1 = gubun;
                  }
                  if(gubun==name1) {
                	  yArr1.push(defCnt);
                	  yArrinc1.push(incDec);
                	  xArr.push(stdDay);	  
                  }
                  
                  if(index == 2){
                	  name2 = gubun;
                  }
                  if(gubun==name2) {
                	  yArr2.push(defCnt);
                	  yArrinc2.push(incDec);
                  }
                  
                  if(index == 3){
                	  name3 = gubun;
                  }
                  if(gubun==name3) {
                	  yArr3.push(defCnt);
                	  yArrinc3.push(incDec);
                  }
                  
                  if(index == 4){
                	  name4 = gubun;
                  }
                  if(gubun==name4) {
                	  yArr4.push(defCnt);	
                	  yArrinc4.push(incDec);
                  }
                	  
                  if(gubun==sido){   
              	   	yArr5.push(defCnt);
              	    yArrinc5.push(incDec);
                 	}
                  
                  
                	// console.log(set1.has(1));
                      
                      // alert("set1" + set1.values());   	  
                	  
                	  
               /* if(gubun=='부산'){  
               yArrBusan.push(defCnt);
              // xArr.push(stdDay);
               
               }
               
               if(gubun=='서울'){   
               yArrSeoul.push(defCnt);
               
               }
               if(gubun=='경기'){   
               yArrGyunggi.push(defCnt);
               
               }
               if(gubun=='인천'){   
               yArrInchon.push(defCnt);
               
               } */          
               
               }
               
               /* countrysaveFunction($(this).find('nationNm').html(), $(this).find('natDefCnt').html()); */
            })
            
             // console.log(set2);
            
            //차트2-----------------------------------------------

               /* console.log("xArr:" + xArr);
               console.log("yArrBusan:" + yArrBusan);
               console.log("yArrSeoul:" + yArrSeoul);
               console.log("yArrGyunggi:" + yArrGyunggi);
               console.log("yArrInchon:" + yArrInchon);
               console.log("yArr1:" + yArr1);
               console.log("yArr2:" + yArr2);
               console.log("yArr3:" + yArr3);
               console.log("yArr4:" + yArr4); */
      
                  var hd = false;
            if(sido==name1||sido==name2||sido==name3||sido==name4){
            	hd = true;
            }
            
                  //차트1------------------------------------------------------------------
                  const ctx1 = document.getElementById('myChart1')
                        .getContext('2d');
                  const myChart1 = new Chart(ctx1, {
                     type : 'line',
                     data : {
                        labels : xArr, //x 축 제목  labelsArr = ['전국', '서울특별시', '부산광역시'  ......]
                        datasets : [ 
                           {
                           label : sido, // 데이터 범례
                           data : yArr5, //y 축 숫자  dataArr = [40905177, 7652368, 2616908 ............]
                           borderColor : "black",
							backgroundColor : "black",
                           fill : false,
                           hidden: hd
                        },
                           {
                           label : name1, // 데이터 범례
                           data : yArr1, //y 축 숫자  dataArr = [40905177, 7652368, 2616908 ............]
                           borderColor : "red",
							backgroundColor : "red",
                           fill : false
                        },
                           {
                           label : name2, 
                           data : yArr2, 
                           borderColor : "green",
							backgroundColor : "green",
                           fill : false
                        },
                           {
                           label : name3, 
                           data : yArr3, 
                           borderColor : "blue",
							backgroundColor : "blue",
                           fill : false
                        },
                           {
                           label : name4, 
                           data : yArr4, 
                           borderColor : "yellow",
							backgroundColor : "yellow",
                           fill : false
                        }
                        ]
                     },
                     options : {
                    	 // 라벨이 아예 안뜨게만 가능
                    	 /* legend: {
                    	      labels: {
                    	        filter: function(item, chart) {
                    	          if(sido==name1||sido==name2||sido==name3||sido==name4) {
                    	        	  return false;
                    	          } else {
                                      return true;
                                  }
                    	        }
                    	      }
                    	    }, */
                    	 /* filter: function (tooltipItem, data) {
                             var label = data.labels[tooltipItem.index];
                             console.log(tooltipItem, data, label);
                             if (label == sido) {
                               return false;
                             } else {
                               return true;
                             }
                         }, */
                    	 title : {
                    		/*  display: true,
                    	      text: "확진자 현황" */
                    	 }

                     }
                  });// chart1
                  
                  
            //--chart2---------------------------------------
                  const ctx2 = document.getElementById('myChart2')
                  .getContext('2d');
            const myChart2 = new Chart(ctx2, {
               type : 'line',
               data : {
                  labels : xArr, //x 축 제목  labelsArr = ['전국', '서울특별시', '부산광역시'  ......]
                  datasets : [ 
                     {
                     label : sido, // 데이터 범례
                     data : yArrinc5, //y 축 숫자  dataArr = [40905177, 7652368, 2616908 ............]
                     borderColor : "black",
						backgroundColor : "black",
                     fill : false,
                     hidden: hd
                  },
                     {
                     label : name1, // 데이터 범례
                     data : yArrinc1, //y 축 숫자  dataArr = [40905177, 7652368, 2616908 ............]
                     borderColor : "red",
						backgroundColor : "red",
                     fill : false
                  },
                     {
                     label : name2, 
                     data : yArrinc2, 
                     borderColor : "green",
						backgroundColor : "green",
                     fill : false
                  },
                     {
                     label : name3, 
                     data : yArrinc3, 
                     borderColor : "blue",
						backgroundColor : "blue",
                     fill : false
                  },
                     {
                     label : name4, 
                     data : yArrinc4, 
                     borderColor : "yellow",
						backgroundColor : "yellow",
                     fill : false
                  }
                  ]
               },
               options : {
              	 // 라벨이 아예 안뜨게만 가능
              	 /* legend: {
              	      labels: {
              	        filter: function(item, chart) {
              	          if(sido==name1||sido==name2||sido==name3||sido==name4) {
              	        	  return false;
              	          } else {
                                return true;
                            }
              	        }
              	      }
              	    }, */
              	 /* filter: function (tooltipItem, data) {
                       var label = data.labels[tooltipItem.index];
                       console.log(tooltipItem, data, label);
                       if (label == sido) {
                         return false;
                       } else {
                         return true;
                       }
                   }, */
              	 title : {
              		/*  display: true,
              	      text: "확진자 현황" */
              	 }

               }
            }); // chart2
                  
               }, // success
               error : function(xhr) {
                  alert(xhr.status + ':' + xhr.statusText);
               }
            })
            
         } // nonserchrun
            
   //비검색 table 출력--------------------------------------------------------------
   function nosearchtablerun(){
      function addComma(value){
           value = value.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
           return value; 
       }
      
      $.ajax( {
         //url     : 'http://localhost:9090/CovidStatus/covidstatus',
         url     : 'http://localhost:9090/covidstatustable',
         // data    : { gubun : $('#gubun').val() },
         type    : 'GET',
         success : function( xml ) {
            console.log(xml);

            
            
            var html = '<tbody>';
            $(xml).find('item').each(function( index ) {
            	
            	
            	
               var gubun = $(this).find('gubun').html(); 
               var defCnt = $(this).find('defCnt').html();
               var deathCnt = $(this).find('deathCnt').html();
               var incDec = $(this).find('incDec').html();
               var localOccCnt = $(this).find('localOccCnt').html();
               var isolClearCnt = $(this).find('isolClearCnt').html();
               var qurRate = $(this).find('qurRate').html();
               var stdDay = $(this).find('stdDay').html();
               
               
               html += '<tr >';
               html += '<td >' + gubun +'</td>';
               html += '<td>' + defCnt +'</td>';
               html += '<td>' + deathCnt +'</td>';
               html += '<td>' + incDec +'</td>';
               html += '<td>' + localOccCnt +'</td>';
               html += '<td>' + isolClearCnt +'</td>';
               html += '<td>' + qurRate +'</td>';
               html += '<td>' + stdDay +'</td>';
               html += '</tr>';
               
               
               /* countrysaveFunction($(this).find('nationNm').html(), $(this).find('natDefCnt').html()); */
            })
            html += '</tbody>';
            console.log('table1' + html);
            $('#table1').append(html)
            
                     
               
                  
                  
               },
               error : function(xhr) {
                  alert(xhr.status + ':' + xhr.statusText);
               }
            })
            
         }
   
   
   
   
   /* $('#gubun').on('change', function() {
      $('#btnGetData').click();      
   });  */   
   // 검색시 실행
      function chartrun(chart1search){
      
	  

      function addComma(value){
           value = value.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
           return value; 
       }
      
      $.ajax( {
         //url     : 'http://localhost:9090/CovidStatus/covidstatus',
         url     : 'http://localhost:9090/covidstatuschart',
          data    : { period : 15 },
         type    : 'GET',
         success : function( xml ) {
            console.log(xml);
            var xArr = new Array();
            var yArrUser = new Array(); 
            var yArrUserinc = new Array(); 
            var yArrSearch = new Array(); 
            var yArrSearchinc = new Array(); 
            
            
            var html = '';
            
            $(xml).find('item').each(function( index ) {
               if($('#courseID').val()==null || $('#courseID').val()==""){
                  
                  var gubun = $(this).find('gubun').html(); 
                  var defCnt = $(this).find('defCnt').html();
                  var deathCnt = $(this).find('deathCnt').html();
                  var incDec = $(this).find('incDec').html();
                  var localOccCnt = $(this).find('localOccCnt').html();
                  var isolClearCnt = $(this).find('isolClearCnt').html();
                  var qurRate = $(this).find('qurRate').html();
                  var stdDay = $(this).find('stdDay').html();

                  
                  html += '<tr class="row" id="row">';
                  html += '<td id="area" class = "area">' + gubun +'</td>';
                  html += '<td>' + defCnt +'</td>';
                  html += '<td>' + deathCnt +'</td>';
                  html += '<td>' + incDec +'</td>';
                  html += '<td>' + localOccCnt +'</td>';
                  html += '<td>' + isolClearCnt +'</td>';
                  html += '<td>' + qurRate +'</td>';
                  html += '<td>' + stdDay +'</td>';
                  html += '</tr>';
               
             	  
              	if(gubun==sido){   
            	   	yArrUser.push(defCnt);
            	   	yArrUserinc.push(incDec);
               		xArr.push(stdDay);
               	}
                 
                  
                  console.log("sido : " + sido);
                  
               if(gubun==chart1search){   
                  yArrSearch.push(defCnt);
                  yArrSearchinc.push(incDec);

               
               }
                  
                        
               
               }
               
               
               /* countrysaveFunction($(this).find('nationNm').html(), $(this).find('natDefCnt').html()); */
            })
            //차트2-----------------------------------------------

               console.log("xArr:" + xArr);
               console.log("yArrUser:" + yArrUser);
               console.log("yArrSearch:" + yArrSearch);
               console.log("sido:" + sido);
               
               
      
                  
                  

   
            
                  //차트3------------------------------------------------------------------
                  const ctx1 = document.getElementById('myChart3')
                        .getContext('2d');
                  const myChart1 = new Chart(ctx1, {
                     type : 'line',
                     data : {
                        labels : xArr, //x 축 제목  labelsArr = ['전국', '서울특별시', '부산광역시'  ......]
                        datasets : [ 
                           {
                           label : sido + '확진자 현황', // 데이터 범례
                           data : yArrUser, //y 축 숫자  dataArr = [40905177, 7652368, 2616908 ............]
                           borderColor : "red",
                           fill : false
                        },
                        {
                           label : chart1search + '확진자 현황', // 데이터 범례
                           data : yArrSearch, //y 축 숫자  dataArr = [40905177, 7652368, 2616908 ............]
                           borderColor : "green",
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
                  //차트4------------------------------------------------------------------
                  const ctx2 = document.getElementById('myChart4')
                        .getContext('2d');
                  const myChart4 = new Chart(ctx2, {
                     type : 'line',
                     data : {
                        labels : xArr, //x 축 제목  labelsArr = ['전국', '서울특별시', '부산광역시'  ......]
                        datasets : [ 
                           {
                           label : sido + '확진자 전일대비 증감 수', // 데이터 범례
                           data : yArrUserinc, //y 축 숫자  dataArr = [40905177, 7652368, 2616908 ............]
                           borderColor : "red",
                           fill : false
                        },
                        {
                           label : chart1search + '확진자 전일대비 증감 수', // 데이터 범례
                           data : yArrSearchinc, //y 축 숫자  dataArr = [40905177, 7652368, 2616908 ............]
                           borderColor : "green",
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
            
   }
   
   // 검색 표
   
      function searchtablerun(chart1search){
      

      function addComma(value){
           value = value.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
           return value; 
       }
      
      $.ajax( {
         //url     : 'http://localhost:9090/CovidStatus/covidstatus',
         url     : 'http://localhost:9090/covidstatustable',
         // data    : { gubun : $('#gubun').val() },
         type    : 'GET',
         success : function( xml ) {
            console.log(xml);
            var labelsArr = new Array();
            var dataArr = new Array(); 
            var xArr = new Array();
            var yArrnatDeathCntkor = new Array(); 
            var yArrnatDeathCntsearch = new Array();
            var xArrGapnatDeathCntDate = new Array(); 
            var yArrGapnatDeathCntkor = new Array(); 
            var yArrGapnatDeathCntsearch = new Array();
            var yArrnatDefCntkor = new Array(); 
            var yArrnatDefCntsearch = new Array();
            var xArrGapnatDefCntDate = new Array(); 
            var yArrGapnatDefCntkor = new Array(); 
            var yArrGapnatDefCntsearch = new Array();
   
            var html = '<thead>';
            html		+= '<tr>';
            html		+= '<td>시도명</td>';
            html		+= '<td>확진자 수</td>';
            html		+= '<td>사망자 수</td>';
            html		+= '<td>전일대비 증감 수</td>';
            html		+= '<td>지역발생 수</td>';
            html		+= '<td>격리 해제 수</td>';
            html		+= '<td>10만명당 발생률</td>';
            html		+= '<td>기준일시</td>';
            html		+= '</tr>';
            html		+= '</thead>';
            html		+= '<tbody>';
            
            $(xml).find('item').each(function( index ) {
               if($(this).find('gubun').html()==chart1search || $(this).find('gubun').html()==sido){
                  
            	   console.log("in sido : " + sido);
            	   
                  var gubun = $(this).find('gubun').html(); 
                  var defCnt = $(this).find('defCnt').html();
                  var deathCnt = $(this).find('deathCnt').html();
                  var incDec = $(this).find('incDec').html();
                  var localOccCnt = $(this).find('localOccCnt').html();
                  var isolClearCnt = $(this).find('isolClearCnt').html();
                  var qurRate = $(this).find('qurRate').html();
                  var stdDay = $(this).find('stdDay').html();
                  
                  
                  
                  
                  html += '<tr>';
                  html += '<td>' + gubun +'</td>';
                  html += '<td>' + defCnt +'</td>';
                  html += '<td>' + deathCnt +'</td>';
                  html += '<td>' + incDec +'</td>';
                  html += '<td>' + localOccCnt +'</td>';
                  html += '<td>' + isolClearCnt +'</td>';
                  html += '<td>' + qurRate +'</td>';
                  html += '<td>' + stdDay +'</td>';
                  html += '</tr>';

               
               }
               
               
               /* countrysaveFunction($(this).find('nationNm').html(), $(this).find('natDefCnt').html()); */
            })
            html += '</tbody>';
            $('#table2').html(html)
                  
               },
               error : function(xhr) {
                  alert(xhr.status + ':' + xhr.statusText);
               }
            })
            
   }
            
      
/*    /저장/
      function countrysaveFunction(nationNm, natDefCnt) {
         $.ajax({
            type : "POST",
            url : "/countrycovidstatussavesevlet",
            data : {
               nationNm : nationNm
               natDefCnt : natDefCnt
            },
            success : function(data) {
               if (data == "")
                  return;
               var parsed = JSON.parse(data);
               var result = parsed.result;
               for (var i = 0; i < result.length; i++) {
                  addChat(result[i][0].value, result[i][1].value,
                        result[i][2].value);

               }
               lastID = Number(parsed.last);
            }

         });
      } */
</script>
</head>
<body>
<%@ include file="/include/toptopnav.jsp" %>

<div class="title" id="mytitle"><h2>코로나 현재상황</h2></div>
 <%@ include file="/include/topnav.jsp" %>
  <div>
    <main>   
 
   <label>지역명:</label>
   <input type="text" id="chart1search" onkeyup="enterkey()" >
   <input type="button" id="chart1searchbutton" value="검색">
   <input type="button" id="nosearchtablerunbutton" class="chart1searchbutton" value="초기화">
   
<div id=nonesearch>

<!--    <label>나라명:</label>
   <input type="text" id="chart1search">
   <input type="button" id="chart1searchbutton" value="검색"> -->
   	<div class="container-fluid">
   		<div class="row">
        	<div id ="CovidChart1" class="col col-sm-6  shadow rounded">	
	<div class ="countryCovidChartDiv">국내 확진자 현황</div>
   		<canvas id="myChart1" ></canvas>
   		</div>
        	<div id ="CovidChart2" class="col col-sm-6  shadow rounded">	
	<div class ="countryCovidChartDiv">확진자 전일대비 증감 수</div>
   		<canvas id="myChart2" ></canvas>
   		</div>
   		</div>
         

   </div>


   </div>
   
   
<div id=search>

<!--    <label>나라명:</label>
   <input type="text" id="chart1search">
   <input type="button" id="chart1searchbutton" value="검색"> -->
      	<div class="container-fluid">
      	   		<div class="row">
             <div id ="CovidChart3" class="col col-sm-6 shadow rounded">
		<div id = "search1" class ="countryCovidChartDiv">확진자 현황</div>
   		<canvas id="myChart3" ></canvas>
   		</div>
             <div id ="CovidChart4" class="col col-sm-6 shadow rounded">
		<div id = "search1" class ="countryCovidChartDiv">확진자 전일대비 증감 수</div>
   		<canvas id="myChart4" ></canvas>
   		</div>

	</div>
	</div>
   </div>
      
   
   <div class="table1">
   <div  class ="countryCovidChartDiv">국내 코로나현황표</div>
   <table id="table1" class="table table-striped" >
   	<thead>
     <tr>
       <th>시도명</th>
       <th>확진자 수</th>
       <th>사망자 수</th>
       <th>전일대비 증감 수</th>
       <th>지역발생 수</th>
       <th>격리 해제 수</th>
       <th>10만명당 발생률</th>
       <th>기준일시</th>
     </tr>
     </thead>
   </table>
   </div>
   
   <div class="table2">
	<div id = "search4" class ="countryCovidChartDiv">국내 코로나현황표</div>
   <table id="table2" class="table table-striped">
 	<thead>
     <tr>
       <th>시도명</th>
       <th>확진자 수</th>
       <th>사망자 수</th>
       <th>전일대비 증감 수</th>
       <th>지역발생 수</th>
       <th>격리 해제 수</th>
       <th>10만명당 발생률</th>
       <th>기준일시</th>
     </tr>
     </thead>
   </table>
   </div>
   
   
  </main>  
 </div>  
  
   
   
 
 <%@ include file="/include/bottomnav.jsp" %>
</body>
</html>