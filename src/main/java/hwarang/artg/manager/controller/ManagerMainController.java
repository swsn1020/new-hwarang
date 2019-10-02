package hwarang.artg.manager.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
	public String showMainPage(Model model) {
		System.out.println("Manager Main 요청들어옴");
		/* 총 멤버 수, 총 게시글 수, 총 댓글 수 */
		model.addAttribute("totalMembers", managerService.memberCounts());
		model.addAttribute("totalPosts", managerService.totalPost());
		model.addAttribute("totalReplies", managerService.totalReply());
		

		/* 최근 일주일  가입한 신규 회원 수 */
		model.addAttribute("newMemCount", managerService.newMemberCount());
		/* 이번달 시작되는 전시회 수*/
		model.addAttribute("ExhiCountMonth", managerService.thisMonthExhiCount());
		
		
		/* QNA, BLOCKSTATUS 5개씩 출력 */
		model.addAttribute("qnaList", qnaService.qnaGetByRegDate());
		model.addAttribute("blockList", blockService.blockGetByRegDate());
		
		/* 각 게시판 그래프 그리기 - 오늘 등록된 게시글 수 */
		model.addAttribute("qnaTC", managerService.qnaTodayCount());
		model.addAttribute("reportTC", managerService.reportTodayCount());
		model.addAttribute("blockTC", managerService.blockTodayCount());
		model.addAttribute("reviewBTC", managerService.reviewBTodayCount());
		model.addAttribute("freeBTC", managerService.freeBTodayCount());
		model.addAttribute("recommBTC", managerService.RecommBTodayCount());
		
		model.addAttribute("blockCnt", blockService.getBlockCountNotChecked());
		return "manager/adminMain";
	}
	
	@RequestMapping("/memberList")
	public String showMemberList(CriteriaDTO cri, Model model) {
		System.out.println("admin/memberList 요청");
		PageDTO page = new PageDTO(cri, managerService.totalMemCount(cri));
		model.addAttribute("pageMaker", page);
		model.addAttribute("memberList", managerService.pagingList(cri));
		return "manager/member/memberList";
	}
	
	@RequestMapping("/newMemberList")
	public String showNeMemberList(Model model) {
		System.out.println("admin/newMemberList 요청");
		model.addAttribute("memberList", managerService.newMemberList());
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
	
	

}
