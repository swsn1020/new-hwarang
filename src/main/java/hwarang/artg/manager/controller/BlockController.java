package hwarang.artg.manager.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import hwarang.artg.common.model.CriteriaDTO;
import hwarang.artg.common.model.PageDTO;
import hwarang.artg.manager.model.BlockStatusVO;
import hwarang.artg.manager.service.BlockStatusService;
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
	
	
	@RequestMapping("/blockListForManager")
	public String showBlockListM(CriteriaDTO cri, Model model) {
		System.out.println("blockList요청 For Manager");
		PageDTO page = new PageDTO(cri, service.getTotalCount());
		model.addAttribute("pageMaker", page);
		model.addAttribute("blockList", service.pagingList(cri));
		return "manager/block/managerBlockList";
	}
	
	@RequestMapping("/blockListForUser")
	public String showBlockListU(String memId, CriteriaDTO cri, Model model, Principal principal) {
		System.out.println("blockList요청 For User");
		//기본
//		List<BlockStatusVO> blockList = service.blockGetAllById(memId);
//		model.addAttribute("blockList", blockList);
		String id = principal.getName();
		if(memId.equals(id)) {
			//페이징처리 + 행번호로 출력
			PageDTO page = new PageDTO(cri, service.getTotalCount(memId));
			model.addAttribute("pageMaker", page);
			model.addAttribute("blockList", service.pagingList(cri, memId));
			return "manager/block/userBlockList";
		}else {
			String msg = "해당 신고 접수자만 열람 가능합니다.";
			String url = "blockListForUser?memId="+id;
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
			return "manager/result";
		}
	}
	
	
	@RequestMapping(value="form", method=RequestMethod.POST)
	public String showBlockForm(String blockMemId, String category, String boardNum, String replyNum, Model model) {
		//게시판_상세보기에서 신고버튼 클릭
		System.out.println("신고 팝업 요청");
//		Map<String, Object> params = new HashMap<String, Object>();
//		params.put("category", category);
		model.addAttribute("blockMemId", blockMemId);
		model.addAttribute("category", category);
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
	
	@RequestMapping(value="blockModify", method=RequestMethod.GET)
	public String showBlockModify(int num, Model model) {
		model.addAttribute("block", service.blockGetOne(num));
		return "manager/block/blockModify";
	}
	
	@RequestMapping(value="blockModify", method=RequestMethod.POST)
	public String doBlockModify(BlockStatusVO block, Model model) {
		String url = "";
		String msg = "";
		if(service.blockModify(block)) {
			msg = "";
		}else {
			url = "";
		}
		model.addAttribute("url", url);
		model.addAttribute("msg", msg);
		return "manager/result";
	}
	
	@ResponseBody
	@RequestMapping(value="/replyModify", method=RequestMethod.POST)
	public boolean doReplyModify(int num, String reply) {
		System.out.println("replyModify 요청 들어옴");
		if(reply.contains("삭제")) {
			service.doCheckCategory(num);
		}
		return service.replyModify(reply, num);
	}
	
	@RequestMapping("blockView")
	public String showBlockView(int num, Model model) {
		System.out.println("blockView 요청 들어옴");
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
	
}
