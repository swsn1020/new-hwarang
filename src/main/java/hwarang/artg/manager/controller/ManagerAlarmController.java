package hwarang.artg.manager.controller;

import java.util.List;
import java.util.Map;

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
	@RequestMapping(value="/alarmCheck", method=RequestMethod.POST)
	public boolean checkAlarm(int num) {
		System.out.println("alarmCheck 요청 들어옴");
		return service.alarmModify(num);
	}
	
	@ResponseBody
	@RequestMapping(value="/removeAlarm", method=RequestMethod.POST)
	public boolean removeAlarm(int num) {
		return service.alarmRemove(num);
	}


	
	@ResponseBody
	@RequestMapping(value="/unReadCnt")
	public int unReadCount() {
		return service.unReadAlarmCount();
	}
	
	@ResponseBody
	@RequestMapping(value="/unReadAlarms")
	public List<Map<String, Object>> getUnReadAlarms(){
		return service.getFourAlarms();
	}

}
