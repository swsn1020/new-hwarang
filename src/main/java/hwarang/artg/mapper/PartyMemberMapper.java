package hwarang.artg.mapper;

import java.util.List;

import hwarang.artg.community.model.PartyMemberVO;

public interface PartyMemberMapper {
	public int insertParty(PartyMemberVO partymember);
	public int updateParty(PartyMemberVO partymember);
	public int deleteParty(int num);
	public PartyMemberVO selectOne(int num);
	public List<PartyMemberVO> selectAll();
}
