package hwarang.artg.mapper;

import java.util.List;

import hwarang.artg.rrboard.model.RecommendBoardVO;

public interface RecommendBoardMapper {
	public int insertRecommend_Board(RecommendBoardVO rb);
	public int updateRecommend_Board(RecommendBoardVO rb);
	public int deleteRecommend_Board(int recomm_num);
	public RecommendBoardVO selectRecommend_Board(int recomm_num);
	public List<RecommendBoardVO> selectAllRecommend_Board();
	public List<RecommendBoardVO> selectPageRecommend_Board(int firstrow,int lastrow);
	
	public int updateRecommend_Count(int recomm_num);
}
