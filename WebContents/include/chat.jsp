<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="/css/chat.css">
	
	<title>my 코로나 채팅</title>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
	<script type="text/javascript">


	
		var lastID = 0;
// shift enter키 사용, enter키 전송
		$(function() {
			$('textarea').on('keydown', function(event) {
				if (event.keyCode == 13)
					if (!event.shiftKey) {
						event.preventDefault();
						var button = document.getElementById('submitbutton');

						button.click();
						$('textarea').empty()
					}
			});
		});
		
		
		

		function submitFunction() {
		
			
			var chatName = $('#chatName').val();
			var chatContent = $('#chatContent').val();
			var chatIp	= $('#chatGetIpText').val();
			$.ajax({
				type : "POST",
				url : "/chatSubmitServlet",
				data : {
					chatName : encodeURIComponent(chatName),
					chatContent : encodeURIComponent(chatContent),
					chatIp	:	encodeURIComponent(chatIp)
				},
				success : function(result) {
					if (result == 1) {
						autoClosingAlert('#successMessage', 2000);
					} else if (result == 0) {
						autoClosingAlert('#dangerMessage', 2000);
					} else {
						autoClosingAlert('#warningMessage', 2000);
					}
				}

			});
			$('#chatContent').val('');
		}

		function autoClosingAlert(selector, delay) {
			var alert = $(selector).alert();
			alert.show();
			window.setTimeout(function() {
				alert.hide()
			}, delay);
		}
		/* 채팅리스트 가져오기 */
		function chatListFunction(type) {
			$.ajax({
				type : "POST",
				url : "/chatListServlet",
				data : {
					listType : type
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
		}
		/* 챗 jsp에 뿌려주기 */
		function addChat(chatName, chatContent, chatTime) {
			$('#chatList')
					.append(
							'<div class="row" id="chatcontents">'
									+ '<div class="col-lg-12">'
									+ '<div class="media">'
									+ '<a class="pull-left" href="#">'
									+ '<img class="media-object img-circle" src="/img/icon.png" alt="">'
									+ '</a>' + '<div class="media-body">'
									+ '<h4 class="media-heading">' + chatName
									+ '<span class="small pull-right">'
									+ chatTime + '</span>' + '</h4>' + '<p>'
									+ chatContent + '</p>' + '</div>'
									+ '</div>' + '</div>' + '</div>' + '<hr>');
			$('#chatList').scrollTop($('#chatList')[0].scrollHeight);
		}
		//실시간 채팅 업데이트
		function getInfiniteChat() {
		 let timer = setInterval(function() {
				chatListFunction(lastID);
			}, 1000);
		}
		
		function stopgetchat() {
        clearInterval(timer);

			}
		

	/* 채팅 아이콘 클릭시 실행  */
	$(function(){
		
		$("#chatclose").on({
			"click" : function(){
				if ($("#icon").attr("class") == "far fa-comment-dots") {
	                $("#icon").attr("class", "fas fa-comment-dots");
	                $("#_chatbox").css("display", "none");
	                alert(timer);
	                stopgetchat();
	            }
			}
		})
		
    $("#mydiv").on({
        "click" : function() {
        	//ip 가져오기
        	$.getJSON("https://api.ipify.org?format=jsonp&callback=?",			
					function(json) {
					var getip ='';
					getip 		+= '<div>';
					getip		+=	'<input type="hidden" id="chatGetIpText" value="'+ json.ip +'">';
					getip 		+= '</div>';
					/* document.write(json.ip); */
					$('#chatGetIpDiv').html(getip);
					}
				);
        	
             if ($("#icon").attr("class") == "fas fa-comment-dots") {
                $("#icon").attr("class", "far fa-comment-dots");
                $("#_chatbox").css("display", "block");

            		$(document).ready(function() {
            			/* chatListFunction('ten'); */
            			getInfiniteChat();
            		});
             }  else if ($("#icon").attr("class") == "far fa-comment-dots") {
                $("#icon").attr("class", "fas fa-comment-dots");
                $("#_chatbox").css("display", "none");
                stopgetchat();
            }
        }
    });
	
	
	//채팅 아이콘 버튼 릴리즈 놓기
dragElement(document.getElementById("mydiv"));

function dragElement(elmnt) {
  var pos1 = 0, pos2 = 0, pos3 = 0, pos4 = 0;
  if (document.getElementById(elmnt.id + "header")) {
    /* if present, the header is where you move the DIV from:*/
    document.getElementById(elmnt.id + "header").onmousedown = dragMouseDown;
  } else {
    /* otherwise, move the DIV from anywhere inside the DIV:*/
    elmnt.onmousedown = dragMouseDown;
  }

  function closeDragElement() {
    /* stop moving when mouse button is released:*/
    document.onmouseup = null;
    document.onmousemove = null;
  }
}
	})
	
	//채팅창 드래그 기능
	$(function(){
		dragElement(document.getElementById("_chatbox"));

		function dragElement(elmnt) {
		  var pos1 = 0, pos2 = 0, pos3 = 0, pos4 = 0;
		  if (document.getElementById(elmnt.id + "header")) {
		    /* if present, the header is where you move the DIV from:*/
		    document.getElementById(elmnt.id + "header").onmousedown = dragMouseDown;
		  } else {
		    /* otherwise, move the DIV from anywhere inside the DIV:*/
		    elmnt.onmousedown = dragMouseDown;
		  }

		  
		  function dragMouseDown(e) {
		    e = e || window.event;
		    e.preventDefault();
		    // get the mouse cursor position at startup:
		    pos3 = e.clientX;
		    pos4 = e.clientY;
		    document.onmouseup = closeDragElement;
		    // call a function whenever the cursor moves:
		    document.onmousemove = elementDrag;
		  }

		  function elementDrag(e) {
		    e = e || window.event;
		    e.preventDefault();
		    // calculate the new cursor position:
		    pos1 = pos3 - e.clientX;
		    pos2 = pos4 - e.clientY;
		    pos3 = e.clientX;
		    pos4 = e.clientY;
		    // set the element's new position:
		    elmnt.style.top = (elmnt.offsetTop - pos2) + "px";
		    elmnt.style.left = (elmnt.offsetLeft - pos1) + "px";
		  }

		  function closeDragElement() {
		    /* stop moving when mouse button is released:*/
		    document.onmouseup = null;
		    document.onmousemove = null;
		  }
		}
	
	})
	
	
	
</script>




</head>
<body>

	
<div id="mydiv">
  <div id="mydivheader" style='font-size:24px' class="chat" >
  	<i class='fas fa-comment-dots' id="icon"></i>
  </div>
</div>

<script>

</script>




	<div class="container Chat" id="_chatbox" style="display: none">
		<div class="container Chat boostrap snippet">
			<div class="row Chat" >
				<div class="col-xs-12" id="chatborder" > 
					<div class="portlet portlet-default" id="_chatboxheader">
						<div class="portlet-title" >
							<h4  id="chattitle"><i class="fa fa-circle text-green"></i>  MY코로나 채팅방</h4>
						<div id="chatclose">close</div>
						</div>
						 <div id="chatb"  class="clearfix"></div>
						 	
					</div>
						<div id="chat Chat" class="panel-collapse collapse in">
							<div id="chatList" class="portlet-body chat-widget" style="overflow-y:auto; width: auto; height: 500px;">
				 
							</div>
							<div class="portlet-footer">
								<div class="row Chat">
									<div class="form-group col-xs-4" id="chatNameDiv">
										<input style="height: 40px;" type="text" id="chatName"
											class="form-control" placeholder="이름" maxlength="8">
									</div>
								</div>
								<div class="row Chat" style="height: 90px">
									<div class="form-group col-xs-10" id="chatContentDiv">
										<textarea style="height: 80px;" id="chatContent" class="form-control" placeholder="메시지를 입력하세요" maxlength="100"></textarea>
									</div>
										<div class="form-group col-xs-2" id="chatSubmitDiv">
											<button type="button" class="btn btn-default pull-right" id="submitbutton" onclick="submitFunction();">전송</button>
											<div class="clearfix"></div>
										</div>
										
										<div class="form-group col-xs-2" id="chatGetIpDiv">
											
										</div>
								</div>
							</div>
						</div>
						
				</div> 
			</div>
		</div>
		 
<!-- 		<div class="alert alert-success" id="successMessage" style="display: none;">
			<strong>메시지 전송에 성공하였습니다.</strong>
		</div>
		<div class="alert alert-danger" id="dangerMessage" style="display: none;">
			<strong>이름과 내용을 모두 입력해주세요.</strong>
		</div>
		<div class="alert alert-warning" id="warningMessage" style="display: none;">
			<strong>데이터베이스 오류가 발생했습니다.</strong>
		</div> -->
		 
	</div>

</body>
</html>