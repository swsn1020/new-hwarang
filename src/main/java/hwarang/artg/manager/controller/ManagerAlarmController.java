package hwarang.artg.manager.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import hwarang.artg.manager.service.ManagerAlarmService;

@Controller
@RequestMapping("/alarm")
public class ManagerAlarmController {
	@Autowired
	private ManagerAlarmService service;
	
	@RequestMapping("/alarmList")
	public String showAlarmList(Model model) {
		return "manager/alarm/alarmList";
	}
	
	
	
	
	
	
}
