package hwarang.artg.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import hwarang.artg.common.model.CriteriaDTO;
import hwarang.artg.exhibition.model.RecentlyViewVO;

public interface RecentlyViewMapper {
	public int insert(RecentlyViewVO rec);
	public int delete(RecentlyViewVO rec);
	public RecentlyViewVO select(RecentlyViewVO rec);
	public List<RecentlyViewVO> selectList(@Param("cri")CriteriaDTO cri, @Param("member_id") String member_id);
	public List<RecentlyViewVO> selectAll();
	public int getTotalCount(String member_id);
}
