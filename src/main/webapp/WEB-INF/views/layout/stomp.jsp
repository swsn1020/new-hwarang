<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript" src="/resources/js/sockjs.js"></script>
<script type="text/javascript" src="/resources/js/stompjs.js"></script>
<script>
	$(function(){
		connect();
	});
	var sock;
	var stompClient;
	//연결
	function connect(){
		//등록한 WebSocket Endpoint 설정
		sock = new SockJS("/chat");
		//연결만 SockJS 이용하고 나머지는 Stomp사용
		stompClient = Stomp.over(sock);
		stompClient.connect({}, function(){
			//연결되면 어떤 식으로 메시지 처리할지 작성
			//어떤 메시지 받을 건지 결정하는 부분
			stompClient.subscribe("/category/msg/", function(message){
				//작성된 url로 메시지 들어오면 함수 실행
				console.log("message: "+JSON.stringify(message));
			});
		});
	}
	function sendMsg(){
		var msg = "새로운 글이 등록되었습니다.";
		stompClient.send("/client/send/", {}, msg);
	}
</script>