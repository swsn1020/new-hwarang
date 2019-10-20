package hwarang.artg.funding.controller;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import hwarang.artg.exhibition.model.ExhibitionVO;
import hwarang.artg.exhibition.service.ExhibitionListService;
import hwarang.artg.funding.model.CrowdfundingVO;
import hwarang.artg.funding.model.OrderVO;
import hwarang.artg.funding.service.CrowdfundingService;
import hwarang.artg.funding.service.FundingOrderService;
import hwarang.artg.member.model.MemberVO;
import hwarang.artg.member.service.MemberService;
import lombok.AllArgsConstructor;

@Controller
@RequestMapping("/order/*")
@AllArgsConstructor
public class FundingOrderController {
	
	@Autowired
	FundingOrderService service;
	
	@Autowired
	ExhibitionListService eService;
	
	@Autowired
	MemberService mService;
	
	@Autowired
	CrowdfundingService cService;
	
	@Autowired
	FundingOrderService oService;
	
	@GetMapping("/orderGoodsForm")
	public void orderEachGoods(@ModelAttribute("orderVO") OrderVO orderVO, Model model, int seq, Principal principal) throws Exception {
		String id = principal.getName();
		model.addAttribute("member",mService.memberGetOne(id));
		model.addAttribute("orderGoodsForm",orderVO);
		model.addAttribute("exhibition", eService.getOne(seq));
	}
	@GetMapping("/orderFundingForm")
	public void orderFunding(@ModelAttribute("CrowdfundingVO")CrowdfundingVO crowdfundingVO,int funding_num, Model model,Principal principal) throws Exception {
		String id = principal.getName();
		model.addAttribute("member",mService.memberGetOne(id));
		model.addAttribute("orderFundingForm",crowdfundingVO);
		model.addAttribute("funding",cService.fundingGetOne(funding_num));
	}
	@RequestMapping("/orderResult")
	public void orderResult(CrowdfundingVO funding,OrderVO order,Model model,Principal principal)throws Exception  {
		String id = principal.getName();
		model.addAttribute("member",mService.memberGetOne(id));
		model.addAttribute("order", oService.insertOrder(order));
	}

}