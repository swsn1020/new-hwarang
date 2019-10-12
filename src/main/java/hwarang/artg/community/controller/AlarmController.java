package hwarang.artg.community.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import hwarang.artg.community.service.AlarmService;

@Controller
@RequestMapping("/useralarm")
public class AlarmController {
	@Autowired
	private AlarmService service;
	
	@RequestMapping("/alarmList")
	public String showAlarmList(Model model) {
		System.out.println("알람리스트");
		return "layout/menu";
	}
}
