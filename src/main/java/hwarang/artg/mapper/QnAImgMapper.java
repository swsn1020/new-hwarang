package hwarang.artg.mapper;

import java.util.List;

import hwarang.artg.manager.model.QnAImgVO;

public interface QnAImgMapper {
	//첨부파일을 위한 업로드 메서드
	public int insertFile(QnAImgVO qnaImg);
	public int updateFile(QnAImgVO qnaImg);
	public int deleteFile(String uuid);
	public int deleteFileByQNum(int num);
	public QnAImgVO selectFile(String uuid);
	public List<QnAImgVO> selectFilesByQNum(int num);
	public List<QnAImgVO> selectAllFiles();
}
