package hwarang.artg.mapper;

import java.util.List;

import hwarang.artg.manager.model.NoticeVO;
import hwarang.artg.member.model.MemberVO;

public interface MemberMapper {
	public int insertMember(MemberVO m);
	public int updateMember(MemberVO m);
	public int updateMember_pw(MemberVO m);
	public int deleteMember(String member_id);
	public MemberVO selectMember(String member_id);
	public MemberVO selectMember_id(String member_id);
	public List<MemberVO> selectAllMember();
	public MemberVO selectMember_name(String member_name);
	//수정한 것들\\
	public int selectNoticeCount(String member_id) throws Exception;
	public List<NoticeVO> selectUserNotice(String member_id);
	public int readUserNotice(String member_id);
	
	/* Mananger 권한 Member 관리 */
	//1. report_count 증가
	public int blockCountMember(String member_id);
	//2. 'disabled'설정하기
	public int blockStatusMember(String member_id);
}
