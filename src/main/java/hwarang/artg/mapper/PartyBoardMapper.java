package hwarang.artg.mapper;

import java.util.List;

import hwarang.artg.community.model.PartyBoardVO;



public interface PartyBoardMapper {
	public int insertBoard(PartyBoardVO partyboard);
	public int updateBoard(PartyBoardVO artyboard);
	public int deleteBoard(int num);
	public PartyBoardVO selectOne(int num);
	public List<PartyBoardVO> selectAll(); 
	public int updateReadCount(int num);
	
	
}
