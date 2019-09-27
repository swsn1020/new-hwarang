package hwarang.artg.funding.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import hwarang.artg.common.model.CriteriaDTO;
import hwarang.artg.funding.model.CrowdfundingVO;
import hwarang.artg.funding.service.CrowdfundingService;
import lombok.AllArgsConstructor;

@Controller
@RequestMapping("/funding/*")
@AllArgsConstructor
public class CrowdfundingController {

	@Autowired
	CrowdfundingService service;
	
	@GetMapping("/list")
    public void list(CriteriaDTO cri, Model model) {
        model.addAttribute("list", service.getList(cri));

        int total = service.getTotal(cri);
        model.addAttribute("pageMaker", new hwarang.artg.common.model.PageDTO(cri, total));
    }

    @GetMapping("/register")
    public void register() {    }

    @PostMapping("/register")
    public String register(CrowdfundingVO funding, RedirectAttributes rttr) {
        service.register(funding);
        rttr.addFlashAttribute("result", funding.getFunding_num());
        return "redirect:/funding/list";
    }

    @GetMapping({"/get", "/modify"})
    public void get(@RequestParam("funding_num") int funding_num, @ModelAttribute("cri") CriteriaDTO cri, Model model) {
        model.addAttribute("funding", service.get(funding_num));
    }

    @PostMapping("/modify")
    public String modify(CrowdfundingVO funding, @ModelAttribute("cri") CriteriaDTO cri, RedirectAttributes rttr) {
        if(service.modify(funding)) {
            rttr.addFlashAttribute("result", "success");
        }
        rttr.addAttribute("pageNum", cri.getPageNum());
        rttr.addAttribute("amount", cri.getAmount());
        rttr.addAttribute("type", cri.getType());
        rttr.addAttribute("keyword", cri.getKeyword());

        return "redirect:/funding/list";
    }

    @PostMapping("remove")
    public String remove(@RequestParam("funding_num") int num, @ModelAttribute("cri") CriteriaDTO cri, RedirectAttributes rttr) {
        if(service.remove(num)) {
            rttr.addFlashAttribute("result", "success");
        }
        rttr.addAttribute("pageNum", cri.getPageNum());
        rttr.addAttribute("amount", cri.getAmount());
        rttr.addAttribute("type", cri.getType());
        rttr.addAttribute("keyword", cri.getKeyword());

        return "redirect:/funding/list";
    }
    
    @RequestMapping(value = "/payment", method = {RequestMethod.GET,RequestMethod.POST})
    public String payment(@RequestParam("funding_num") int funding_num, @ModelAttribute("cri") CriteriaDTO cri, Model model) {
    	model.addAttribute("payment", service.payment(funding_num));
    	return "/funding/payment";
    }
}
