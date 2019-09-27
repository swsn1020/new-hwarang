package hwarang.artg.mapper;

import java.util.List;

import hwarang.artg.community.model.FreeImgVO;

public interface FreeImgMapper {
	public int insertFile(FreeImgVO freeimg);
	public int updateFile(FreeImgVO freeimg);
	public int deleteFile(String uuid);
	public int deleteFileByFNum(int num);
	public FreeImgVO selectFile(String uuid);
	public List<FreeImgVO> selectFilesByFNum(int num);
	public List<FreeImgVO> selectAllFiles();
}
