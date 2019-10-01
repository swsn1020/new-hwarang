package hwarang.artg.funding.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import hwarang.artg.funding.model.OrderVO;
import hwarang.artg.funding.service.FundingOrderService;
import lombok.AllArgsConstructor;

@Controller
@RequestMapping("/order/*")
@AllArgsConstructor
public class FundingOrderController {
	
	@Autowired
	FundingOrderService service;
	
	@GetMapping("/orderGoodsForm")
	public void orderEachGoods(@ModelAttribute("orderVO") OrderVO orderVO, Model model) throws Exception {
		model.addAttribute("orderEachGoods", orderVO);
	}
	
}
