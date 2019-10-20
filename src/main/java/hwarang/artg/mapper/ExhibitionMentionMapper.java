package hwarang.artg.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import hwarang.artg.common.model.CriteriaDTO;
import hwarang.artg.exhibition.model.ExhibitionMentionVO;

public interface ExhibitionMentionMapper {
	public int insert(ExhibitionMentionVO vo);
	public int update(ExhibitionMentionVO vo);
	public int delete(int mention_no);
	public ExhibitionMentionVO select(int mention_no);
	public List<ExhibitionMentionVO> selectAll();
	public List<ExhibitionMentionVO> selectListBySeq(@Param("cri")CriteriaDTO cri, @Param("exh_seq") int exh_seq);
	public int getTotalCount(int exh_seq);
	public int getMentionStatus(@Param("member_id") String member_id, @Param("exh_seq")int exh_seq);
}
