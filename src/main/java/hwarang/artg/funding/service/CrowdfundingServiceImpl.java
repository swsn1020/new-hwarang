package hwarang.artg.funding.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import hwarang.artg.common.model.CriteriaDTO;
import hwarang.artg.funding.model.CrowdfundingVO;
import hwarang.artg.mapper.CrowdfundingMapper;
import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class CrowdfundingServiceImpl implements CrowdfundingService{
	
	@Autowired
	private CrowdfundingMapper mapper;

	@Override
	public void register(CrowdfundingVO funding) {
		mapper.insertSelectKey(funding);
	}

	@Override
	public CrowdfundingVO get(int num) {
		return mapper.read(num);
	}

	@Override
	public boolean modify(CrowdfundingVO funding) {
		return mapper.update(funding)==1;
	}

	@Override
	public boolean remove(int num) {
		return mapper.delete(num)==1;
	}

	@Override
	public List<CrowdfundingVO> getList(CriteriaDTO cri) {
		return mapper.getListWithPaging(cri);
	}

	@Override
	public int getTotal(CriteriaDTO cri) {
		return mapper.getTotalCount(cri);
	}

	@Override
	public CrowdfundingVO payment(int funding_num) {
		// TODO Auto-generated method stub
		return mapper.payment(funding_num);
	}
	
	
	
}
