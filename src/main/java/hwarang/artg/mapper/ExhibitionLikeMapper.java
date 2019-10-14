package hwarang.artg.mapper;

import hwarang.artg.exhibition.model.ExhLikeVO;

public interface ExhibitionLikeMapper {
	public int insert(ExhLikeVO like);
	public int update(ExhLikeVO like);
	public int delete(ExhLikeVO like);
}
