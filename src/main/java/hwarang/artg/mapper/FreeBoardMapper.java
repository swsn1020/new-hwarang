package hwarang.artg.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import hwarang.artg.common.model.CriteriaDTO;
import hwarang.artg.community.model.FreeBoardVO;
import hwarang.artg.manager.model.NoticeVO;

public interface FreeBoardMapper{
	public int insertBoard(FreeBoardVO freeboard);
	public int updateBoard(FreeBoardVO freeboard);
	public int deleteBoard(int num);
	public FreeBoardVO selectOne(int num);
	public List<FreeBoardVO> selectOne_id(String member_id);
	public List<FreeBoardVO> selectAll(); 
	public int updateReadCount(int num);
	public List<FreeBoardVO> getListWithPaging(CriteriaDTO cri);
	public int getTotalCount(CriteriaDTO cri);
	// MAIN 화면에 띄울 게시글 5개 가져오기
	public List<FreeBoardVO> selectRecentFree();
	/* 신고처리 */
	public int updateBlock(@Param("block")String block, @Param("num") int num);
}
