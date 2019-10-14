package hwarang.artg.mapper;

import hwarang.artg.exhibition.model.ExhLikeVO;
import hwarang.artg.exhibition.model.ExhibitionVO;

public interface ExhibitionLikeMapper {
	public int insert(ExhLikeVO like);
	public int update(ExhLikeVO like);
	public int delete(ExhLikeVO like);
}
