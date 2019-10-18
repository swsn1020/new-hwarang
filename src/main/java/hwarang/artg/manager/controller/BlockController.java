package hwarang.artg.manager.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import hwarang.artg.common.model.CriteriaDTO;
import hwarang.artg.common.model.PageDTO;
import hwarang.artg.manager.model.BlockStatusVO;
import hwarang.artg.manager.service.BlockStatusService;
import hwarang.artg.member.model.MemberAuthVO;
import hwarang.artg.member.service.MemberAuthService;
import hwarang.artg.member.service.MemberService;

@Controller
@RequestMapping("/block")
public class BlockController {
	@Autowired
	private BlockStatusService service;
	@Autowired
	private PasswordEncoder pwEncoder;
	@Autowired
	private MemberService memService;
	@Autowired
	private MemberAuthService memAuthService;
	
	
	@RequestMapping("/blockListForManager")
	public String showBlockListM(CriteriaDTO cri, Model model) {
		System.out.println("blockList요청 For Manager");
		PageDTO page = new PageDTO(cri, service.getTotalCount());
		model.addAttribute("pageMaker", page);
		model.addAttribute("blockList", service.pagingList(cri));
		return "manager/block/managerBlockList";
	}
	
	@RequestMapping("/blockListForUser")
	public String showBlockListU(CriteriaDTO cri, Model model, Principal principal) {
		System.out.println("blockList요청 For User");
		//기본
//		List<BlockStatusVO> blockList = service.blockGetAllById(memId);
//		model.addAttribute("blockList", blockList);
		String id = principal.getName();

		//페이징처리 + 행번호로 출력
		PageDTO page = new PageDTO(cri, service.getTotalCount(id));
		model.addAttribute("pageMaker", page);
		model.addAttribute("blockList", service.pagingList(cri, id));
		return "manager/block/userBlockList";
	}
	
	
	@RequestMapping(value="form", method=RequestMethod.POST)
	public String showBlockForm(String blockMemId, String category, String boardNum, String replyNum, String boardTitle, Model model) {
		//게시판_상세보기에서 신고버튼 클릭
		System.out.println("신고 팝업 요청");
//		Map<String, Object> params = new HashMap<String, Object>();
//		params.put("category", category);
		model.addAttribute("blockMemId", blockMemId);
		model.addAttribute("category", category);
		model.addAttribute("boardTitle", boardTitle);
//		System.out.println(category.substring(category.indexOf("_")+1).equals("Board"));
		if(category.substring(category.indexOf("_")+1).equals("Board")) {
			model.addAttribute("boardNum", boardNum);
		}else if(category.substring(category.indexOf("_")+1).equals("Reply")) {
			model.addAttribute("boardNum", replyNum);
		}
		return "manager/block/blockPopup";
	}
	
	@ResponseBody
	@RequestMapping(value="/blockRegister", method=RequestMethod.POST)
	public boolean doBlockRegister(BlockStatusVO block) {
		return service.blockRegister(block);
	}
	
	@RequestMapping(value="/blockModify", method=RequestMethod.GET)
	public String showBlockModify(int num, Model model) {
		model.addAttribute("block", service.blockGetOne(num));
		return "manager/block/blockModify";
	}
	
//	@ResponseBody
	@RequestMapping(value="replyModify", method=RequestMethod.POST)
	public String doReplyModify(@RequestParam("num")int num, @RequestParam("reply")String reply, Model model) {
		System.out.println("replyModify 요청 들어옴");
		String msg = "처리에 실패하였습니다.";
		String url = "/block/blockListForManager";
		if(reply.contains("삭제")) {
			service.doCheckCategory(num);
			String id = service.blockGetOne(num).getBlockMemId();
			if(memService.memberGetOne(id) != null) {
				if(memService.doMemberCountBlock(id)) {
					System.out.println("Member Report Count up!");
				}
			}else{
				System.out.println("해당하는 id의 멤버가 없습니다.");
			}
			if(service.replyModify(reply, num)) {
				msg = "신고 처리가 완료되었습니다.";
			}else {
				url = "/block/blockView?num="+num;
			}
		}
		model.addAttribute("url", url);
		model.addAttribute("msg", msg);
		return "manager/result";
	}
	
	//blockView 설정**
	@RequestMapping("blockView")
	public String showBlockView(int num, Model model, Principal principal) {
		System.out.println("blockView 요청 들어옴");
//		String id = principal.getName();
//		BlockStatusVO block = service.blockGetOne(num);
		Map<String, Object> maps = service.doCheckBlock(num);
		System.out.println(maps.toString());
		model.addAllAttributes(service.doCheckBlock(num));
		return "manager/block/blockView";
		
		
	}
	
	@RequestMapping(value="/checkPw", method=RequestMethod.POST)
	public String doCheckPw(int num, String type, String password, Model model, Principal principal) {
		System.out.println("checkPw요청들어옴 ");
		String id = principal.getName();
		String originPw = memService.memberGetOne(id).getMember_password();
		String url = "blockListForUser?memId="+id;
		String msg = "";
		BlockStatusVO block = service.blockGetOne(num);
		if(block != null && pwEncoder.matches(password, originPw)) {
			//비밀번호 일치
			if(type.equals("delete")) {
				// 삭제요청
				if(service.blockRemove(num)) {
					//삭제 성공(파일 삭제) >> 이동할 화면
					System.out.println("Block삭제 성공");
					msg = "Block가 삭제되었습니다";
				}else {
					//삭제실패
					url = "blockView?num="+num;
					msg = "Block삭제에 실패하였습니다.";
					System.out.println("Block삭제 실패");
				}
			}else if(type.equals("modify")) {
				//수정요청 (수정폼 불러오기)
				System.out.println("수정요청");
				return "redirect:blockModify?num="+num;
			}
		}else {
			//비밀번호 불일치
			System.out.println("비밀번호가 틀렸습니다.");
			msg = "비밀번호를 다시 확인하세요.";
			url = "blockView?num="+num;
		}
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		return "manager/result";
	}
	
	//user 권한 없애기
	@Transactional
	@RequestMapping(value="/blockMember", method=RequestMethod.POST)
	public String doBlockMember(@RequestParam("member_id")String id, Model model) {
		String msg = id+"님의 계정차단에 실패하였습니다.";
		String url = "/admin/memberAuth";
		//'ROLE_USER' 권한 제거하기
		if(memService.memberGetOne(id) != null) {
			//회원 아이디 있음
			MemberAuthVO ma = new MemberAuthVO();
			ma.setMember_id(id);
			ma.setMember_auth("ROLE_USER");
			System.out.println(ma);
			if(memAuthService.memberauthRemove(ma)) {
				if(memService.doMemberStatusBlock(id)) {
					msg = id+"님의 활동정지가 설정되었습니다.";
				}else {
					// disabled 설정에 실패
					System.out.println("활동 정지 실패(disabled실패)");
				}
			}else {
				// 'ROLE_USER' 권한 빼기 실패(이미 없는 경우)
				System.out.println("권한빼기 실패(role_user)");
				msg = "이미 활동 정지 처리된 아이디 입니다.";
			}
		}else {
			//해당하는 아이디 찾을수 없음
			System.out.println("해당하는 아이디의 멤버 없음");
			msg = "해당하는 아이디의 Member가 없습니다";
		}
		model.addAttribute("url", url);
		model.addAttribute("msg", msg);
		return "manager/result";
	}
	
	@ResponseBody
	@RequestMapping(value="/unCheckBlocks")
	public int getUnCheckBlocks() {
		return service.getBlockCountNotChecked();
	}
}
