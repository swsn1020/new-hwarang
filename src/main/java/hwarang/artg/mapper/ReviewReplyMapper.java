package hwarang.artg.mapper;

import java.util.List;

import hwarang.artg.rrboard.model.ReviewReplyVO;

public interface ReviewReplyMapper {
	public int insertReview_Reply(ReviewReplyVO rr);
	public int updateReview_Reply(ReviewReplyVO rr);
	public int deleteReview_Reply(int review_reply_num);
	public int deleteReview_Replys(int review_num);
	public ReviewReplyVO selectReview_Reply(int review_reply_num);
	public List<ReviewReplyVO> selectAllReview_Reply(int review_num);
	//댓글 수 조회
	public int getReplyCnt(int review_num);
	//댓글 총 개수
	public int getTotalCount();
}
