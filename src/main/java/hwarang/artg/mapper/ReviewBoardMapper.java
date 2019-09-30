package hwarang.artg.mapper;

import java.util.List;
import java.util.Map;

import hwarang.artg.common.model.CriteriaDTO;
import hwarang.artg.rrboard.model.ReviewBoardVO;

public interface ReviewBoardMapper {
	public int insertReview_Board(ReviewBoardVO r);
	public int updateReview_Board(ReviewBoardVO r);
	public int deleteReview_Board(int review_num);
	public List<ReviewBoardVO> selectReview_Board_Id(String member_id);
	public ReviewBoardVO selectReview_Board(int review_num);
	public List<ReviewBoardVO> selectAllReview_Board();
	
	public int updateReview_count(int review_num);
//	public int updateReply_count();
	
	//paging
	public List<ReviewBoardVO> getListWithPaging(CriteriaDTO cri);
	public int getTotalCount(CriteriaDTO cri);
	
	//search
	
}
