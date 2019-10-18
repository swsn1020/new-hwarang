package hwarang.artg.manager.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import hwarang.artg.common.model.CriteriaDTO;
import hwarang.artg.mapper.ManagerMainMapper;
import hwarang.artg.member.model.MemberVO;
import hwarang.artg.rrboard.model.ReviewBoardVO;

@Service
public class ManagerMainService {
	@Autowired
	private ManagerMainMapper dao;
	
	public Map<String, Object> MangerMainResults(){
		return dao.getTotals();
	}
	
	//New memberList for a week
	public List<MemberVO> newMemberList(){
		return dao.getNewMember();
	}
	
	//총 멤버수
	public int totalMemCount(CriteriaDTO cri) {
		return dao.getTotalMemCount(cri);
	}
	public List<MemberVO> pagingList(CriteriaDTO cri){
		return dao.getListWithPaging(cri);
	}

	//Review 미리보기
	public List<ReviewBoardVO> getReviewsTop(){
		return dao.getReviews();
	}

}
