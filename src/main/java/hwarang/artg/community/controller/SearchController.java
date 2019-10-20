package hwarang.artg.community.controller;

import java.security.Principal;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import hwarang.artg.common.model.CriteriaDTO;
import hwarang.artg.common.model.PageDTO;
import hwarang.artg.common.model.ReplyPager;
import hwarang.artg.community.model.FreeBoardVO;
import hwarang.artg.community.service.FreeBoardService;
import hwarang.artg.community.service.FreeImgService;
import hwarang.artg.community.service.FreeReplyService;
import hwarang.artg.exhibition.model.ExhibitionVO;
import hwarang.artg.exhibition.service.ExhibitionListService;
import hwarang.artg.manager.service.FAQService;
import hwarang.artg.manager.service.NoticeService;
import hwarang.artg.rrboard.service.RecommendBoardService;
import hwarang.artg.rrboard.service.ReviewBoardService;

@Controller
@RequestMapping("/layout")
public class SearchController {
	@Autowired
	private FreeBoardService fservice;
	
	@Autowired
	private ReviewBoardService reviewservice;
	
	@Autowired
	private RecommendBoardService recservice;
	
	@Autowired
	private ExhibitionListService exservice;
	
	@Autowired
	private FAQService faqservice;
	
	@Autowired
	private NoticeService noticeservice;
	
	@Autowired
	private FreeReplyService rservice;

	@Autowired
	private FreeImgService imgService;

	@RequestMapping(value="/searchList" , method= RequestMethod.GET)
	public String showboardList(Model model,String key,
			@RequestParam(name = "pageNum", defaultValue = "1")String pageNum,
			@RequestParam(name = "amount",defaultValue = "10")String amount,
			Principal principal , ExhibitionVO exh) {
		//pagedto는필요없고 cri만 수정
		
		System.out.println(pageNum+"    으아아아아앙다");
		System.out.println(amount+"    으아아아아앙다");
		if(pageNum.isEmpty()) {
			pageNum="1";
		}
		if(amount.isEmpty()) {
			amount="10";
		}
		
		 CriteriaDTO cri = new CriteriaDTO();
//		cri.setAmount(amount);
//		cri.setPageNum(pageNum);
		cri.setAmount(Integer.parseInt(amount));
		cri.setPageNum(Integer.parseInt(pageNum));
		cri.setType("TCW");
		cri.setKeyword(key);
		PageDTO page = new PageDTO(cri,fservice.getTotal(cri) + reviewservice.getTotalCount(cri) + recservice.getTotalCount(cri) + faqservice.getTotalCount(cri) + noticeservice.getTotalCount(cri));
		
//		cri.setAmount(10);
		System.out.println(page);
		
//		PageDTO page = new PageDTO(cdto,fservice.getTotal(cdto));
//		model.addAttribute("freeboard", fservice.pagingList(cdto));
		model.addAttribute("pageMaker", page);
		model.addAttribute("freeboard",fservice.pagingList(cri));		
		model.addAttribute("reviewboard",reviewservice.pagingList(cri));
		model.addAttribute("recommendboard",recservice.pagingList(cri));
		model.addAttribute("noticeboard",noticeservice.pagingList(cri));
		String id = SecurityContextHolder.getContext().getAuthentication().getName();
		cri.setType("t");
		model.addAttribute("exhibition", exservice.pagingList(cri, exh, id));
		cri.setType("QAC");
		model.addAttribute("faqboard",faqservice.pagingList(cri));
		return "/layout/searchList";
	}

}
	
	
	
	
