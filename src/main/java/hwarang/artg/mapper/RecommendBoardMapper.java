package hwarang.artg.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import hwarang.artg.common.model.CriteriaDTO;
import hwarang.artg.rrboard.model.RecommendBoardVO;


public interface RecommendBoardMapper {
	public int insertRecommend_Board(RecommendBoardVO rb);
	public int updateRecommend_Board(RecommendBoardVO rb);
	public int deleteRecommend_Board(int recomm_num);
	public RecommendBoardVO selectRecommend_Board(int recomm_num);
	public List<RecommendBoardVO> selectRecommend_Board_Id(String id);
	public List<RecommendBoardVO> selectAllRecommend_Board();
	
	public List<RecommendBoardVO> selectPageRecommend_Board(int firstrow,int lastrow);
	
	public int updateRecommend_Count(int recomm_num);
//	public int updateReply_count(int recomm_num);
	
	//paging
	public List<RecommendBoardVO> getListWithPaging(CriteriaDTO cri);
	public int getTotalCount(CriteriaDTO cri);
	
	//search
	
	//게시글 block 처리
	public int updateBlock(@Param("block")String block, @Param("num") int num);
}
