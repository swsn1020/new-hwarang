package hwarang.artg.mapper;

import java.util.List;

import hwarang.artg.common.model.CriteriaDTO;
import hwarang.artg.funding.model.CrowdfundingVO;

public interface CrowdfundingMapper {
	
	public int insertFunding(CrowdfundingVO funding);
	public int updateFunding(CrowdfundingVO funding);
	public int deleteFunding(int funding_num);
	public CrowdfundingVO selectFunding(int funding_num);
	public List<CrowdfundingVO> selectAllFunding();
	
	//'조회'수 증가
	public int updateViewCnt(int funding_num);
	
	//페이징 
	public List<CrowdfundingVO> getListWithPaging(CriteriaDTO cri);
	
	public int getTotalCount(CriteriaDTO cri);

	
}