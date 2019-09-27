package hwarang.artg.mapper;

import java.util.List;

import hwarang.artg.manager.model.AlarmVO;


public interface AlarmMapper {
	public int insertAlarm(AlarmVO alarm);
	public int updateAlarm(AlarmVO alarm);
	public int deleteAlarm(int num);
	public AlarmVO selectAlarm(int num);
	public List<AlarmVO> selectAllAlarms();
}
