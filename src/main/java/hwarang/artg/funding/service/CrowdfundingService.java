package hwarang.artg.funding.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import hwarang.artg.common.model.CriteriaDTO;
import hwarang.artg.funding.model.CrowdfundingVO;
import hwarang.artg.mapper.CrowdfundingMapper;

@Service
public class CrowdfundingService {
	
	@Autowired
	private CrowdfundingMapper dao;
	
	public boolean noticeRegister(CrowdfundingVO funding) {
		if(dao.insertFunding(funding)> 0) {
			return true;
		}
		return false;
	}
	
	public boolean fundingModify(CrowdfundingVO funding) {
		if(dao.updateFunding(funding) > 0) {
			return true;
		}
		return false;
	}
	
	public boolean fundingRemove(int funding_num) {
		if(dao.deleteFunding(funding_num) > 0) {
			return true;
		}
		return false;
	}
	
	public CrowdfundingVO fundingGetOne(int funding_num) {
		return dao.selectFunding(funding_num);
	}
	
	public List<CrowdfundingVO> fundingGetAll() {
		return dao.selectAllFunding();
	}
	
	//페이징 처리한 list
	public List<CrowdfundingVO> pagingList(CriteriaDTO cri){
		return dao.getListWithPaging(cri);
	}
	
	//검색 기능 추가
	public int getTotalCount(CriteriaDTO cri) {
		return dao.getTotalCount(cri);
	}
	
	
	

	
}