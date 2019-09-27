package hwarang.artg.mapper;

import java.util.List;

import hwarang.artg.common.model.CriteriaDTO;
import hwarang.artg.member.model.MemberVO;

public interface ManagerMainMapper {
	
	//총 Member 수
	public int getMembersCount();
	
	//오늘 등록된 총 게시글
	public int getTotalPost();
	
	//오늘 등록된 총 댓글
	public int getTotalReply();
	
	//전체 글 조회(리스트 띄우기)
	
	//각 게시글 별 오늘 등록된 데이터 수 조회하기
	//QNA
	public int todayGetQnACount();
	//party_board
	public int todayGetPBCount();
	//report_board
	public int todayGetReportBCount();
	//block_status
	public int todayGetBBCount();
	//review_board
	public int todayGetReviewBCount();
	//ticket_board
	public int todayGetTBCount();
	//free_board
	public int todayGetFBCount();
	//recommend_board
	public int todayGetRecommBCount();
	
	//신규 회원수(일주일)
	public int getNewMemberCount();
	//신규 회원 정보(일주일)
	public List<MemberVO> getNewMember();
	
	//총 멤버수(정렬)
	public int getTotalMemCount(CriteriaDTO cri);
	public List<MemberVO> getListWithPaging(CriteriaDTO cri);
	
	
	
	//이번달 시작하는 전시회 수
	public int getExhibCountMonth();

}
