package hwarang.artg.mapper;

import java.util.List;

import hwarang.artg.manager.model.ReportImgVO;

public interface ReportImgMapper {
	//첨부파일을 위한 업로드 메서드
		public int insertFile(ReportImgVO reportImg);
		public int updateFile(ReportImgVO qnaImg);
		public int deleteFile(String uuid);
		public int deleteFileByRNum(int num);
		public ReportImgVO selectFile(String uuid);
		public List<ReportImgVO> selectFilesByRNum(int num);
		public List<ReportImgVO> selectAllFiles();
}
