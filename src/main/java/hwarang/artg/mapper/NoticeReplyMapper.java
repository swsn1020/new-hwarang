package hwarang.artg.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import hwarang.artg.common.model.CriteriaDTO;
import hwarang.artg.manager.model.NoticeReplyVO;

public interface NoticeReplyMapper {
	public int insertReply(NoticeReplyVO nReply);
	public int updateReply(NoticeReplyVO nReply);
	public int deleteReply(int num);
	public int deleteReplyByBNum(int boardNum);
	public NoticeReplyVO selectReply(int num);
	public List<NoticeReplyVO> selectRepliesByBNum(int boardNum);
	public List<NoticeReplyVO> selectReplies();
	
	//댓글 수 조회
//	public int getBoardNum(int num) throws Exception;
	public int getReplyCnt(int boardNum);
	
	//댓글 페이징 
		//-한 페이지 당 표시할 list 수
//	public List<NoticeReplyVO> getListWithPaging(CriteriaDTO criteria);
		//-총 list 구하기
	public int getTotalCount();
	
	//댓글  block 처리
	public int updateBlock(@Param("block")String block, @Param("num") int num);
}
