package hwarang.artg.mapper;

import java.util.List;

import hwarang.artg.community.model.TicketBoardVO;

public interface TicketBoardMapper {
	public int insertBoard(TicketBoardVO ticketboard);
	public int updateBoard(TicketBoardVO ticketboard);
	public int deleteBoard(int num);
	public TicketBoardVO selectOne(int num);
	public List<TicketBoardVO> selectAll();
	public int updateReadCount(int num);
}
