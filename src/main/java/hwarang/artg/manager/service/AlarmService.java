package hwarang.artg.manager.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import hwarang.artg.manager.model.AlarmVO;
import hwarang.artg.manager.model.ReportVO;
import hwarang.artg.mapper.AlarmMapper;
import hwarang.artg.mapper.ReportMapper;

@Service
public class AlarmService {
	@Autowired
	private AlarmMapper dao;
	
	public boolean alarmRegister(AlarmVO alarm) {
		if(dao.insertAlarm(alarm) > 0) {
			return true;
		}
		return false;
	}
	
	public boolean alarmModify(AlarmVO alarm) {
		if(dao.updateAlarm(alarm) > 0) {
			return true;
		}
		return false;
	}
	
	public boolean alarmRemove(int num) {
		if(dao.deleteAlarm(num) > 0) {
			return true;
		}
		return false;
	}
	
	public AlarmVO alarmGetOne(int num) {
		return dao.selectAlarm(num);
	}
	
	public List<AlarmVO> alarmGetAll() {
		return dao.selectAllAlarms();
	}

}
