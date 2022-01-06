<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- <link rel="stylesheet" href="/css/prj2.css"> -->
 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<!-- <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway"> -->
<!-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"> -->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js@3.6.2/dist/chart.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.6.2/chart.esm.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.6.2/helpers.esm.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4bce6cd9ede82da81c37797d49ceb223&libraries=services"></script>
<style>
	#mytitle {text-align: center}
</style>
<script>
//GPS-------------------------------------------------------------------------------------------------------
function gps(){
if ('${locstatus}' != 0){
	
	console.log('if');
	console.log('${locstatus}');
	var address = '${selectedloc}';
	var index = address.lastIndexOf("(");
	if (index > -1)
		address = address.substring(0, index - 1);
	console.log(address);
	var juso = address.split(" ");
	var sido = juso[0];
	var sigungu = juso[1];
	
	var coords = new Array();
	//var mapContainer = document.getElementById('map'), // 지도를 표시할 div
	var mapContainer = document.createElement('div');
    mapOption = {
        center: new kakao.maps.LatLng(37,127), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  
	// 지도를 생성합니다    
	var map = new kakao.maps.Map(mapContainer, mapOption); 
	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();
	// 주소로 좌표를 검색합니다
	console.log(address);
	geocoder.addressSearch(address, function(result, status) {

	    // 정상적으로 검색이 완료됐으면 
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
		//var mapContainer = document.getElementById('map'), // 지도를 표시할 div
		var mapContainer = document.createElement('div');
	    mapOption = {
	        center: new kakao.maps.LatLng(position.coords.latitude, position.coords.longitude), // 지도의 중심좌표
	        level: 2 // 지도의 확대 레벨
	    };  
		// 지도를 생성합니다    
		var map = new kakao.maps.Map(mapContainer, mapOption); 
		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();

			// 현재 지도 중심좌표로 주소를 검색해서 지도 좌측 상단에 표시합니다
			searchAddrFromCoords(map.getCenter(), displayCenterInfo);

			function searchAddrFromCoords(coords, callback) {
			    // 좌표로 행정동 주소 정보를 요청합니다
			    geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);         
			}
			
			// 지도 좌측상단에 지도 중심좌표에 대한 주소정보를 표출하는 함수입니다
			function displayCenterInfo(result, status) {
			    if (status === kakao.maps.services.Status.OK) {
			        for(var i = 0; i < result.length; i++) {
			            // 행정동의 region_type 값은 'H' 이므로
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
		alert('정보 제공을 위해 GPS 기능을 허용해주세요!');
		console.log(error);
		})
	}
}

gps();
//GPS---------------------------------------------------------------------------------------------------------
 
/*동영상 뉴스  */
	$(function(){
			var div = $('#videonewscontent');
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
				$("#videonewscontent").append(html);
			},
			error : function(xhr){
				alert(xhr.status + ' ' + xhr.statusText);
			}
		})
	})
/*동영상 뉴스  */
/*뉴스시작  */
$(function(){
			var div = $('.newscontent');
			var html = '';
		$.ajax({
			url : '/newshome',
			data : {},
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
/*뉴스끝  */

		// 검색 결과 목록과 마커를 표출하는 함수입니다
		function displayPlaces(places) {

		    var listEl = document.getElementById('placesList'), 
		    menuEl = document.getElementById('menu_wrap'),
		    fragment = document.createDocumentFragment(), 
		    bounds = new kakao.maps.LatLngBounds(), 
		    listStr = '';
		    
		    // 검색 결과 목록에 추가된 항목들을 제거합니다
		    removeAllChildNods(listEl);

		    // 지도에 표시되고 있는 마커를 제거합니다
		    removeMarker();
		    
		    for ( var i=0; i<places.length; i++ ) {

		        // 마커를 생성하고 지도에 표시합니다
		        var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
		            marker = addMarker(placePosition, i), 
		            itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다

		        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
		        // LatLngBounds 객체에 좌표를 추가합니다
		        bounds.extend(placePosition);

		        // 마커와 검색결과 항목에 mouseover 했을때
		        // 해당 장소에 인포윈도우에 장소명을 표시합니다
		        // mouseout 했을 때는 인포윈도우를 닫습니다
		        (function(marker, title) {
		            kakao.maps.event.addListener(marker, 'mouseover', function() {
		                displayInfowindow(marker, title);
		            });

		            kakao.maps.event.addListener(marker, 'mouseout', function() {
		                infowindow.close();
		            });

		            itemEl.onmouseover =  function () {
		                displayInfowindow(marker, title);
		            };

		            itemEl.onmouseout =  function () {
		                infowindow.close();
		            };
		        })(marker, places[i].place_name);

		        fragment.appendChild(itemEl);
		    }

		    // 검색결과 항목들을 검색결과 목록 Elemnet에 추가합니다
		    listEl.appendChild(fragment);
		    menuEl.scrollTop = 0;

		    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
		    map.setBounds(bounds);
		}

		// 검색결과 항목을 Element로 반환하는 함수입니다
		function getListItem(index, places) {

		    var el = document.createElement('li'),
		    itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
		                '<div class="info">' +
		                '   <h5>' + places.place_name + '</h5>';

		    if (places.road_address_name) {
		        itemStr += '    <span>' + places.road_address_name + '</span>' +
		                    '   <span class="jibun gray">' +  places.address_name  + '</span>';
		    } else {
		        itemStr += '    <span>' +  places.address_name  + '</span>'; 
		    }
		                 
		      itemStr += '  <span class="tel">' + places.phone  + '</span>' +
		                '</div>';           

		    el.innerHTML = itemStr;
		    el.className = 'item';

		    return el;
		}

		// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
		function addMarker(position, idx, title) {
		    var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
		        imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
		        imgOptions =  {
		            spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
		            spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
		            offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
		        },
		        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
		            marker = new kakao.maps.Marker({
		            position: position, // 마커의 위치
		            image: markerImage 
		        });

		    marker.setMap(map); // 지도 위에 마커를 표출합니다
		    markers.push(marker);  // 배열에 생성된 마커를 추가합니다

		    return marker;
		}

		// 지도 위에 표시되고 있는 마커를 모두 제거합니다
		function removeMarker() {
		    for ( var i = 0; i < markers.length; i++ ) {
		        markers[i].setMap(null);
		    }   
		    markers = [];
		}

		// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
		function displayPagination(pagination) {
		    var paginationEl = document.getElementById('pagination'),
		        fragment = document.createDocumentFragment(),
		        i; 

		    // 기존에 추가된 페이지번호를 삭제합니다
		    while (paginationEl.hasChildNodes()) {
		        paginationEl.removeChild (paginationEl.lastChild);
		    }

		    for (i=1; i<=pagination.last; i++) {
		        var el = document.createElement('a');
		        el.href = "#";
		        el.innerHTML = i;

		        if (i===pagination.current) {
		            el.className = 'on';
		        } else {
		            el.onclick = (function(i) {
		                return function() {
		                    pagination.gotoPage(i);
		                }
		            })(i);
		        }

		        fragment.appendChild(el);
		    }
		    paginationEl.appendChild(fragment);
		}

		// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
		// 인포윈도우에 장소명을 표시합니다
		function displayInfowindow(marker, title) {
		    var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';

		    infowindow.setContent(content);
		    infowindow.open(map, marker);
		}

		 // 검색결과 목록의 자식 Element를 제거하는 함수입니다
		function removeAllChildNods(el) {   
		    while (el.hasChildNodes()) {
		        el.removeChild (el.lastChild);
		    }
		
	}
/*topnav responsive active
function myFunction() {
	  var x = document.getElementById("myTopnav");
	  if (x.className === "topnav") {
	    x.className += " responsive";
	  } else {
	    x.className = "topnav";
	  }
	}
*/

/* 코로나 현재상황  */
 function  header() {
	
	var head = '<tr>';
	head += '<td>시도명</td>';
	head += '<td>확진자 수</td>';
	head += '<td>사망자 수</td>';
	head += '<td>전일대비 증감 수</td>';
	head += '<td>지역발생 수</td>';
    head += '<td>격리 해제 수</td>';
    head += '<td>10만명당 발생률</td>';
    head += '<td>기준일시</td>';
    head += '</tr>'; 
		return head;
	}


var sido      = '${ sido }';
console.log("sido:" + sido);

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
 
 
	$(function(){
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
			         // data    : { gubun : $('#gubun').val() },
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
			            
			            
			            
			            $("#chart1searchbutton").on({
			               "click" : function(){
			                  var chart1search = document.getElementById('chart1search').value;
			                  console.log(chart1search);
			               }
			               
			            })
			            

			                
			            var html = '';
			            
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
			               
			                  
			                  // set1.add(0+(19*index)); // 합계
			                  // set1.add(1+(19*index)); // 서울
			                  
			                  set1.add(1+(19*index));  // 중간에 검역이 끼어 있어서 19로 해야함
			              	
			                  set2.add(2+(19*index)); 
			                  	
			                  set3.add(3+(19*index)); 
			                  	
			                  set4.add(4+(19*index)); 
			                  
			                  // 이름은 처음 값만 받으면 됨
			                  
			                  if(set1.has(index)==true && index == 1){
			                	  name1 = gubun;
			                  }
			                  if(gubun==name1) {
			                	  yArr1.push(defCnt);
			                	  yArrinc1.push(incDec);
			                	  xArr.push(stdDay);	  
			                  }
			                  
			                  if(set2.has(index)==true && index == 2){
			                	  name2 = gubun;
			                  }
			                  if(gubun==name2) {
			                	  yArr2.push(defCnt);
			                	  yArrinc2.push(incDec);
			                  }
			                  
			                  if(set3.has(index)==true && index == 3){
			                	  name3 = gubun;
			                  }
			                  if(gubun==name3) {
			                	  yArr3.push(defCnt);
			                	  yArrinc3.push(incDec);
			                  }
			                  
			                  if(set4.has(index)==true && index == 4){
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
			                           fill : false,
			                           hidden: hd
			                        },
			                           {
			                           label : name1, // 데이터 범례
			                           data : yArr1, //y 축 숫자  dataArr = [40905177, 7652368, 2616908 ............]
			                           borderColor : "red",
			                           fill : false
			                        },
			                           {
			                           label : name2, 
			                           data : yArr2, 
			                           borderColor : "green",
			                           fill : false
			                        },
			                           {
			                           label : name3, 
			                           data : yArr3, 
			                           borderColor : "blue",
			                           fill : false
			                        },
			                           {
			                           label : name4, 
			                           data : yArr4, 
			                           borderColor : "yellow",
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
			                     fill : false,
			                     hidden: hd
			                  },
			                     {
			                     label : name1, // 데이터 범례
			                     data : yArrinc1, //y 축 숫자  dataArr = [40905177, 7652368, 2616908 ............]
			                     borderColor : "red",
			                     fill : false
			                  },
			                     {
			                     label : name2, 
			                     data : yArrinc2, 
			                     borderColor : "green",
			                     fill : false
			                  },
			                     {
			                     label : name3, 
			                     data : yArrinc3, 
			                     borderColor : "blue",
			                     fill : false
			                  },
			                     {
			                     label : name4, 
			                     data : yArrinc4, 
			                     borderColor : "yellow",
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
	})
 

 
/* 해외 코로나*/
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

	$(function(){
		nosearchchartrun();
		function nosearchchartrun(){
			var yesterday = getyesterday();

		   
		   $.ajax( {
				url     : 'http://localhost:9090/countrycovidstatus',
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

						
						
						
				
						
						
						
						if(nationNM=='한국'){	
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
						if(nationNM=='독일'){
							yArrnatDeathCntGer.push(natDeathCnt);
							yArrnatDefCntGer.push(natDefCnt);
						}
						if(nationNM=='인도'){
							yArrnatDeathCntInd.push(natDeathCnt);
							yArrnatDefCntInd.push(natDefCnt);
						}
				
						
						if((nationNM=='미국'||nationNM=='일본'||nationNM=='독일'||nationNM=='영국'||nationNM=='인도'||nationNM=='프랑스'||nationNM=='이탈리아'||nationNM=='한국') && stdDay==yesterday){
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
					//차트2-----------------------------------------------
					// 일일 사망자
					var GapDeathCntKor ='';
					var GapDeathCntjap ='';
					var GapDeathCntchi ='';
					var GapDeathCntusa ='';
					var GapDeathCntGer ='';
					var GapDeathCntInd ='';
					var GapDeathCntsearch ='';
					// 일일 확진자
					var GapnatDefKor ='';
					var GapnatDefjap ='';
					var GapnatDefchi ='';
					var GapnatDefusa ='';
					var GapnatDefGer ='';
					var GapnatDefInd ='';
					var GapnatDefsearch ='';
				
							for (var i = yArrnatDeathCntkor.length; i >= 0 ; i--) {
								if (isNaN(yArrnatDeathCntkor[i] - yArrnatDeathCntkor[i - 1])==false ) {
									//1일 사망자
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
								
								//1일 확진자
								GapnatDefKor = yArrnatDefCntkor[i] - yArrnatDefCntkor[i - 1]
								GapnatDefjap = yArrnatDefCntjap[i] - yArrnatDefCntjap[i - 1]
								GapnatDefchi = yArrnatDefCntchi[i] - yArrnatDefCntchi[i - 1]
								GapnatDefusa = yArrnatDefCntusa[i] - yArrnatDefCntusa[i - 1]
								GapnatDefGer = yArrnatDefCntGer[i] - yArrnatDefCntGer[i - 1]
								GapnatDefInd = yArrnatDefCntInd[i] - yArrnatDefCntInd[i - 1]
									
								yArrGapnatDefCntkor.push(GapnatDefKor)
								yArrGapnatDefCntjap.push(GapnatDefjap)
								yArrGapnatDefCntchi.push(GapnatDefchi)
								yArrGapnatDefCntusa.push(GapnatDefusa)
								yArrGapnatDefCntGer.push(GapnatDefGer)
								yArrGapnatDefCntInd.push(GapnatDefInd)
									
								}
							}
						
							
							
					//	console.log(yArrGapnatDefCntkor);
					//	console.log(yArrGapnatDefCntjap);
					//	console.log(yArrGapnatDefCntchi);
					//	console.log(yArrGapnatDefCntusa);
					var xValues = [100,200,300,400,500,600,700,800,900,1000];

					xArr.pop();
					
							//차트------------------------------------------------------------------
						//	console.log('labelsArr[1]:' + labelsArr[1]);		
						//	console.log('dataArr[1]:' + dataArr[1]);
							const ctx3 = document.getElementById('myChart3')
									.getContext('2d');
							const myChart3 = new Chart(ctx3, {
								type : 'line',
								data : {
									labels : xArr, //x 축 제목  labelsArr = ['전국', '서울특별시', '부산광역시'  ......]
									datasets : [ 
										{
										label : '한국 확진자 현황', // 데이터 범례
										data : yArrGapnatDefCntkor, //y 축 숫자  dataArr = [40905177, 7652368, 2616908 ............]
										borderColor : "#b91d47",
										fill : false
									},
									{
										label : '일본 확진자 현황', // 데이터 범례
										data : yArrGapnatDefCntjap, //y 축 숫자  dataArr = [40905177, 7652368, 2616908 ............]
										borderColor : "#00aba9",
										fill : false
									},
									{
										label : '중국 확진자 현황', // 데이터 범례
										data : yArrGapnatDefCntchi, //y 축 숫자  dataArr = [40905177, 7652368, 2616908 ............]
										borderColor : "#2b5797",
										fill : false
									},	
									{
										label : '미국 확진자 현황', // 데이터 범례
										data : yArrGapnatDefCntusa, //y 축 숫자  dataArr = [40905177, 7652368, 2616908 ............]
										borderColor : "#e8c3b9",
										fill : false
									},
									{
										label : '독일 확진자 현황', // 데이터 범례
										data : yArrGapnatDefCntGer, //y 축 숫자  dataArr = [40905177, 7652368, 2616908 ............]
										borderColor : "#1e7145",
										fill : false
									},
									{
										label : '인도 확진자 현황', // 데이터 범례
										data : yArrGapnatDefCntInd, //y 축 숫자  dataArr = [40905177, 7652368, 2616908 ............]
										borderColor : "#8A2BE2",
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
							//차트------------------------------------------------------------------
						//	console.log('labelsArr[1]:' + labelsArr[1]);		
						//	console.log('dataArr[1]:' + dataArr[1]);
							const ctx4 = document.getElementById('myChart4')
									.getContext('2d');
							const myChart4 = new Chart(ctx4, {
								type : 'line',
								data : {
									labels : xArr, //x 축 제목  labelsArr = ['전국', '서울특별시', '부산광역시'  ......]
									datasets : [ 
										{
										label : '한국 사망자 현황', // 데이터 범례
										data : yArrGapnatDeathCntkor, //y 축 숫자  dataArr = [40905177, 7652368, 2616908 ............]
										borderColor : "#b91d47",
										fill : false
									},
									{
										label : '일본 사망자 현황', // 데이터 범례
										data : yArrGapnatDeathCntjap, //y 축 숫자  dataArr = [40905177, 7652368, 2616908 ............]
										borderColor : "#00aba9",
										fill : false
									},
									{
										label : '중국 사망자 현황', // 데이터 범례
										data : yArrGapnatDeathCntchi, //y 축 숫자  dataArr = [40905177, 7652368, 2616908 ............]
										borderColor : "#2b5797",
										fill : false
									},	
									{
										label : '미국 사망자 현황', // 데이터 범례
										data : yArrGapnatDeathCntusa, //y 축 숫자  dataArr = [40905177, 7652368, 2616908 ............]
										borderColor : "#e8c3b9",
										fill : false
									},
									{
										label : '독일 사망자 현황', // 데이터 범례
										data : yArrGapnatDeathCntGer, //y 축 숫자  dataArr = [40905177, 7652368, 2616908 ............]
										borderColor : "#1e7145",
										fill : false
									},
									{
										label : '인도 사망자 현황', // 데이터 범례
										data : yArrGapnatDeathCntInd, //y 축 숫자  dataArr = [40905177, 7652368, 2616908 ............]
										borderColor : "#8A2BE2",
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
						
						},
						error : function(xhr) {
							alert(xhr.status + ':' + xhr.statusText);
						}
					})
					
				}
		
	})

/* 코로나 현재상황  */
 $( function() {
	/* $('#gubun').on('change', function() {
		$('#btnGetData').click();		
	});  */   
		$.ajax( {
			//url     : 'http://localhost:9090/CovidStatus/covidstatus',
			url     : 'http://localhost:9090/covidstatus',
			// data    : { gubun : $('#gubun').val() },
			type    : 'GET',
			success : function( xml ) {
				console.log(xml);

					var html = '<ul>';
				$(xml).find('item').each(function( index ) {
					var gubun         = $(this).find('gubun').html();
					var defCnt        = $(this).find('defCnt').html();
					var deathCnt      = $(this).find('deathCnt').html();
					var incDec        = $(this).find('incDec').html();
					var localOccCnt   = $(this).find('localOccCnt').html();
					var isolIngCnt    = $(this).find('isolIngCnt').html();
					var isolClearCnt  = $(this).find('isolClearCnt').html();
					var qurRate       = $(this).find('qurRate').html();
					var stdDay        = $(this).find('stdDay').html();

					
					// html += '<li>시도명:' + $('#gubun').val() + '</li>' ;
					html += '<li>시도명:'           + gubun + '</li>' ;
					html += '<li>확진자 수:'        + defCnt + '</li>' ;
					html += '<li>사망자 수:'        + deathCnt + '</li>' ;
					html += '<li>전일대비 증감 수:' + incDec + '</li>' ;
					html += '<li>지역발생 수:'      + localOccCnt + '</li>' ;
					html += '<li>격리중 환자수:'    + isolIngCnt + '</li>' ;
					html += '<li>격리 해제 수:'     + isolClearCnt + '</li>' ;
					html += '<li>10만명당 발생률:'  + qurRate + '%</li>' ;
					html += '<li>기준일시:'         + stdDay + '</li><br>' ;
					
				})
					html  += '</ul>';
					$('#div1').html(html);
				    console.log(xml);
					console.log(html);
				
			},
			error : function(xhr) {
				alert(xhr.status + ':' + xhr.statusText);
			}
		});
});
 /* 잔여백신*/
	window.onload = function(){
	 	setTimeout(function() {
			  ifm()
			}, 2000);
		
		function ifm(){
		var url = document.getElementById('ifm');
		url.setAttribute("src", "https://m.place.naver.com/rest/vaccine?x=${lon}&y=${lat}");
		console.log('https://m.place.naver.com/rest/vaccine?x=${lon}&y=${lat}');
		}
		/*예방접종 */
		 
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
					var html = '<tr>'+
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
					const ctx7 = document.getElementById('myChart7').getContext('2d');
					const bColor = [ 'rgba(255, 99, 132, 1)', 'rgba(54, 162, 235, 1)', 'rgba(255, 206, 86, 1)', 'rgba(75, 192, 192, 1)', 'rgba(153, 102, 255, 1)', 'rgba(255, 159, 64, 1)' ];
					const myChart7 = new Chart(ctx7, {
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
				               
				            }
					    }
					});
					
					const ctx8 = document.getElementById('myChart8').getContext('2d');
					const myChart8 = new Chart(ctx8, {
						type: 'line',
					    data: {
					        labels: labelsArr_baseDate,
					        datasets: [{
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
			
					    }
					    }
					    });
					}
			}
		xhr.open('GET', '/vaccinestaticsevlet', true);
		xhr.send();
	}

</script>
</head>
<body>


 <%@ include file="/include/toptopnav.jsp" %>

<div class="title" id="mytitle"><h2>HOME</h2></div>
 <%@ include file="/include/topnav.jsp" %>
 <%@ include file="/include/chat.jsp" %>


<div class="container-fluid ">
<div class="row row-cols-1 row-cols-md-2 g-2 g-sm-5 border-light">
	<div class="col">
	<div class="p-3 border border-3 border-success rounded" id ="countryCovidCharthome1"">	
	<div class ="countryCovidChartDiv"  OnClick="location.href='/view/CovidStatusview.jsp'">국내 확진자 현황</div>
   		<canvas id="myChart1" ></canvas>
   		</div>
   	</div>
	<div class="col">
        	<div class="p-3 border border-3 border-success rounded" id ="countryCovidCharthome2" >	
	<div class ="countryCovidChartDiv" OnClick="location.href='/view/CovidStatusview.jsp'">확진자 전일대비 증감 수</div>
   		<canvas id="myChart2" ></canvas>
   		</div>
   	</div>

  
	<div class="col">
    		<div class="p-3 border border-3 border-success rounded" id ="countryCovidCharthome1">	
				<div class ="countryCovidChartDiv" OnClick="location.href='/view/CountryCovidStatus.jsp'">주요국 일일 확진자 현황</div>
   			<canvas id="myChart3" ></canvas>
   			</div>
   	</div>
	<div class="col">
   		 <div class="p-3 border border-3 border-success rounded" id ="countryCovidCharthome2">
				<div class ="countryCovidChartDiv" OnClick="location.href='/view/CountryCovidStatus.jsp'">주요국 일일 사망자 현황</div>
   			<canvas id="myChart4" ></canvas>
   			</div>
   	</div>
   	
	<div class="col">
   			<!-- 예방접종현황 -->
		<div class="p-3 border border-3 border-success rounded" id ="vacstatushome1">
		<div id = "vacstatushome1div" OnClick="location.href='/view/VaccineStatics.jsp'">우리지역 1차, 2차 접종률</div>
	   		<canvas id="myChart7" ></canvas>
   	
   	</div>
   	</div>
   	
	<div class="col">
	   	<div class="p-3 border border-3 border-success rounded" id ="vacstatushome2">
	   	<div id="vacstatushome1div" OnClick="location.href='/view/VaccineStatics.jsp'">우리지역 3차 접종률</div>
	   		<canvas id="myChart8"></canvas>
   
  </div>
   	</div>
<!--잔여백신  -->
	<div class="col-12" style="width: 100%;">
 	<div class="p-3 border border-3 border-success rounded" class="iframebox">
	<div id="noshowvaccinehome" OnClick="location.href='/view/NoShowVaccine.jsp'">잔여백신</div>
 	
		<iframe id="ifm" src="" style="width: 100%; height: 600px;"></iframe>
<%-- 		<iframe id="ifm" src="https://m.place.naver.com/rest/vaccine?x=${lon}&y=${lat }" width="600" height="600"></iframe> --%>
	</div>
	</div>
		
		<!--homenews  -->
	<div class="col-12" style="width: 100%;">
	<div id="homenews" class="p-3 border border-3 border-success rounded" >
	<div id="homenewstitle" OnClick="location.href='/view/News.jsp'">뉴스</div>
		<div id="newscontent" class="row row-cols-1 row-cols-md-5 g-4 border border-light " style="margin: 10px 20px;">
		</div>
		</div>
	</div>
	<!--homevideo news  -->
	<div class="col-12" style="width: 100%;">
	<div id="homevideonews" class="p-3 border border-3 border-success rounded" >
	 <div id="homevideonewstitle" OnClick="location.href='/view/YoutubNews.jsp'">동영상 뉴스</div>
		<div id="videonewscontent" class="row row-cols-1 row-cols-md-5 g-4 border border-light " style="margin: 10px 20px;">
		</div>
		</div>
	</div>
	<!--homevideo news  -->
		
</div>
</div>  


 <%@ include file="/include/bottomnav.jsp" %>




</body>
</html>
