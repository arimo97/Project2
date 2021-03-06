<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" />
  <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/js/bootstrap.bundle.min.js"></script>
<!-- <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway"> -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.7.0/chart.min.js" integrity="sha512-TW5s0IT/IppJtu76UbysrBH9Hy/5X41OTAbQuffZFU6lQ1rdcLHzpU5BzVvr/YFykoiMYZVWlr/PX1mDcfM9Qg==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4bce6cd9ede82da81c37797d49ceb223&libraries=services"></script>
<style>
	#mytitle {text-align: center}
	.countryCovidChartDiv{text-align: center;
						background-color: #388458;
						color: #ffffff}	
	.red {color: red;}
	.blue{color: blue;}
	body{ overflow-x: hidden;}
</style>
<script>
window.onload = function(){
//GPS-------------------------------------------------------------------------------------------------------
	(function gps(){
		if ('${sessionScope.locstatus}' != 0){
			
			console.log('if');
			console.log('${sessionScope.locstatus}');
			var address = '${sessionScope.selectedloc}';
			var index = address.lastIndexOf("(");
			if (index > -1)
				address = address.substring(0, index - 1);
			console.log(address);
			var juso = address.split(" ");
			var sido = juso[0];
			var sigungu = juso[1];
			
			var coords = new Array();
			//var mapContainer = document.getElementById('map'), // ????????? ????????? div
			var mapContainer = document.createElement('div');
		    mapOption = {
		        center: new kakao.maps.LatLng(37,127), // ????????? ????????????
		        level: 3 // ????????? ?????? ??????
		    };  
			// ????????? ???????????????    
			var map = new kakao.maps.Map(mapContainer, mapOption); 
			// ??????-?????? ?????? ????????? ???????????????
			var geocoder = new kakao.maps.services.Geocoder();
			// ????????? ????????? ???????????????
			console.log(address);
			geocoder.addressSearch(address, function(result, status) {

			    // ??????????????? ????????? ??????????????? 
			     if (status === kakao.maps.services.Status.OK) {
			         coords = new kakao.maps.LatLng(result[0].y, result[0].x);
			         console.log(coords);
			         console.log(coords.La);
			         console.log(coords.Ma);
			         $.ajax({
			         	url : '/gps',
			         	data : { "sido" : sido,
			         					"sigungu" : sigungu,
						         		"lat" : coords.Ma,
						         		"lon" : coords.La},
			         	type : 'POST',
			         	success : function(){
			         		init( sido, sigungu, coords.Ma, coords.La );
			         	},
			         	error : function(xhr){
			         		alert(xhr.status + ':' + xhr.statusText);
			         	}
			         })
			    } 
			});
			
		} else {
				navigator.geolocation.getCurrentPosition(position => {
				console.log('else');
				//var mapContainer = document.getElementById('map'), // ????????? ????????? div
				var mapContainer = document.createElement('div');
			    mapOption = {
			        center: new kakao.maps.LatLng(position.coords.latitude, position.coords.longitude), // ????????? ????????????
			        level: 2 // ????????? ?????? ??????
			    };  
				// ????????? ???????????????    
				var map = new kakao.maps.Map(mapContainer, mapOption); 
				// ??????-?????? ?????? ????????? ???????????????
				var geocoder = new kakao.maps.services.Geocoder();

					// ?????? ?????? ??????????????? ????????? ???????????? ?????? ?????? ????????? ???????????????
					searchAddrFromCoords(map.getCenter(), displayCenterInfo);

					function searchAddrFromCoords(coords, callback) {
					    // ????????? ????????? ?????? ????????? ???????????????
					    geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);         
					}
					// ?????? ??????????????? ?????? ??????????????? ?????? ??????????????? ???????????? ???????????????
					function displayCenterInfo(result, status) {
					    if (status === kakao.maps.services.Status.OK) {
					        for(var i = 0; i < result.length; i++) {
					            // ???????????? region_type ?????? 'H' ?????????
					            console.dir(result);
					            if (result[i].region_type === 'H') {
					                var sido = result[i].region_1depth_name;
					                var sigungu = result[i].region_2depth_name;
					                $.ajax({
					                	url : '/gps',
					                	data : {"sido" : sido,
					                			"sigungu" : sigungu,
					                			"lat" : position.coords.latitude,
					                			"lon" : position.coords.longitude},
					                	type : 'POST',
					                	success : function(){
					                		init( sido, sigungu, position.coords.latitude, position.coords.longitude );
					                	},
					                	error : function(xhr){
					                		alert(xhr.status + ':' + xhr.statusText);
					                	}
					                })
					            }
					        }
					    }    
					}
				},
				error => {
				alert('?????? ????????? ?????? GPS ????????? ??????????????????!');
				console.log(error);
				})
					console.log('5');
			}
		})();
		//GPS---------------------------------------------------------------------------------------------------------
		 
}

function init( sido, sigungu, lat, lon ) {
	/*????????? ??????  */
	(function(){
			var div = $('#videonewscontent');
		$.ajax({
			url : '/ytnews1',
			data : {},
			success : function(json){
				var html = '';
				$.each(json, function(index, data){
					
					if (index < 4){
					html += '<div class="col">'
						 + '<div class="card h-100 shadow rounded">'
						 + '<a id="link" href="' + 'https://www.youtube.com/watch?v=' + data.id.videoId +'">'
				      	 + '<img src="' + data.snippet.thumbnails.high.url + '" class="card-img-top" height="300" width="300" alt="...">'
				      	 + '<div class="card-body">'
				      	 + '<h5 class="card-title">' + data.snippet.title + '</h5></a>'
				      	 + '<span class="card-text">' + data.snippet.description + '</span>'
				      	 + '</div></div></div>';
					}
				        
				})
				$("#videonewscontent").append(html);
			},
			error : function(xhr){
				alert(xhr.status + ' ' + xhr.statusText);
			}
		})
	})();
/*????????? ??????  */
/*????????????  */
(function(){
			var div = $('.newscontent');
			var html = '';
		$.ajax({
			url : '/newshome',
			data : {},
			success : function(json){
				$.each(json, function(index, data){
					
					if (index < 4){
					html += '<div class="col">'
						 + '<div class="card h-100 shadow rounded">'
						 + '<a id="link" href="' + data.link +'">'
				      	 + '<img src="' + data.img + '" class="card-img-top" height="300" width="300" alt="...">'
				      	 + '<div class="card-body">'
				      	 + '<h5 class="card-title">' + data.title + '</h5></a>'
				      	 + '<span class="card-text">' + data.description + '</span>'
				      	 + '</div></div></div>';
					}
				/* 	data.title
					data.link
					data.description
					data.pubDate */
					
					/* "title": "???????????? <b>?????????</b> ????????? '????????????', ?????? ????????? ??????",
					"originallink": "http://www.newsis.com/view/?id=NISX20211207_0001678184&cID=10434&pID=13100",
					"link": "https://news.naver.com/main/read.naver?mode=LSD&mid=sec&sid1=102&oid=003&aid=0010874376",
					"description": "???????????? ????????????, ?????? ??? ?????? ????????? ?????? ???????????? ?????? ?????? ?????? ?????? ??????????????? <b>?????????</b>19 ??????... ?????? ??????????????? ?????? ???????????? ????????? ?????? <b>?????????</b>19 ????????? ?????? ?????? ???????????? ????????????, ????????? ?????????... ",
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
	})();
/*?????????  */


/*topnav responsive active*/
function myFunction() {
	  var x = document.getElementById("myTopnav");
	  if (x.className === "topnav") {
	    x.className += " responsive";
	  } else {
	    x.className = "topnav";
	  }
	}

/* ????????? ????????????  */
 function  header() {
	
	var head = '<tr>';
	head += '<td>?????????</td>';
	head += '<td>????????? ???</td>';
	head += '<td>????????? ???</td>';
	head += '<td>???????????? ?????? ???</td>';
	head += '<td>???????????? ???</td>';
    head += '<td>?????? ?????? ???</td>';
    head += '<td>10????????? ?????????</td>';
    head += '<td>????????????</td>';
    head += '</tr>'; 
		return head;
	}


	(function(){
		nosearchchartrun();
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
			         data    : { period : 5 },
			         type    : 'GET',
			         success : function( xml ) {
			            var xArr = new Array();
			            var yArrBusan = new Array(); 
			            var yArrSeoul = new Array(); 
			            var yArrGyunggi = new Array(); 
			            var yArrInchon = new Array(); 
			            var yArrUser = new Array(); 
			            
			            
			            // console.log("uSido : " + uSido);
			            
			            var set1 = new Set();
			            var set2 = new Set();
			            var set3 = new Set();
			            var set4 = new Set();
			            var set5 = new Set();
			            
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
			            
			            console.log('test');
			            var huckjintitle = document.getElementById('huckjintitle');
			            huckjintitle.prepend(sido + ' ');
			            
			            $("#chart1searchbutton").on({
			               "click" : function(){
			                  var chart1search = document.getElementById('chart1search').value;
			               }
			               
			            })
			            // ?????? ??????
						if(sido == '???????????????')
						    sido = '??????';
						if(sido == '???????????????')
						   sido = '??????';
						if(sido == '???????????????')
						   sido = '??????';
						if(sido == '???????????????')
						   sido = '??????';
						if(sido == '???????????????')
						   sido = '??????';
						if(sido == '?????????????????????')
						   sido = '??????';
						if(sido == '???????????????')
						   sido = '??????';
						if(sido == '?????????')
						   sido = '??????';
						if(sido == '?????????')
						   sido = '??????';
						if(sido == '????????????')
						   sido = '??????';
						if(sido == '????????????')
						   sido = '??????';
						if(sido == '????????????')
						   sido = '??????';
						if(sido == '????????????')
						   sido = '??????';
						if(sido == '????????????')
						   sido = '??????';
						if(sido == '????????????')
						   sido = '??????';
						if(sido == '?????????????????????')
						   sido = '??????';

			                
			            var html = '';

			            $(xml).find('item').each(function( index ) {
			            	
			            	// ???????????? ?????? 4 ??? ?????? ????????? ????????? ??????
			            	
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
			               
			                  
/* 			                  // set1.add(0+(19*index)); // ??????
			                  // set1.add(1+(19*index)); // ??????
			                  
			                  set1.add(1+(19*index));  // ????????? ????????? ?????? ????????? 19??? ?????????
			              	
			                  set2.add(2+(19*index)); 
			                  	
			                  set3.add(3+(19*index)); 
			                  	
			                  set4.add(4+(19*index)); 
			                  
			                  // ????????? ?????? ?????? ????????? ??? */
			                  
			                  if(index == 1){
			                	  name1 = gubun;
			                  }
			                  if(gubun==name1) {
			                	  yArr1.push(defCnt);
			                	  yArrinc1.push(incDec);
			                	  xArr.push(stdDay.substring(5));	  
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
			                	  
			                	  
			               /* if(gubun=='??????'){  
			               yArrBusan.push(defCnt);
			              // xArr.push(stdDay);
			               
			               }
			               
			               if(gubun=='??????'){   
			               yArrSeoul.push(defCnt);
			               
			               }
			               if(gubun=='??????'){   
			               yArrGyunggi.push(defCnt);
			               
			               }
			               if(gubun=='??????'){   
			               yArrInchon.push(defCnt);
			               
			               } */          
			               }
			               
			               /* countrysaveFunction($(this).find('nationNm').html(), $(this).find('natDefCnt').html()); */
			            })
			            
			            var huckjin = document.getElementById('huckjin');
			            var delta = '';
			            var deltanum = yArr5[4] - yArr5[3];
			            if (isNaN(deltanum)) 
			            	deltanum = 0;
			            if (deltanum >= 0){
			            	delta += '<span class="red" style="font-size: 24px;">&nbsp;&nbsp; vs?????? ' + deltanum + '???</span>';
			            } else{
			            	delta += '<span class="blue" style="font-size: 24px;>&nbsp;&nbsp; vs?????? ' + deltanum + '???</span>';
			            }
			            huckjin.innerHTML = yArr5[4] + '???' + delta;
			            if (typeof yArr5[4] == 'undefined') 
			            	huckjin.innerHTML = 0 + '???' + delta;
			            huckjin.style.fontSize = '40px';
			            
			             // console.log(set2);
			            
			            //??????2-----------------------------------------------

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
			            console.log('xArr ' + xArr);
			                  //??????1------------------------------------------------------------------
			                  const ctx1 = document.getElementById('myChart1')
			                        .getContext('2d');
			                  const myChart1 = new Chart(ctx1, {
			                     type : 'line',
			                     data : {
			                        labels : xArr, //x ??? ??????  labelsArr = ['??????', '???????????????', '???????????????'  ......]
			                        datasets : [ 
			                           {
			                           label : sido, // ????????? ??????
			                           data : yArr5, //y ??? ??????  dataArr = [40905177, 7652368, 2616908 ............]
			                           borderColor : "black",
			                           backgroundColor : "black",
			                           fill : false,
							            borderWidth: 3,
			                           hidden: hd
			                        },
			                           {
			                           label : name1, // ????????? ??????
			                           data : yArr1, //y ??? ??????  dataArr = [40905177, 7652368, 2616908 ............]
			                           borderColor : "red",
			                           backgroundColor : "red",
							            borderWidth: 3,
			                           fill : false
			                        },
			                           {
			                           label : name2, 
			                           data : yArr2, 
			                           borderColor : "green",
			                           backgroundColor : "green",
							            borderWidth: 3,
			                           fill : false
			                        },
			                           {
			                           label : name3, 
			                           data : yArr3, 
			                           borderColor : "blue",
			                           backgroundColor : "blue",
							            borderWidth: 3,
			                           fill : false
			                        },
			                           {
			                           label : name4, 
			                           data : yArr4, 
			                           borderColor : "yellow",
			                           backgroundColor : "yellow",
							            borderWidth: 3,
			                           fill : false
			                        }
			                        ]
			                     },
			                     options : {
			                    	 // ????????? ?????? ???????????? ??????
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
			                    	      text: "????????? ??????" */
			                    	 }

			                     }
			                  });// chart1
			                  
/* 			                  
			            //--chart2---------------------------------------
			                  const ctx2 = document.getElementById('myChart2')
			                  .getContext('2d');
			            const myChart2 = new Chart(ctx2, {
			               type : 'line',
			               data : {
			                  labels : xArr, //x ??? ??????  labelsArr = ['??????', '???????????????', '???????????????'  ......]
			                  datasets : [ 
			                     {
			                     label : sido, // ????????? ??????
			                     data : yArrinc5, //y ??? ??????  dataArr = [40905177, 7652368, 2616908 ............]
			                     borderColor : "black",
			                     backgroundColor : "black",
			                     fill : false,
			                     hidden: hd
			                  },
			                     {
			                     label : name1, // ????????? ??????
			                     data : yArrinc1, //y ??? ??????  dataArr = [40905177, 7652368, 2616908 ............]
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
			              	 // ????????? ?????? ???????????? ??????
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
			                   /* title : {
			              		 display: true,
			              	      text: "????????? ??????" */
			              //	 }

			             //  }
			           // }); // chart2
			            
			            
			               }, // success
			               error : function(xhr) {
			                  alert(xhr.status + ':' + xhr.statusText);
			               }
			            })
			            
			         } // nonserchrun
	})();
 

 
/* ?????? ?????????*/
 function getyesterday(){
	var now = new Date();
	var yesterday = new Date(now.setDate(now.getDate() -1));
	var year 	= yesterday.getFullYear();
	var month	= ('0' + (yesterday.getMonth() + 1)).slice(-2);
	var day		= ('0' + yesterday.getDate()).slice(-2);
	//2021-11-24 00:00:00
	var dateString = year + '-' + month + '-' + day;
//	console.log("dateString:" + dateString);
	return dateString
}

	(function(){
		nosearchchartrun();
		function nosearchchartrun(){
			var yesterday = getyesterday();

		   
		   $.ajax( {
				url     : 'http://localhost:9090/countrycovidstatus',
				data	: {period : 10},
				type    : 'GET',
				success : function( xml ) {
					var labelsArr = new Array();
					var dataArr = new Array(); 
					var xArr = new Array();
					var yArrnatDeathCntkor = new Array(); 
					var yArrnatDeathCntjap = new Array(); 
					var yArrnatDeathCntchi = new Array();
					var yArrnatDeathCntusa = new Array();
					var yArrnatDeathCntGer = new Array();
					var yArrnatDeathCntInd = new Array();
					var yArrnatDeathCntsearch = new Array();
					var xArrGapnatDeathCntDate = new Array(); 
					var yArrGapnatDeathCntkor = new Array(); 
					var yArrGapnatDeathCntjap = new Array(); 
					var yArrGapnatDeathCntchi = new Array();
					var yArrGapnatDeathCntusa = new Array();
					var yArrGapnatDeathCntGer = new Array();
					var yArrGapnatDeathCntInd = new Array();
					var yArrGapnatDeathCntsearch = new Array();
					var yArrnatDefCntkor = new Array(); 
					var yArrnatDefCntjap = new Array(); 
					var yArrnatDefCntchi = new Array();
					var yArrnatDefCntusa = new Array();
					var yArrnatDefCntGer = new Array();
					var yArrnatDefCntInd = new Array();
					var yArrnatDefCntsearch = new Array();
					var xArrGapnatDefCntDate = new Array(); 
					var yArrGapnatDefCntkor = new Array(); 
					var yArrGapnatDefCntjap = new Array(); 
					var yArrGapnatDefCntchi = new Array();
					var yArrGapnatDefCntusa = new Array();
					var yArrGapnatDefCntGer = new Array();
					var yArrGapnatDefCntInd = new Array();
					var yArrGapnatDefCntsearch = new Array();
					var countryArrDoughNut = new Array();
					var valueArrDoughNut = new Array();
					var dummyArrDoughNut = new Array();
					var othervalueArrDoughNut = new Array();
					var barColorsArrDoughNut = [  "#b91d47","#00aba9","#2b5797","#e8c3b9","#1e7145"]
		
			
					var html = '';
					$(xml).find('item').each(function( index ) {
						if($('#courseID').val()==null || $('#courseID').val()==""){
							
						var nationNM = $(this).find('nationNm').html(); 
						var areaNm = $(this).find('areaNm').html();
						var natDefCnt = $(this).find('natDefCnt').html();
						var natDeathCnt = $(this).find('natDeathCnt').html();
						var natDeathRate = $(this).find('natDeathRate').html();
						var stdDay = $(this).find('stdDay').html();
						
						
						
						
						html += '<tr class="row" id="row">';
						html += '<td id="area" class = "area">' + nationNM +'</td>';
						html += '<td>' + areaNm +'</td>';
						html += '<td>' + natDefCnt +'</td>';
						html += '<td>' + natDeathCnt +'</td>';
						html += '<td>' + natDeathRate +'</td>';
						html += '<td>' + stdDay +'</td>';
						html += '</tr>';

						
						
						
				
						
						
						
						if(nationNM=='??????'){	
						dataArr.push(natDeathCnt);
						xArr.push(stdDay.substring(5));
						yArrnatDeathCntkor.push(natDeathCnt);
						yArrnatDefCntkor.push(natDefCnt);
						

						
						}
						

						
						
						if(nationNM=='??????'){
							yArrnatDeathCntjap.push(natDeathCnt);
							yArrnatDefCntjap.push(natDefCnt);
						}
						if(nationNM=='??????'){
							yArrnatDeathCntchi.push(natDeathCnt);
							yArrnatDefCntchi.push(natDefCnt);
						}
						if(nationNM=='??????'){
							yArrnatDeathCntusa.push(natDeathCnt);
							yArrnatDefCntusa.push(natDefCnt);
						}
						if(nationNM=='??????'){
							yArrnatDeathCntGer.push(natDeathCnt);
							yArrnatDefCntGer.push(natDefCnt);
						}
						if(nationNM=='??????'){
							yArrnatDeathCntInd.push(natDeathCnt);
							yArrnatDefCntInd.push(natDefCnt);
						}
				
						
						if((nationNM=='??????'||nationNM=='??????'||nationNM=='??????'||nationNM=='??????'||nationNM=='??????'||nationNM=='?????????'||nationNM=='????????????'||nationNM=='??????') && stdDay==yesterday){
							dummyArrDoughNut.push(natDeathRate);
								countryArrDoughNut.push(nationNM);
								valueArrDoughNut.push(natDefCnt);	
						}
						
					
						
						}
						
						
					})
					
							var html1 = '';
					$($(xml).find('item').get().reverse()).each(function( index ) {
						if($('#courseID').val()==null || $('#courseID').val()==""){
							
						var nationNM = $(this).find('nationNm').html(); 
						var areaNm = $(this).find('areaNm').html();
						var natDefCnt = $(this).find('natDefCnt').html();
						var natDeathCnt = $(this).find('natDeathCnt').html();
						var natDeathRate = $(this).find('natDeathRate').html();
						var stdDay = $(this).find('stdDay').html();
						
						
						
						
						html1 += '<tr class="row" id="row">';
						html1 += '<td id="area" class = "area">' + nationNM +'</td>';
						html1 += '<td>' + areaNm +'</td>';
						html1 += '<td>' + natDefCnt +'</td>';
						html1 += '<td>' + natDeathCnt +'</td>';
						html1 += '<td>' + natDeathRate +'</td>';
						html1 += '<td>' + stdDay +'</td>';
						html1 += '</tr>';

					
						
						}
						
						
					})
					$('#table1').append(html1)
					
					console.log(xArr);
					//??????2-----------------------------------------------
					// ?????? ?????????
					var GapDeathCntKor ='';
					var GapDeathCntjap ='';
					var GapDeathCntchi ='';
					var GapDeathCntusa ='';
					var GapDeathCntGer ='';
					var GapDeathCntInd ='';
					var GapDeathCntsearch ='';
					// ?????? ?????????
					var GapnatDefKor ='';
					var GapnatDefjap ='';
					var GapnatDefchi ='';
					var GapnatDefusa ='';
					var GapnatDefGer ='';
					var GapnatDefInd ='';
					var GapnatDefsearch ='';
				
							for (var i = yArrnatDeathCntkor.length; i >= 0 ; i--) {
								if (isNaN(yArrnatDeathCntkor[i] - yArrnatDeathCntkor[i - 1])==false ) {
									//1??? ?????????
								GapDeathCntKor = yArrnatDeathCntkor[i] - yArrnatDeathCntkor[i - 1]
								GapDeathCntjap = yArrnatDeathCntjap[i] - yArrnatDeathCntjap[i - 1]
								GapDeathCntchi = yArrnatDeathCntchi[i] - yArrnatDeathCntchi[i - 1]
								GapDeathCntusa = yArrnatDeathCntusa[i] - yArrnatDeathCntusa[i - 1]
								GapDeathCntGer = yArrnatDeathCntGer[i] - yArrnatDeathCntGer[i - 1]
								GapDeathCntInd = yArrnatDeathCntInd[i] - yArrnatDeathCntInd[i - 1]
								yArrGapnatDeathCntkor.push(GapDeathCntKor)
								yArrGapnatDeathCntjap.push(GapDeathCntjap)
								yArrGapnatDeathCntchi.push(GapDeathCntchi)
								yArrGapnatDeathCntusa.push(GapDeathCntusa)
								yArrGapnatDeathCntGer.push(GapDeathCntGer) 
								yArrGapnatDeathCntInd.push(GapDeathCntInd) 
								
								//1??? ?????????
								GapnatDefKor = yArrnatDefCntkor[i] - yArrnatDefCntkor[i - 1]
								GapnatDefjap = yArrnatDefCntjap[i] - yArrnatDefCntjap[i - 1]
								GapnatDefchi = yArrnatDefCntchi[i] - yArrnatDefCntchi[i - 1]
								GapnatDefusa = yArrnatDefCntusa[i] - yArrnatDefCntusa[i - 1]
								GapnatDefGer = yArrnatDefCntGer[i] - yArrnatDefCntGer[i - 1]
								GapnatDefInd = yArrnatDefCntInd[i] - yArrnatDefCntInd[i - 1]
									
								yArrGapnatDefCntkor.push(GapnatDefKor);
								yArrGapnatDefCntjap.push(GapnatDefjap);
								yArrGapnatDefCntchi.push(GapnatDefchi);
								yArrGapnatDefCntusa.push(GapnatDefusa);
								yArrGapnatDefCntGer.push(GapnatDefGer);
								yArrGapnatDefCntInd.push(GapnatDefInd);
									
								}
							}
						
							
							
					//	console.log(yArrGapnatDefCntkor);
					//	console.log(yArrGapnatDefCntjap);
					//	console.log(yArrGapnatDefCntchi);
					//	console.log(yArrGapnatDefCntusa);
					var xValues = [100,200,300,400,500,600,700,800,900,1000];

					xArr.pop();
					
							//??????------------------------------------------------------------------
						//	console.log('labelsArr[1]:' + labelsArr[1]);		
						//	console.log('dataArr[1]:' + dataArr[1]);
							const ctx3 = document.getElementById('myChart3')
									.getContext('2d');
							const myChart3 = new Chart(ctx3, {
								type : 'line',
								data : {
									labels : xArr, //x ??? ??????  labelsArr = ['??????', '???????????????', '???????????????'  ......]
									datasets : [ 
										{
										label : '?????? ????????? ??????', // ????????? ??????
										data : yArrGapnatDefCntkor, //y ??? ??????  dataArr = [40905177, 7652368, 2616908 ............]
										borderColor : "#b91d47",
										backgroundColor : "#b91d47",
							            borderWidth: 3,
										fill : false
									},
									{
										label : '?????? ????????? ??????', // ????????? ??????
										data : yArrGapnatDefCntjap, //y ??? ??????  dataArr = [40905177, 7652368, 2616908 ............]
										borderColor : "#00aba9",
										backgroundColor : "#00aba9",
							            borderWidth: 3,
										fill : false
									},
									{
										label : '?????? ????????? ??????', // ????????? ??????
										data : yArrGapnatDefCntchi, //y ??? ??????  dataArr = [40905177, 7652368, 2616908 ............]
										borderColor : "#2b5797",
										backgroundColor : "#2b5797",
							            borderWidth: 3,
										fill : false
									},	
									{
										label : '?????? ????????? ??????', // ????????? ??????
										data : yArrGapnatDefCntusa, //y ??? ??????  dataArr = [40905177, 7652368, 2616908 ............]
										borderColor : "#e8c3b9",
										backgroundColor : "#e8c3b9",
							            borderWidth: 3,
										fill : false
									},
									{
										label : '?????? ????????? ??????', // ????????? ??????
										data : yArrGapnatDefCntGer, //y ??? ??????  dataArr = [40905177, 7652368, 2616908 ............]
										borderColor : "#1e7145",
										backgroundColor : "#1e7145",
							            borderWidth: 3,
										fill : false
									},
									{
										label : '?????? ????????? ??????', // ????????? ??????
										data : yArrGapnatDefCntInd, //y ??? ??????  dataArr = [40905177, 7652368, 2616908 ............]
										borderColor : "#8A2BE2",
										backgroundColor : "#8A2BE2",
							            borderWidth: 3,
										fill : false
									}
									]
								},
								options : {
									scales : {
										y : {
											beginAtZero : false
										}
									}
								}
							});
							//??????------------------------------------------------------------------
						//	console.log('labelsArr[1]:' + labelsArr[1]);		
						//	console.log('dataArr[1]:' + dataArr[1]);
/* 							const ctx4 = document.getElementById('myChart4')
									.getContext('2d');
							const myChart4 = new Chart(ctx4, {
								type : 'line',
								data : {
									labels : xArr, //x ??? ??????  labelsArr = ['??????', '???????????????', '???????????????'  ......]
									datasets : [ 
										{
										label : '?????? ????????? ??????', // ????????? ??????
										data : yArrGapnatDeathCntkor, //y ??? ??????  dataArr = [40905177, 7652368, 2616908 ............]
										borderColor : "#b91d47",
										backgroundColor : "#b91d47",
										fill : false
									},
									{
										label : '?????? ????????? ??????', // ????????? ??????
										data : yArrGapnatDeathCntjap, //y ??? ??????  dataArr = [40905177, 7652368, 2616908 ............]
										borderColor : "#00aba9",
										backgroundColor : "#00aba9",
										fill : false
									},
									{
										label : '?????? ????????? ??????', // ????????? ??????
										data : yArrGapnatDeathCntchi, //y ??? ??????  dataArr = [40905177, 7652368, 2616908 ............]
										borderColor : "#2b5797",
										backgroundColor : "#2b5797",
										fill : false
									},	
									{
										label : '?????? ????????? ??????', // ????????? ??????
										data : yArrGapnatDeathCntusa, //y ??? ??????  dataArr = [40905177, 7652368, 2616908 ............]
										borderColor : "#e8c3b9",
										backgroundColor : "#e8c3b9",
										fill : false
									},
									{
										label : '?????? ????????? ??????', // ????????? ??????
										data : yArrGapnatDeathCntGer, //y ??? ??????  dataArr = [40905177, 7652368, 2616908 ............]
										borderColor : "#1e7145",
										backgroundColor : "#1e7145",
										fill : false
									},
									{
										label : '?????? ????????? ??????', // ????????? ??????
										data : yArrGapnatDeathCntInd, //y ??? ??????  dataArr = [40905177, 7652368, 2616908 ............]
										borderColor : "#8A2BE2",
										backgroundColor : "#8A2BE2",
										fill : false
									}
									]
								},
								options : {
									scales : {
										y : {
											beginAtZero : false
										}
									}
								}
							});
						 */
						},
						error : function(xhr) {
							alert(xhr.status + ':' + xhr.statusText);
						}
					})
					
				}
		
	})();
 /* ????????????*/
/*	 	
 		setTimeout(function() {
			  ifm()
			}, 2000);
			*/
		(function ifm(){
		var url = document.getElementById('ifm');
		console.log('lon' + lon);
		console.log('lat' + lat);
		url.setAttribute('src', 'https://m.place.naver.com/rest/vaccine?x=' + lon + '&y=' + lat );
		})();
		/*???????????? */
		 
		var xhr = new XMLHttpRequest();
		xhr.onreadystatechange = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {
					var get_data = xhr.responseText;
					var obj = JSON.parse(get_data);
					
					var data = obj.data;
					var html = '<tr>'+
					       '<th>??????</th>'+
					       '<th>??????1??? ????????????</th>'+
					       '<th>??????2??? ????????????</th>'+
					       '<th>??????3??? ????????????</th>'+
					       '<th>1??? ?????? ?????? ??????</th>'+
					       '<th>2??? ?????? ?????? ??????</th>'+
					       '<th>3??? ?????? ?????? ??????</th>'+
					       '<th>1??? ?????????</th>'+
					       '<th>2??? ?????????</th>'+
					       '<th>3??? ?????????</th>'+
					       '<th>?????????</th>'+
					       '</tr>';
					       
					var labelsArr_baseDate = new Array();
					var dataArr_sido = new Array(); 
					var dataArr_all = new Array(); 
					
					var dataArr_all1st = new Array();
					var dataArr_all2nd = new Array();
					var dataArr_all3rd = new Array();
					
					var dataArr_sido1st = new Array();
					var dataArr_sido2nd = new Array();
					var dataArr_sido3rd = new Array();
					
					if(sido == '??????')
						sido = '???????????????';
					if(sido == '??????')
						sido = '???????????????';
					if(sido == '??????')
						sido = '???????????????';
					if(sido == '??????')
						sido = '???????????????';
					if(sido == '??????')
						sido = '???????????????';
					if(sido == '??????')
						sido = '?????????????????????';
					if(sido == '??????')
						sido = '???????????????';
					if(sido == '??????')
						sido = '?????????';
					if(sido == '??????')
						sido = '?????????';
					if(sido == '??????')
						sido = '????????????';
					if(sido == '??????')
						sido = '????????????';
					if(sido == '??????')
						sido = '????????????';
					if(sido == '??????')
						sido = '????????????';
					if(sido == '??????')
						sido = '????????????';
					if(sido == '??????')
						sido = '????????????';
					if(sido == '??????')
						sido = '?????????????????????';
					
					data.forEach( function( ele, index ) {
						
						var vaccine1_ratio = (ele.totalFirstCnt / ele.population * 100).toFixed(1);
						var vaccine2_ratio = (ele.totalSecondCnt / ele.population * 100).toFixed(1);
						var vaccine3_ratio = (ele.totalThirdCnt / ele.population * 100).toFixed(1);
						
						html += '<tr class="row">';
						html += '<td id="area" class = "area">' + ele.sido +'</td>';
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
						
						
						if (ele.sido == '??????'){
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
						
					 });
					
					
					dataArr_all1st.reverse();
					dataArr_all2nd.reverse();
					dataArr_all3rd.reverse();
					
					dataArr_sido1st.reverse();
					dataArr_sido2nd.reverse();
					dataArr_sido3rd.reverse();
					
					labelsArr_baseDate.reverse();
					console.log("dataArr_sido1st:" + dataArr_sido1st);
					console.log("dataArr_sido2nd:" + dataArr_sido2nd);
/*
					const ctx7 = document.getElementById('myChart7').getContext('2d');
					const bColor = [ 'rgba(255, 99, 132, 1)', 'rgba(54, 162, 235, 1)', 'rgba(255, 206, 86, 1)', 'rgba(75, 192, 192, 1)', 'rgba(153, 102, 255, 1)', 'rgba(255, 159, 64, 1)' ];
					const myChart7 = new Chart(ctx7, {
						type: 'line',
					    data: {
					        labels: labelsArr_baseDate,
					        datasets: [{
					            label: sido + ' 2??? ?????????', 
					            data: dataArr_sido2nd,
					            borderWidth: 3,
					            borderColor: '#A4D0F2',
					            backgroundColor: "#A4D0F2",
					            hoverBorderWidth: 5,
					            hoverBorderColor: 'skyblue',
					            order : 1
					        },
					        {
				        	  label: '?????? 2??? ?????????',
					            data: dataArr_all2nd,
					            borderWidth: 3,
					            borderColor: '#EFC8C7',
					            backgroundColor: "#EFC8C7",
					            hoverBorderWidth: 5,
					            hoverBorderColor: 'skyblue',
					            order : 2
					        },
					        {
					            label: sido + ' 1??? ?????????',
					            data: dataArr_sido1st,
					            borderWidth: 3,
					            borderColor: '#F5DF57',
					            backgroundColor: "#F5DF57",
					            hoverBorderWidth: 5,
					            hoverBorderColor: 'skyblue',
					            order : 3
					        },
					        {
				        	  label: '?????? 1??? ?????????',
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
				               
				            }
					    }
					});
*/ 				
					var jupjongtitle = document.getElementById('jupjongtitle');
					jupjongtitle.prepend(sido + ' ');
					
					var jupjong = document.getElementById('jupjong');
					var delta = '';
					var deltanum = (dataArr_sido3rd[4] - dataArr_sido3rd[3]).toFixed(1);
					if (isNaN(deltanum))
						deltanum = 0;
					if (deltanum >= 0){
		            	delta += '<span class="red" style="font-size: 24px;">&nbsp;&nbsp; vs?????? ' + deltanum + '%???</span>';
		            } else{
		            	delta += '<span class="blue" style="font-size: 24px;>&nbsp;&nbsp; vs?????? ' + deltanum + '%???</span>';
		            }
		            jupjong.innerHTML = dataArr_sido3rd[4] + '%' + delta;
					if (typeof dataArr_sido3rd[4] == 'undefined')
						jupjong.innerHTML = 0 + '%' + delta;
		            jupjong.style.fontSize = '40px';
					
			            
			            
					const ctx8 = document.getElementById('myChart8').getContext('2d');
					const myChart8 = new Chart(ctx8, {
						type: 'line',
					    data: {
					        labels: labelsArr_baseDate,
					        datasets: [{
					            label: sido + ' 3??? ?????????',
					            data: dataArr_sido3rd, 
					            borderWidth: 3,
					            hoverBorderWidth: 5,
					            hoverBorderColor: 'skyblue',
					            backgroundColor: "#DD3464",
					            borderColor: '#DD3464',
					            order : 1
					        },
					        {
					        	label: '?????? 3??? ?????????',
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
			
					    }
					    }
					    });
					}
			}
		xhr.open('GET', '/vaccinestaticsevlet?period=5', true);
		xhr.send();
	}

</script>
</head>
<body>


 <%@ include file="/include/toptopnav.jsp" %>

<div class="title" id="mytitle"><h2>HOME</h2></div>
 <%@ include file="/include/topnav.jsp" %>


<div class="container-fluid py-3">
<div class="row row-cols-1 row-cols-sm-2 g-0 sm-gx-4 border-primary">
	
	<div class="col p-3"> 
        <div class="p-5 text-white bg-dark rounded-3 shadow">
          <h2 id="huckjintitle">??? ?????????</h2>
          <p id="huckjin"></p>
        </div>
      </div>
   	
	<div class="col  p-3">
        <div class="p-5 bg-light border rounded-3 shadow">
          <h2 id="jupjongtitle">3??? ?????????</h2>
          <p id="jupjong"></p>
        </div>
      </div>
	</div>
<div class="row row-cols-1 row-cols-sm-3 g-3 g-sm-0 border-light">
	<div class="col p-3">
	<div class="p-2 shadow rounded" id ="CovidCharthome1">	
	<div class ="countryCovidChartDiv"  OnClick="location.href='/view/CovidStatusview.jsp'">?????? ????????? ??????</div>
   		<canvas id="myChart1" ></canvas>
   		</div>
   	</div>
<%-- 	<div class="col">
        	<div class="p-2  rounded" id ="countryCovidCharthome2" >	
	<div class ="countryCovidChartDiv" OnClick="location.href='/view/CovidStatusview.jsp'">????????? ???????????? ?????? ???</div>
   		<canvas id="myChart2" ></canvas>
   		</div>
   	</div> --%>

  
	<div class="col p-3">
    		<div class="p-2 shadow rounded" id ="countryCovidCharthome1">	
				<div class ="countryCovidChartDiv" OnClick="location.href='/view/CountryCovidStatus.jsp'">????????? ?????? ????????? ??????</div>
   			<canvas id="myChart3" ></canvas>
   			</div>
   	</div>
<%-- 	<div class="col">
   		 <div class="p-2  rounded" id ="countryCovidCharthome2">
				<div class ="countryCovidChartDiv" OnClick="location.href='/view/CountryCovidStatus.jsp'">????????? ?????? ????????? ??????</div>
   			<canvas id="myChart4" ></canvas>
   			</div>
   	</div> --%>
<%--  
	<div class="col p-3">
   			<!-- ?????????????????? -->
		<div class="p-2 shadow rounded" id ="vacstatushome1">
		<div class ="countryCovidChartDiv" id = "vacstatushome1div" OnClick="location.href='/view/VaccineStatics.jsp'">???????????? 1???, 2??? ?????????</div>
	   		<canvas id="myChart7" ></canvas>
   	
   	</div>
   	</div>
   	 --%>
  	
	<div class="col p-3">
	   	<div class="p-2 shadow rounded" id ="vacstatushome2">
	   	<div class ="countryCovidChartDiv" id="vacstatushome1div" OnClick="location.href='/view/VaccineStatics.jsp'">???????????? 3??? ?????????</div>
	   		<canvas id="myChart8"></canvas>
   
  </div> 
  
   	</div>
<!--????????????  https??? ???????????? ??????????????? ?????????/ https??? ??????????????? ??????????????? -> ????????? ???????????? ????????? ????????? ?????????????????? ?????? localhost?????? ?????????-->
	<div class="col-12 p-3" style="width: 100%;">
 	<div class="p-2 shadow rounded" class="iframebox">
	<div class ="countryCovidChartDiv" id="noshowvaccinehome" OnClick="location.href='/view/NoShowVaccine.jsp'">????????????</div>
 	
		<iframe id="ifm" src="" style="width: 100%; height: 600px;"></iframe>
<%-- 		<iframe id="ifm" src="https://m.place.naver.com/rest/vaccine?x=${lon}&y=${lat }" width="600" height="600"></iframe> --%>
	</div>
	</div>
		
		<!--homenews  -->
	<div class="col-12 p-3" style="width: 100%;">
	<div id="homenews" class="shadow rounded" >
	<div class ="countryCovidChartDiv" id="homenewstitle" OnClick="location.href='/view/News.jsp'">??????</div>
		<div id="newscontent" class="row row-cols-1 row-cols-md-4 g-3 border border-light " style="margin: 10px 20px;">
		</div>
		</div>
	</div>
	<!--homevideo news  -->
	<div class="col-12 p-3" style="width: 100%;">
	<div id="homevideonews" class="shadow rounded" >
	 <div class ="countryCovidChartDiv" id="homevideonewstitle" OnClick="location.href='/view/YoutubNews.jsp'">????????? ??????</div>
		<div id="videonewscontent" class="row row-cols-1 row-cols-md-4 g-3 border border-light " style="margin: 10px 20px;">
		</div>
		</div>
	</div>
	<!--homevideo news  -->
		
</div>
</div>  


 <%@ include file="/include/bottomnav.jsp" %>



</body>
</html>
