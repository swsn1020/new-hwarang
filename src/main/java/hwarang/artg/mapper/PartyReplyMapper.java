package hwarang.artg.mapper;

import java.util.List;

import hwarang.artg.community.model.PartyReplyVO;



public interface PartyReplyMapper {
//	insertReply(Reply	) : int, 댓글정보 삽입
//	updateReply(Reply)  : int , id(댓글 id) 를 기준으로 나머지 정보 수정
//	deleteReply(int id): int
//	selectReply(int id):Reply, 댓글 하나의 정보 조회
//	selectListByBnum(int num):List<Reply> , 게시글 번호로 댓글 조회
	
	public int insertReply(PartyReplyVO partyreply);
	public int updateReply(PartyReplyVO partyreply);
	public int deleteReply(int num);
	public PartyReplyVO selectOne(int num);
	public List<PartyReplyVO> selectAll();
	public List<PartyReplyVO> selectListByBnum(int boardNum);
	
}
