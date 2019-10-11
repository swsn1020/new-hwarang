package hwarang.artg.mapper;

import java.util.List;

import hwarang.artg.common.model.CriteriaDTO;
import hwarang.artg.manager.model.ManagerAlarmVO;


public interface ManagerAlarmMapper {
	public int insertManagerAlarm(ManagerAlarmVO alarm);
	public int updateManagerAlarm(ManagerAlarmVO alarm);
	public int deleteManagerAlarm(int num);
	public ManagerAlarmVO selectManagerAlarm(int num);
	public List<ManagerAlarmVO> selectAllManagerAlarms();
	public int unReadAlarmCount();
	public List<ManagerAlarmVO> selectFourAlarms();
	//pagingList
	public List<ManagerAlarmVO> getListWithPaging(CriteriaDTO cri);
	
}
