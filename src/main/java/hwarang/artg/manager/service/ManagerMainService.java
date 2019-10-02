package hwarang.artg.manager.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import hwarang.artg.common.model.CriteriaDTO;
import hwarang.artg.mapper.ManagerMainMapper;
import hwarang.artg.member.model.MemberVO;

@Service
public class ManagerMainService {
	@Autowired
	private ManagerMainMapper dao;
	
	//All members count
	public int memberCounts() {
		return dao.getMembersCount();
	}
	
	//New member count for a week
	public int newMemberCount() {
		return dao.getNewMemberCount();
	}
	
	//New memberList for a week
	public List<MemberVO> newMemberList(){
		return dao.getNewMember();
	}
	
	//totalPost
	public int totalPost() {
		return dao.getTotalPost();
	}
	
	//totalPost
	public int totalReply() {
		return dao.getTotalReply();
	}
	
	//QNA
	public int qnaTodayCount() {
		return dao.todayGetQnACount();
	}
	//report_board
	public int reportTodayCount() {
		return dao.todayGetReportBCount();
	}
	//block_status
	public int blockTodayCount() {
		return dao.todayGetBBCount();
	}
	//review_board
	public int reviewBTodayCount() {
		return dao.todayGetReviewBCount();
	}
	//free_board
	public int freeBTodayCount() {
		return dao.todayGetFBCount();
	}
	//recommend_board
	public int RecommBTodayCount() {
		return dao.todayGetRecommBCount();
	}
	
	//이번달 시작되는 전시회 수
	public int thisMonthExhiCount() {
		return dao.getExhibCountMonth();
	}
	
	//총 멤버수
	public int totalMemCount(CriteriaDTO cri) {
		return dao.getTotalMemCount(cri);
	}
	public List<MemberVO> pagingList(CriteriaDTO cri){
		return dao.getListWithPaging(cri);
	}


}
