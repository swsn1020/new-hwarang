package hwarang.artg.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import hwarang.artg.common.model.CriteriaDTO;
import hwarang.artg.manager.model.NoticeVO;
import hwarang.artg.manager.model.QnAVO;

public interface QnAMapper {
	public int insertQnA(QnAVO QnA);
	public int updateQnA(QnAVO QnA);
	//답변 등록(수정)
	public int updateReply(@Param("num")int num, @Param("reply")String reply);
	public int deleteQnA(int num);
	public QnAVO selectQnA(int num);
	public List<QnAVO> selectAllQnAs();
	
	
	//페이징 
		//-한 페이지 당 표시할 list 수
	public List<QnAVO> getListWithPaging(CriteriaDTO cri);
		//-총 list 구하기
	public int getTotalCount();
	
	//검색
	public List<QnAVO> searchNoticeList(Map<String, Object> param);
	
	//사용자 아이디로 작성한 Q&A게시글 불러오기
	public List<QnAVO> getPagingListById(@Param("cri")CriteriaDTO cri, @Param("memId")String memId);
	public int getTotalCountById(String memId);
	
	//최근 게시물로 불러오기(날짜 정렬)
	public List<QnAVO> getListByRegDate();
	
	
	
}	
