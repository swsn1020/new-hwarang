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
	
	//paging
	public List<ReviewBoardVO> getListWithPaging(CriteriaDTO cri);
	public int getTotalCount();
	
	//search
	//현재 게시글의 총개수 
	public int selectTotalBoardCount(Map<String, Object> param);
	//검색어를 포함한,페이지 게시글 목록 조회 
	public List<ReviewBoardVO> searchBoardList(Map<String , Object> param);
	
	
	/* 신고처리 -hj*/
	
	
	
}
