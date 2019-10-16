package hwarang.artg.funding.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import hwarang.artg.funding.model.OrderVO;
import hwarang.artg.mapper.FundingOrderMapper;
import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class FundingOrderServiceImpl implements FundingOrderService{
	
	@Autowired
	FundingOrderMapper mapper;

	@Override
	public OrderVO select(int order_seq_num) {
		return mapper.getOne(order_seq_num);
	}

	@Override
	public int insertOrder(OrderVO order) {
		return mapper.insertOrder(order);
	}
	
}
