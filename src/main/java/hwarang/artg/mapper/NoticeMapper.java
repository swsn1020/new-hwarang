package hwarang.artg.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import hwarang.artg.common.model.CriteriaDTO;
import hwarang.artg.manager.model.NoticeVO;

public interface NoticeMapper {
	public int insertNotice(NoticeVO notice);
	public int updateNotice(NoticeVO notice);
	public int deleteNotice(int num);
	public NoticeVO selectNotice(int num);
	public List<NoticeVO> selectAllNotices();
	
	// MAIN 화면에 띄울 공지사항 5개 가져오기
	public List<NoticeVO> selectRecentNotices();
	
	
	//'댓글'수 수정(게시글번호, 양)
//	public int updateReplyCnt(@Param("num")int num, @Param("amount")int amount) throws Exception;
	//'댓글' 수 가져오기
//	public int getReplyCnt()
	
	//'조회'수 증가
	public int updateViewCnt(int num);
	
	//페이징 
		//-한 페이지 당 표시할 list 수
	public List<NoticeVO> getListWithPaging(CriteriaDTO cri);
		//-총 list 구하기
		//public int getTotalCount();
		//검색기능 추가
	public int getTotalCount(CriteriaDTO cri);
	
	//게시글 검색기능
//	public List<NoticeVO> searchNoticeList(Map<String, Object> param);
	
	//게시글 block 처리
	public int updateBlock(@Param("block")String block, @Param("num") int num);
	
	/***** 중요 공지 상단 고정하기 *****/
	public List<NoticeVO> topNotices();
}
