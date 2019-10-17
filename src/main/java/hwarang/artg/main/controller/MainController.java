package hwarang.artg.main.controller;

import java.util.Collection;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import hwarang.artg.common.model.CriteriaDTO;
import hwarang.artg.community.service.FreeBoardService;
import hwarang.artg.exhibition.service.ExhibitionListService;
import hwarang.artg.manager.service.FAQService;
import hwarang.artg.manager.service.NoticeService;

@Controller
public class MainController {
	@Autowired
	ExhibitionListService service;
	@Autowired
	NoticeService noticeService;
	@Autowired
	FreeBoardService freeservice;
	@Autowired
	FAQService faqService;

	@GetMapping("/")
	public String exhibitionShow(Model model) throws Exception {
		CriteriaDTO cri = new CriteriaDTO(1, 3);
		model.addAttribute("eList", service.mainList(cri,"id"));
		model.addAttribute("noticeList", noticeService.noticeRecentAll());
		
		model.addAttribute("faqList", faqService.fagRecentAll());
		model.addAttribute("freeList", freeservice.selectRecentFree());
		return "/main/main";
	}
	
	@GetMapping("/main/error")
	public void errorPage(Model model){
	}

}
