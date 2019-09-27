package hwarang.artg.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import hwarang.artg.community.model.FreeReplyVO;

public interface FreeReplyMapper {
//	insertReply(Reply	) : int, 댓글정보 삽입
//	updateReply(Reply)  : int , id(댓글 id) 를 기준으로 나머지 정보 수정
//	deleteReply(int id): int
//	selectReply(int id):Reply, 댓글 하나의 정보 조회
//	selectListByBnum(int num):List<Reply> , 게시글 번호로 댓글 조회
	
	public int insertReply(FreeReplyVO freereply);
	public int updateReply(FreeReplyVO freereply);
	public int deleteReply(int num);
	public FreeReplyVO selectOne(int num);
	public List<FreeReplyVO> selectAll();
	public List<FreeReplyVO> selectListByBnum(int fboardNum);
	public String replyUserIdCheck(int num);	
	
	/* 신고처리 */
	public int updateBlock(@Param("block")String block, @Param("num") int num);
}
