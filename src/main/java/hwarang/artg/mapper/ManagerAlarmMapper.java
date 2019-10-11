package hwarang.artg.mapper;

import java.util.List;

import org.springframework.web.bind.annotation.RequestParam;

import hwarang.artg.common.model.CriteriaDTO;
import hwarang.artg.manager.model.ManagerAlarmVO;


public interface ManagerAlarmMapper {
	public int insertManagerAlarm(ManagerAlarmVO alarm);
	public int updateManagerAlarm(@RequestParam("num")int num, @RequestParam("checked")String checked);
	public int deleteManagerAlarm(int num);
	public ManagerAlarmVO selectManagerAlarm(int num);
	public List<ManagerAlarmVO> selectAllManagerAlarms();
	public int unReadAlarmCount();
	public List<ManagerAlarmVO> selectFourAlarms();
	//pagingList
	public List<ManagerAlarmVO> getListWithPaging(CriteriaDTO cri);
	public int getTotalCount();
}
