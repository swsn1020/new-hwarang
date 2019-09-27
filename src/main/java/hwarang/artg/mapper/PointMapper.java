package hwarang.artg.mapper;

import java.util.List;

import hwarang.artg.member.model.PointVO;

public interface PointMapper {
	public int insertGetPoint(PointVO p);
	public int insertUsePoint(PointVO p);
	
	public int updatePoint(PointVO p);
	public int deletePoint(int point_num);
	public List<PointVO> selectPoint(String member_id);
	public List<PointVO> selectAllPoint();
}
