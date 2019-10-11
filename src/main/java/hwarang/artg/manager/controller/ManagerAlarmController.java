package hwarang.artg.manager.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import hwarang.artg.common.model.CriteriaDTO;
import hwarang.artg.common.model.PageDTO;
import hwarang.artg.manager.service.ManagerAlarmService;

@Controller
@RequestMapping("/alarm")
public class ManagerAlarmController {
	@Autowired
	private ManagerAlarmService service;
	
	@RequestMapping("/alarmList")
	public String showAlarmList(CriteriaDTO cri, Model model) {
		System.out.println("alarmList 요청");
		PageDTO page = new PageDTO(cri, service.getTotalCount());
		model.addAttribute("pageMaker", page);
		model.addAttribute("alarmList", service.pagingList(cri));
		return "manager/alarm/alarmList";
	}
	
	@ResponseBody
	@RequestMapping(value="/alarmChecking", method=RequestMethod.POST)
	public boolean checkingAlarm(int num, String checked) {
		return service.alarmModify(num, checked);
	}
	
	@ResponseBody
	@RequestMapping(value="/removeAlarm", method=RequestMethod.POST)
	public boolean removeAlarm(int num) {
		return service.alarmRemove(num);
	}
	
	
	
	
	
}
