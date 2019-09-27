package hwarang.artg.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import hwarang.artg.common.model.CriteriaDTO;
import hwarang.artg.manager.model.ReportImgVO;
import hwarang.artg.manager.model.ReportVO;

public interface ReportMapper {
	public int insertReport(ReportVO report);
	public int updateReport(ReportVO report);
	//답변 등록(수정)
	public int updateReply(@Param("num")int num, @Param("reply")String reply);
	public int deleteReport(int num);
	public ReportVO selectReport(int num);
	public List<ReportVO> selectAllReports();
	
	//첨부파일을 위한 업로드 메서드
	public int insertFile(ReportImgVO qImg);
	
	//페이징 처리
	public List<ReportVO> getListWithPaging(CriteriaDTO cri);
	public int getTotalCount();
	
	//게시글 검색
	public List<ReportVO> searchNoticeList(Map<String, Object> param);
	
	
}
