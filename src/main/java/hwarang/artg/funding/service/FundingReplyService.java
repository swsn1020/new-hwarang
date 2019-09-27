package hwarang.artg.funding.service;

import java.util.List;

import hwarang.artg.common.model.CriteriaDTO;
import hwarang.artg.funding.model.FundingReplyVO;

public interface FundingReplyService {
	public int register(FundingReplyVO vo);
	
	public FundingReplyVO get(Long rno);
	
	public int modify(FundingReplyVO vo);
	
	public int remove(Long rno);
	
	public List<FundingReplyVO>getList(CriteriaDTO cri, Long funding_num);
}
