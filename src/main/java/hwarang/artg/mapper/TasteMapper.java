package hwarang.artg.mapper;

import java.util.List;

import hwarang.artg.member.model.TasteVO;

public interface TasteMapper {
	public int insertTaste(TasteVO t);
	public int updateTaste(TasteVO t);
	public int deleteTaste(String taste_name);
	public TasteVO selectTaste(String taste_name);
	public List<TasteVO> selectAllTaste();
}
