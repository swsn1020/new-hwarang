package hwarang.artg.common.model;

import java.util.HashMap;
import java.util.Map;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;

import hwarang.artg.community.model.FreeBoardVO;
import hwarang.artg.community.model.FreeReplyVO;
import hwarang.artg.manager.model.BlockStatusVO;
import hwarang.artg.manager.model.FAQVO;
import hwarang.artg.manager.model.ManagerAlarmVO;
import hwarang.artg.manager.model.NoticeReplyVO;
import hwarang.artg.manager.model.NoticeVO;
import hwarang.artg.manager.model.QnAVO;
import hwarang.artg.manager.model.ReportVO;
import hwarang.artg.manager.service.ManagerAlarmService;
import hwarang.artg.rrboard.model.RecommendBoardVO;
import hwarang.artg.rrboard.model.RecommendReplyVO;
import hwarang.artg.rrboard.model.ReviewBoardVO;
import hwarang.artg.rrboard.model.ReviewReplyVO;

@Aspect
public class MessageAspect{
	@Autowired
	private SimpMessagingTemplate template;
	@Autowired
	private ManagerAlarmService alarmService;

	
	@Pointcut("execution(* hwarang.artg..controller.*.*Register(..))")
	public void registerAlarmpt() {}
	
//	@Before("registerAlarmpt()")
//	public void beforeRegister() {
//		System.out.println("AOP 작동, 글 등록 전!!");
//	}
	
	@AfterReturning("registerAlarmpt()")
	public void afterRegister(JoinPoint jp) {
		System.out.println("AOP 작동, 글 등록 성공!!");
		Object[] params = jp.getArgs();
		ManagerAlarmVO alarm = new ManagerAlarmVO();
		alarm.setCategory("New_Board");
		
		//타입 검색
		if(params[0] instanceof NoticeVO) {
			NoticeVO notice = (NoticeVO)params[0];
			alarm.setBoardCategory("Notice_Board");
			alarm.setBoardNum(notice.getNum());
		}
		if(params[0] instanceof NoticeReplyVO) {
			NoticeReplyVO noticeReply = (NoticeReplyVO)params[0];
			alarm.setBoardCategory("Notice_Reply");
			//해당 게시판으로 이동(댓글의 경우)
			alarm.setBoardNum(noticeReply.getBoardNum());
		}
		if(params[0] instanceof FAQVO) {
			FAQVO faq = (FAQVO)params[0];
			alarm.setBoardCategory("FAQ_Board");
			alarm.setBoardNum(faq.getNum());
		}
		if(params[0] instanceof QnAVO) {
			QnAVO qna = (QnAVO)params[0];
			alarm.setBoardCategory("QnA_Board");
			alarm.setBoardNum(qna.getNum());
		}
		if(params[0] instanceof ReportVO) {
			ReportVO report = (ReportVO)params[0];
			alarm.setBoardCategory("Report_Board");
			alarm.setBoardNum(report.getNum());
		}
		if(params[0] instanceof BlockStatusVO) {
			BlockStatusVO block = (BlockStatusVO)params[0];
			alarm.setBoardCategory("Block_Board");
			alarm.setBoardNum(block.getNum());
		}
		if(params[0] instanceof FreeBoardVO) {
			FreeBoardVO free = (FreeBoardVO)params[0];
			alarm.setBoardCategory("Free_Board");
			alarm.setBoardNum(free.getNum());
		}
		if(params[0] instanceof FreeReplyVO) {
			FreeReplyVO freeReply = (FreeReplyVO)params[0];
			alarm.setBoardCategory("Free_Reply");
			alarm.setBoardNum(freeReply.getBoardNum());
		}
		if(params[0] instanceof RecommendBoardVO) {
			RecommendBoardVO recommend = (RecommendBoardVO)params[0];
			alarm.setBoardCategory("Recommend_Board");
			alarm.setBoardNum(recommend.getRecomm_num());
		}
		if(params[0] instanceof RecommendReplyVO) {
			RecommendReplyVO recommendReply = (RecommendReplyVO)params[0];
			alarm.setBoardCategory("Recommend_Reply");
			alarm.setBoardNum(recommendReply.getRecomm_num());
		}
		if(params[0] instanceof ReviewBoardVO) {
			ReviewBoardVO review = (ReviewBoardVO)params[0];
			alarm.setBoardCategory("Review_Board");
			alarm.setBoardNum(review.getReview_num());
		}
		if(params[0] instanceof ReviewReplyVO) {
			ReviewReplyVO reviewReply = (ReviewReplyVO)params[0];
			alarm.setBoardCategory("Review_Reply");
			alarm.setBoardNum(reviewReply.getReview_num());
		}
		if(alarmService.alarmRegister(alarm)) {
			System.out.println("alarm 등록 성공");
			Map<String, Object> alMap = alarmService.checkAlarmCategory(alarm);
			//메시지 보내기
//			String text = alMap+" 새로운 글이 등록되었습니다.";
			
			this.template.convertAndSend("/category/msg/id1", alMap);
		}else {
			System.out.println("alarm 등록 실패");
		}
		
	}

	@Pointcut("execution(* hwarang.artg.member.controller.MemberController.showJoin(..))")
	public void joinAlarmpt() {}
	
	@AfterReturning("joinAlarmpt()")
	public void afterJoin(JoinPoint jp) {
		System.out.println("회원가입 알람 AOP 작동!!! ");
		Object[] params = jp.getArgs();
		//params[0] == id
		ManagerAlarmVO alarm = new ManagerAlarmVO();
		alarm.setCategory("New_Member");
		alarm.setBoardCategory(params[0]+"_Member");
		System.out.println(alarm.getBoardCategory());
		alarm.setBoardNum(0);
		if(alarmService.alarmRegister(alarm)) {
			System.out.println("alarm 등록 성공");
			Map<String, Object> alMap = alarmService.checkAlarmCategory(alarm);
			this.template.convertAndSend("/category/msg/id1", alMap);
		}else {
			System.out.println("Alarm 등록 실패");
		}
	}
	
}
