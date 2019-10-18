package hwarang.artg.mapper;

import hwarang.artg.community.model.FreeLikeVO;
import hwarang.artg.exhibition.model.ExhLikeVO;

public interface FreeBoardLikeMapper {
	public int insert(FreeLikeVO like);
	public int update(FreeLikeVO like);
	public int delete(FreeLikeVO like);
}
