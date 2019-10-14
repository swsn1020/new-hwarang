package hwarang.artg.mapper;

import java.util.List;

import hwarang.artg.community.model.AlarmVO;
import hwarang.artg.manager.model.ManagerAlarmVO;

public interface AlarmMapper {
	public int insertAlarm(AlarmVO alarm);
	public int updateAlarm(AlarmVO alarm);
	public AlarmVO selectAlarm(int alarm_num);
	public List<AlarmVO> selectAllAlarms();
	public List<AlarmVO> selectFourAlarms();
	public int unReadAlarmCount();
	public int getTotalCount();
	
}
