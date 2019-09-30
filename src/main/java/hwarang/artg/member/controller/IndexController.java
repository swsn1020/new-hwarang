package hwarang.artg.member.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import hwarang.artg.member.service.MemberService;
import hwarang.artg.member.service.NaverService;

@Controller
public class IndexController {
	@RequestMapping("/index")
	public String showMain(Model model,HttpSession session) {
		String kakaoName = (String) session.getAttribute("kakaoName");
		String naverName = (String) session.getAttribute("naverName");
		String id = (String) session.getAttribute("id");
		
		if(kakaoName!=null) {
			model.addAttribute("kakaoName", kakaoName);
			model.addAttribute("snsUser", "kakao");
		}else if(naverName!=null) {
			model.addAttribute("naverName", naverName);
			model.addAttribute("snsUser", "naver");
		}
		model.addAttribute("id", id);
		return "index";
	}

}
