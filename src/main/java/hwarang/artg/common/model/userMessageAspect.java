package hwarang.artg.common.model;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;

import hwarang.artg.community.model.AlarmVO;
import hwarang.artg.community.model.FreeReplyVO;
import hwarang.artg.community.service.AlarmService;
import hwarang.artg.manager.model.NoticeReplyVO;
import hwarang.artg.rrboard.model.RecommendReplyVO;
import hwarang.artg.rrboard.model.ReviewReplyVO;

@Aspect
public class userMessageAspect {
	@Autowired
	private SimpMessagingTemplate template;
	
	@Autowired
	private AlarmService service;
	
	@Pointcut("execution(* hwarang.artg..controller.*.*Register(..))")
	public void registerAlarm() {
		
	}
	@AfterReturning("registerAlarm()")
	public void afterRegisterR(JoinPoint joinpoint) {
		System.out.println("재근 AOP작동");
		Object[] params = joinpoint.getArgs();
		AlarmVO alarm = new AlarmVO();
		alarm.setAlarm_category("New_Board");
		
		if(params[0] instanceof NoticeReplyVO) {
			NoticeReplyVO noticeReply = (NoticeReplyVO)params[0];
			alarm.setBoard_Category("Notice_Reply");
			//해당 게시판으로 이동(댓글의 경우)
			alarm.setBoard_num(noticeReply.getBoardNum());
		}
		if(params[0] instanceof FreeReplyVO) {
			FreeReplyVO freeReply = (FreeReplyVO)params[0];
			alarm.setBoard_Category("Free_Reply");
			alarm.setBoard_num(freeReply.getBoardNum());
		}
		if(params[0] instanceof RecommendReplyVO) {
			RecommendReplyVO recommendReply = (RecommendReplyVO)params[0];
			alarm.setBoard_Category("Recommend_Reply");
			alarm.setBoard_num(recommendReply.getRecomm_num());
		}
		if(params[0] instanceof ReviewReplyVO) {
			ReviewReplyVO reviewReply = (ReviewReplyVO)params[0];
			System.out.println("parms[0]"+reviewReply);
			alarm.setBoard_Category("Review_Reply");
			alarm.setBoard_num(reviewReply.getReview_num());
		}
		if(service.alarmRegister(alarm)) {
			System.out.println("재근 alarm 등록 성공");
			//메시지 보내기
			String text = alarm+" 새로운 글이 등록되었습니다.";
			this.template.convertAndSend("/category/msg/id1", text);
		}else {
			System.out.println("alarm 등록 실패");
		}
	}

}
