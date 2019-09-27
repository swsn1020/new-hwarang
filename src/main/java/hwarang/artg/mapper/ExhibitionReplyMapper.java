package hwarang.artg.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import hwarang.artg.common.model.CriteriaDTO;
import hwarang.artg.exhibition.model.ExhibitionReplyVO;

public interface ExhibitionReplyMapper {
	public int insert(ExhibitionReplyVO vo);
	public int update(ExhibitionReplyVO vo);
	public int delete(int reply_num);
	public ExhibitionReplyVO select(int reply_num);
	public List<ExhibitionReplyVO> getListWithPaging(@Param("cri") CriteriaDTO cri, @Param("exh_seq") int exh_seq);
	public int replyCnt(int reply_num);
}
