package hwarang.artg.manager.controller;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import hwarang.artg.common.model.CriteriaDTO;
import hwarang.artg.common.model.PageDTO;
import hwarang.artg.manager.model.FAQVO;
import hwarang.artg.manager.service.FAQService;
import hwarang.artg.member.model.MemberVO;
import hwarang.artg.member.service.MemberService;

@Controller
@RequestMapping("/faq")
public class FaqController {
	@Autowired
	private FAQService service;
	@Autowired
	private MemberService memService;
	@Autowired
	private PasswordEncoder pwEncoder;
	
	@RequestMapping("/faqList")
	public String showFaqList(CriteriaDTO cri, Model model) {
		PageDTO page = new PageDTO(cri, service.getTotalCount(cri));
		model.addAttribute("pageMaker", page);
		model.addAttribute("faqList", service.pagingList(cri));
		return "manager/faq/faqList";
	}
	
	@RequestMapping("/faqListForManager")
	public String showFaqListM(CriteriaDTO cri, Model model) {
		PageDTO page = new PageDTO(cri, service.getTotalCount(cri));
		model.addAttribute("pageMaker", page);
		model.addAttribute("faqList", service.pagingList(cri));
		return "manager/faq/faqListM";
	}
	
	@RequestMapping("/faqWrite")
	public String showFaqWriteForm() {
		return "manager/faq/faqWriteForm";
	}
	
	@RequestMapping(value="/faqWrite", method=RequestMethod.POST)
	public String doFaqRegister(FAQVO faq,String question,  Model model) {
//		System.out.println("question 값: "+question);
//		System.out.println(faq.getQuestion());
		String url = "faqListForManager";
		String msg = "FAQ작성에 실패하였습니다. 다시시도하세요";
		if(service.faqRegister(faq)) {
			msg = "FAQ가 등록되었습니다.";
		}else {
			url = "faqWrite";
		}
		model.addAttribute("url", url);
		model.addAttribute("msg", msg);
		return "manager/result";
	}
	
	@RequestMapping("/faqModify")
	public String showFaqModifyForm(int num, Model model) {
		model.addAttribute("faq", service.faqGetOne(num));
		return "manager/faq/faqModifyForm";
	}
	
	@RequestMapping(value="/faqModify", method=RequestMethod.POST)
	public String doFaqModify(FAQVO faq, Model model) {
//		System.out.println("질문:"+ faq.getQuestion());
//		System.out.println("답:"+ faq.getAnswer());
//		System.out.println("카테고리:"+ faq.getCategory());
		int num = faq.getNum();
		String url = "faqListForManager";
		String msg = "FAQ 수정 실패";
		if(service.faqModify(faq)) {
			msg = "FAQ 수정 성공";
		}else {
//			System.out.println("faq 수정실패 다시시도");
			url = "faqModify?num?"+num;
		}
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		return "manager/result";
	}
	
	@RequestMapping(value="/checkPw", method=RequestMethod.POST)
	public String doCheckPw(int num, String type, String password, Model model, Principal principal) {
		String msg = "";
		String id = principal.getName();
		MemberVO mem = memService.memberGetOne(id);
		String originPw = mem.getMember_password();
		FAQVO faq = service.faqGetOne(num);
		if(faq != null && pwEncoder.matches(password, originPw)) {
			//비밀번호 일치
			if(type.equals("delete")) {
				// 삭제요청
				if(service.faqRemove(num)) {
					//삭제 성공(파일 삭제) >> 이동할 화면
					System.out.println("FAQ삭제 성공");
					msg = "FAQ가 삭제되었습니다";
				}else {
					//삭제실패
					msg = "FAQ 삭제에 실패하였습니다.";
					System.out.println("FAQ삭제 실패");
				}
			}
		}else {
			//비밀번호 불일치
			System.out.println("비밀번호 오류");
			msg = "비밀번호를 다시 확인하세요.";
		}
		model.addAttribute("msg", msg);
		model.addAttribute("url", "faqListForManager");
		return "manager/result";
	}

}
