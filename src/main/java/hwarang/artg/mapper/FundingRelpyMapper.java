package hwarang.artg.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import hwarang.artg.common.model.CriteriaDTO;
import hwarang.artg.funding.model.FundingReplyVO;

public interface FundingRelpyMapper {
	public int insert(FundingReplyVO vo);
	public FundingReplyVO read(long rno);
	public int delete(Long rno);
	public int update(FundingReplyVO vo);
	
	public List<FundingReplyVO> getListWithPaging(@Param("cri")CriteriaDTO cri, @Param("funding_num")Long funding_num);
}
