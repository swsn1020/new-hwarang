package hwarang.artg.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import hwarang.artg.common.model.CriteriaDTO;
import hwarang.artg.funding.model.CrowdfundingVO;

public interface CrowdfundingMapper {
	
	/*public int insert(CrowdfundingVO crowdfundingVO);
	public int update(CrowdfundingVO crowdfundingVO);
	public int delete(int num);
	public CrowdfundingVO select(int num);
	public List<CrowdfundingVO> selectAll();
	public int updateReadCount(int num);*/
	
	public List<CrowdfundingVO> getList();
    public List<CrowdfundingVO> getListWithPaging(CriteriaDTO cri);
    public void insert(CrowdfundingVO funding_num);
    public void insertSelectKey(CrowdfundingVO funding_num);
    public CrowdfundingVO read(int funding_num);
    public int delete(int funding_num);
    public int update(CrowdfundingVO funding_num);
    public int getTotalCount(CriteriaDTO cri);
    public void updateReplyCnt(@Param("funding_num") int funding_num, @Param("amount") int amount);
	public CrowdfundingVO payment(int funding_num);
}
