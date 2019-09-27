package hwarang.artg.funding.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import hwarang.artg.common.model.CriteriaDTO;
import hwarang.artg.funding.model.FundingReplyVO;
import hwarang.artg.mapper.FundingRelpyMapper;
import lombok.Setter;

@Service
public class FundingReplyServiceImpl implements FundingReplyService{

	@Setter(onMethod_ = @Autowired)
	private FundingRelpyMapper mapper;
	
	@Override
	public int register(FundingReplyVO vo) {
		// TODO Auto-generated method stub
		return mapper.insert(vo);
	}

	@Override
	public FundingReplyVO get(Long rno) {
		// TODO Auto-generated method stub
		return mapper.read(rno);
	}

	@Override
	public int modify(FundingReplyVO vo) {
		// TODO Auto-generated method stub
		return mapper.update(vo);
	}

	@Override
	public int remove(Long rno) {
		// TODO Auto-generated method stub
		return mapper.delete(rno);
	}

	@Override
	public List<FundingReplyVO> getList(CriteriaDTO cri, Long funding_num) {
		// TODO Auto-generated method stub
		return mapper.getListWithPaging(cri, funding_num);
	}
	
}
