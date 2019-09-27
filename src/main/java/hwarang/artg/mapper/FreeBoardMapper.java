package hwarang.artg.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import hwarang.artg.common.model.CriteriaDTO;
import hwarang.artg.community.model.FreeBoardVO;

public interface FreeBoardMapper{
	public int insertBoard(FreeBoardVO freeboard);
	public int updateBoard(FreeBoardVO freeboard);
	public int deleteBoard(int num);
	public FreeBoardVO selectOne(int num);
	public List<FreeBoardVO> selectAll(); 
	public int updateReadCount(int num);
	public List<FreeBoardVO> getListWithPaging(CriteriaDTO cri);
	public int getTotalCount(CriteriaDTO cri);
	
	/* 신고처리 */
	public int updateBlock(@Param("block")String block, @Param("num") int num);
}
