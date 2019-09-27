package hwarang.artg.mapper;

import java.util.List;

import hwarang.artg.community.model.DayCheckVO;

public interface DayCheckMapper {
	public int insertCheck(DayCheckVO daycheck);
	public DayCheckVO selectOne(String userid);
	public List<DayCheckVO> selectAll();
}
