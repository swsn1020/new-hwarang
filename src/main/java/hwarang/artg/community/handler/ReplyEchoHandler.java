package hwarang.artg.community.handler;

import java.util.ArrayList;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.util.StringUtils;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import hwarang.artg.community.interceptor.SessionNames;
import hwarang.artg.member.model.MemberVO;




public class ReplyEchoHandler extends TextWebSocketHandler{
	List<WebSocketSession> sessions = new ArrayList<>();
	Map<String, WebSocketSession> userSessions = new HashMap<>();
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception{
//		System.out.println("afterConnectionEstablished:" + session);
		String senderId = getId(session);
		userSessions.put(senderId,session);
		
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		String senderId = getId(session);
//		for (WebSocketSession sess: sessions) {
//		sess.sendMessage(new TextMessage(senderId + ": " + message.getPayload()));
//		}
		
		//protocol : cmd(다른기능쓸수도있으니),작성자,게시글 작성자,(reply,user2,user1,234번게시글)
		String msg = message.getPayload();
		if (StringUtils.hasText(msg)) {
			String[] strs = msg.split(",");
			if (strs != null && strs.length == 4) {
				String cmd = strs[0];
				String replyWriter = strs[1];
				String boardWriter = strs[2];
				String bno = strs[3];
				
				WebSocketSession boardWriterSession = userSessions.get(boardWriter);
				if ("reply".equals(cmd) && boardWriterSession != null) {
					TextMessage tmpMsg = new TextMessage(replyWriter + "님이 "
							+ "<a href='/board/freeboardView?num=" + bno + "'>" + bno + "</a>번 게시글에 댓글을 달았습니다!");
					boardWriterSession.sendMessage(tmpMsg);
				}
			}
		}
	}
	
	private String getId(WebSocketSession session) {
		Map<String,Object> httpSession = session.getAttributes();
		MemberVO loginUser = (MemberVO)httpSession.get(SessionNames.LOGIN);
		if (null == loginUser)
			return session.getId();
		else
			return loginUser.getMember_id();
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		
		
	}
}
