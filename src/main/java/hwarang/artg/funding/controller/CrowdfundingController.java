package hwarang.artg.funding.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import hwarang.artg.common.model.CriteriaDTO;
import hwarang.artg.common.model.PageDTO;
import hwarang.artg.funding.model.CrowdfundingVO;
import hwarang.artg.funding.service.CrowdfundingService;
import hwarang.artg.member.service.MemberService;

@Controller
@RequestMapping("/funding")
public class CrowdfundingController {

	@Autowired
	private CrowdfundingService service;
	@Autowired
	private MemberService mService;

	@RequestMapping("/fundingList")
	public String showFundingList(CriteriaDTO cri, Model model) {
		// 페이징 처리 List
		PageDTO page = new PageDTO(cri, service.getTotalCount(cri));
		model.addAttribute("pageMaker", page);
		System.out.println(page);
		model.addAttribute("fundingList", service.pagingList(cri));
		System.out.println(service.pagingList(cri));
		return "funding/fundingList";
	}

	@RequestMapping("/fundingWrite")
	public String showFundingWriteForm() {
		return "funding/fundingWrite";
	}

	@RequestMapping(value = "/fundingWrite", method = RequestMethod.POST)
	public String doFundingRegister(CrowdfundingVO funding, Model model) {
		String msg = "펀딩 등록에 실패하였습니다.";
		String url = "fundingList";
		if (service.noticeRegister(funding)) {
			msg = "펀딩이 등록되었습니다.";
		} else {
			url = "funding/fundingWrite";
		}
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		return "funding/fundingList";
	}

	 @GetMapping("/fundingView")
	    public void get(@RequestParam("funding_num") int funding_num, Model model) {
	        model.addAttribute("funding", service.fundingGetOne(funding_num));
	    }

	@RequestMapping("/fundingModify")
	public String showNoticeModifyForm(int funding_num, Model model) {
		model.addAttribute("funding", service.fundingGetOne(funding_num));
		return "funding/modify";
	}

	@RequestMapping(value = "/fundingModify", method = RequestMethod.POST)
	public String doNoticeModify(CrowdfundingVO funding, Model model) {
		String msg = "펀딩 수정에 실패하였습니다.";
		String url = "fundingView?funding_num=" + funding.getFunding_num();
		if (service.fundingModify(funding)) {
			msg = "공지사항 수정에 성공하였습니다.";
		}
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		return "funding/result";
	}
}