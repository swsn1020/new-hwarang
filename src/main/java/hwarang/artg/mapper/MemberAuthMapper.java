package hwarang.artg.mapper;

import java.util.List;

import hwarang.artg.member.model.MemberAuthVO;

public interface MemberAuthMapper {
	public int insertMember_Auth(MemberAuthVO ma);
	public int updateMamber_Auth(MemberAuthVO ma);
	public int deleteMember_Auth(String member_id);
	public MemberAuthVO selectMember_Auth(String member_id);
	public List<MemberAuthVO> selectAllMember_Auth();
}
