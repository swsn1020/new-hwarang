package hwarang.artg.manager.controller;

import java.security.Principal;
import java.util.Map;

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
	
	@RequestMapping("/main")
	public String showMainPage(Model model, HttpSession session, Principal principal) {
//		System.out.println("Manager Main 요청들어옴");
		Map<String, Object> results = managerService.MangerMainResults();
		
		/* 총 멤버 수, 총 게시글 수, 총 댓글 수 */
		model.addAttribute("totalMembers", results.get("TOTM"));
		model.addAttribute("totalPosts", results.get("POST"));
		model.addAttribute("totalReplies", results.get("REPLY"));

		/* 최근 일주일  가입한 신규 회원 수 */
		model.addAttribute("newMemCount", results.get("NEWM"));
		/* 이번달 시작되는 전시회 수*/
		model.addAttribute("ExhiCountMonth", results.get("TOTE"));
		/* Funding Total Price */
		model.addAttribute("totalFP", results.get("PRICE"));
		
		/* QNA, BLOCKSTATUS 5개씩 출력 */
		model.addAttribute("qnaList", qnaService.qnaGetByRegDate());
		model.addAttribute("blockList", blockService.blockGetByRegDate());
		
		/* 그래프  - 오늘 등록된 게시글 수 */
		model.addAttribute("qnaTC", results.get("TOTQ"));
		model.addAttribute("reportTC", results.get("TOTREP"));
		model.addAttribute("blockTC", results.get("TOTB"));
		model.addAttribute("reviewBTC", results.get("TOTREV"));
		model.addAttribute("freeBTC", results.get("TOTF"));
		model.addAttribute("recommBTC", results.get("TOTREC"));
		
		//sidebar에 저장될 내용
		String id = principal.getName();
		session.setAttribute("memName", memberService.memberGetOne(id).getMember_name());
		session.setAttribute("memId", id);
		
		/* Review 게시판 불러오기 */
		model.addAttribute("reviewList", managerService.getReviewsTop());
		
		return "manager/adminMain";
	}
	
	@RequestMapping("/memberList")
	public String showMemberList(CriteriaDTO cri, Model model) {
//		System.out.println("admin/memberList 요청");
		PageDTO page = new PageDTO(cri, managerService.totalMemCount(cri));
		model.addAttribute("pageMaker", page);
		model.addAttribute("memberList", managerService.pagingList(cri));
		return "manager/member/memberList";
	}
	
	@RequestMapping("/memberAuth")
	public String setMemberAuths(CriteriaDTO cri, Model model) {
//		System.out.println("member Auth Settings 요청");
		PageDTO page = new PageDTO(cri, managerService.totalMemCount(cri));
		model.addAttribute("pageMaker", page);
		model.addAttribute("memberList", managerService.pagingList(cri));
		return "manager/member/memberSettings";
	}
	
	@RequestMapping(value="/delMember", method = RequestMethod.POST)
	public String deleteAccount(String member_id, Model model) {
//		System.out.println("delMember 요청 들어옴");
		String msg = "탈퇴 처리에 실패하였습니다.";
		if(memberService.memberRemove(member_id)) {
			msg = "탈퇴 처리 되었습니다.";
		}
		model.addAttribute("url", "memberAuth");
		model.addAttribute("msg", msg);
		return "manager/result";
	}
	
	@MessageMapping("/client/send/{var}")
	@SendTo("/category/msg/{var}")
	public String chatMessage(String message, @DestinationVariable(value ="var") String variable) {
//		System.out.println("var : " + variable);
//		System.out.println("managerController message: "+message);
		return message;
	}
	

	

}
