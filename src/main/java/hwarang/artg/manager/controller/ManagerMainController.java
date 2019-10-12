package hwarang.artg.manager.controller;

import java.security.Principal;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import hwarang.artg.common.model.CriteriaDTO;
import hwarang.artg.common.model.PageDTO;
import hwarang.artg.manager.service.BlockStatusService;
import hwarang.artg.manager.service.ManagerAlarmService;
import hwarang.artg.manager.service.ManagerMainService;
import hwarang.artg.manager.service.QnAService;
import hwarang.artg.member.service.MemberService;

@Controller
@RequestMapping("/admin")
public class ManagerMainController {
	@Autowired
	private QnAService qnaService;
	@Autowired
	private BlockStatusService blockService;
	@Autowired
	private ManagerMainService managerService;
	@Autowired
	private MemberService memberService;
	@Autowired
	private ManagerAlarmService alarmService;
	
	
	
	@RequestMapping("/main")
	public String showMainPage(Model model, HttpSession session, Principal principal) {
		System.out.println("Manager Main 요청들어옴");
		/* 총 멤버 수, 총 게시글 수, 총 댓글 수 */
		model.addAttribute("totalMembers", managerService.memberCounts());
		model.addAttribute("totalPosts", managerService.totalPost());
		model.addAttribute("totalReplies", managerService.totalReply());

		/* 최근 일주일  가입한 신규 회원 수 */
		model.addAttribute("newMemCount", managerService.newMemberCount());
		/* 이번달 시작되는 전시회 수*/
		model.addAttribute("ExhiCountMonth", managerService.thisMonthExhiCount());
		/* Funding Total Price */
		model.addAttribute("totalFP", managerService.getTotalPrice());
		
		/* QNA, BLOCKSTATUS 5개씩 출력 */
		model.addAttribute("qnaList", qnaService.qnaGetByRegDate());
		model.addAttribute("blockList", blockService.blockGetByRegDate());
		
		/* 그래프  - 오늘 등록된 게시글 수 */
		model.addAttribute("qnaTC", managerService.qnaTodayCount());
		model.addAttribute("reportTC", managerService.reportTodayCount());
		model.addAttribute("blockTC", managerService.blockTodayCount());
		model.addAttribute("reviewBTC", managerService.reviewBTodayCount());
		model.addAttribute("freeBTC", managerService.freeBTodayCount());
		model.addAttribute("recommBTC", managerService.RecommBTodayCount());
		
		//sidebar에 저장될 내용
		String id = principal.getName();
		session.setAttribute("memName", memberService.memberGetOne(id).getMember_name());
		session.setAttribute("memId", id);
		session.setAttribute("blockCnt", blockService.getBlockCountNotChecked());
		
		/* Review 게시판 불러오기 */
		model.addAttribute("reviewList", managerService.getReviewsTop());
		
		//알람 등록
		session.setAttribute("alarmCnt", alarmService.unReadAlarmCount());
		//알람리스트
//		session.setAttribute("alarmList", alarmService.getFourAlarms());
//		System.out.println("manager controller alarmList: "+alarmService.getFourAlarms());
		
		return "manager/adminMain";
	}
	
	@RequestMapping("/memberList")
	public String showMemberList(CriteriaDTO cri, Model model) {
		System.out.println("admin/memberList 요청");
		PageDTO page = new PageDTO(cri, managerService.totalMemCount(cri));
		model.addAttribute("pageMaker", page);
		model.addAttribute("memberList", managerService.pagingList(cri));
		model.addAttribute("blockCnt", blockService.getBlockCountNotChecked());
		return "manager/member/memberList";
	}
	
	@RequestMapping("/delMember")
	public String deleteAccount(String member_id, Model model) {
		System.out.println("delMember 요청 들어옴");
		String msg = "탈퇴 처리에 실패하였습니다.";
		if(memberService.memberRemove(member_id)) {
			msg = "탈퇴 처리 되었습니다.";
		}
		model.addAttribute("url", "memberList");
		model.addAttribute("msg", msg);
		return "result";
	}
	
	@MessageMapping("/client/send/{var}")
	@SendTo("/category/msg/{var}")
	public String chatMessage(String message, @DestinationVariable(value ="var") String variable) {
		System.out.println("var : " + variable);
		System.out.println("managerController message: "+message);
		return message;
	}
	

	

}
