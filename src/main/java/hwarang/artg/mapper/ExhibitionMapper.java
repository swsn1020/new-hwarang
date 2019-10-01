package hwarang.artg.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import hwarang.artg.common.model.CriteriaDTO;
import hwarang.artg.exhibition.model.ExhibitionVO;

public interface ExhibitionMapper {
	public int insert(ExhibitionVO exh);
	public int update(ExhibitionVO exh);
	public int delete(int exh_seq);
	public ExhibitionVO select(int exh_seq);
	public ExhibitionVO selectOne(@Param("exh_seq") int exh_seq,  @Param("member_id") String member_id);
	public List<ExhibitionVO> selectAll(String area);
	public List<ExhibitionVO> getListWithPaging(@Param("cri")CriteriaDTO cri, @Param("exh") ExhibitionVO exh, @Param("member_id") String member_id);
	public List<ExhibitionVO> getListMain(@Param("cri")CriteriaDTO cri, @Param("member_id") String member_id);
	public int getTotalCount(@Param("cri")CriteriaDTO cri, @Param("exh") ExhibitionVO exh);
	public List<String> getExhRealmName();
	public List<String> getExhArea();
	public List<String> getExhPlace();
	public List<ExhibitionVO> getPlaceList(String area);
	public ExhibitionVO getPlaceByPseq(String placeseq);
	public List<ExhibitionVO> getListByPlace(String placeseq);
}
