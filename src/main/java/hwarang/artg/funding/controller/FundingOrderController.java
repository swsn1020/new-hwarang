package hwarang.artg.funding.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import hwarang.artg.exhibition.service.ExhibitionListService;
import hwarang.artg.funding.model.OrderVO;
import hwarang.artg.funding.service.FundingOrderService;
import lombok.AllArgsConstructor;

@Controller
@RequestMapping("/order/*")
@AllArgsConstructor
public class FundingOrderController {
	
	@Autowired
	FundingOrderService service;
	
	@Autowired
	ExhibitionListService eService;
	
	@GetMapping("/orderGoodsForm")
	public void orderEachGoods(@ModelAttribute("orderVO") OrderVO orderVO, Model model, int seq) throws Exception {
		model.addAttribute("orderEachGoods", orderVO);
		model.addAttribute("exhibition", eService.getOne(seq));
	}
	
}
