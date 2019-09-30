package hwarang.artg.mapper;

import java.util.List;

import hwarang.artg.funding.model.FundingAttachVO;

public interface FundingAttachMapper {
	public void insert(FundingAttachVO vo);
	
	public void delete(String uuid);
	
	public List<FundingAttachVO> findByNum(int funding_num);
}
