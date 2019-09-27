package hwarang.artg.main.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import hwarang.artg.common.model.CriteriaDTO;
import hwarang.artg.common.model.PageDTO;
import hwarang.artg.exhibition.service.ExhibitionListService;

@Controller
public class MainController {
	@Autowired
	ExhibitionListService service;

	@GetMapping("/")
	public String exhibitionShow(Model model) throws Exception {
		CriteriaDTO cri = new CriteriaDTO(1, 3);
		model.addAttribute("eList", service.mainList(cri,"id"));
		return "/main/main";
	}

}
