package hwarang.artg.mapper;

import java.util.List;

import hwarang.artg.rrboard.model.RecommendReplyVO;

public interface RecommendReplyMapper {
	public int insertRecommend_Reply(RecommendReplyVO rr);
	public int updateRecommend_Reply(RecommendReplyVO rr);
	public int deleteRecommend_Reply(int recomm_reply_num);
	public RecommendReplyVO selectRecommend_Reply(int recomm_reply_num);
	public List<RecommendReplyVO> selectAllRecommend_Reply();
}
