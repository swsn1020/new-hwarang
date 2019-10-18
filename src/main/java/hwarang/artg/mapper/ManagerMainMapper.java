package hwarang.artg.mapper;

import java.util.List;
import java.util.Map;

import hwarang.artg.common.model.CriteriaDTO;
import hwarang.artg.member.model.MemberVO;
import hwarang.artg.rrboard.model.ReviewBoardVO;

public interface ManagerMainMapper {
	
	//신규 회원 정보(일주일)
	public List<MemberVO> getNewMember();
	
	//총 멤버수(정렬)
	public int getTotalMemCount(CriteriaDTO cri);
	public List<MemberVO> getListWithPaging(CriteriaDTO cri);
	
	//Review 글 얻어오기
	public List<ReviewBoardVO> getReviews();
	
	public Map<String, Object> getTotals();
}
